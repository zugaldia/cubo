OPENSCAD=/usr/bin/openscad-nightly
SLICER=/home/antonio/code/tools/prusa/PrusaSlicer-2.6.1+linux-x64-GTK3-202309060711.AppImage
OUTPUT_STL=stl
OUTPUT_IMAGES=png
OUTPUT_GCODE=gcode

EXTENSION_OPTIONS = stl png
PCB_OPTIONS = nopcb arduinoleonardo arduinonano arduinouno3 rpi3 rpi4 rpipico rpi0
CONNECTOR_OPTIONS = insert nut
FILL_OPTIONS = filled empty
GRID_NAME_OPTIONS = flatiron latitude longitude gruyere
GRID_SIZE_OPTIONS = small medium
MOUNTING_OPTIONS = m25 m3 m4 vesa
BASE_OPTIONS = with_base free_standing

#
# default target
#

all: cubo slice

#
# uses `npm install -g openscad-format`
#

format:
	openscad-format -f -i '*.scad'

#
# cleaning rules
#

clean: clean-openscad clean-prusaslicer

clean-openscad:
	rm -rf $(OUTPUT_STL) $(OUTPUT_IMAGES) build.log
	mkdir $(OUTPUT_STL) $(OUTPUT_IMAGES)

clean-prusaslicer:
	rm -rf $(OUTPUT_GCODE) slice.log
	mkdir $(OUTPUT_GCODE)

#
# generate all files
#

cubo-bottom: 
	@for EXTENSION in $(EXTENSION_OPTIONS); do \
		for CONNECTOR in $(CONNECTOR_OPTIONS); do \
			for PCB in $(PCB_OPTIONS); do \
				FILENAME=$$EXTENSION/cubo_bottom_$$CONNECTOR\_$$PCB.$$EXTENSION ; \
				echo "Generating: $$FILENAME" ; \
				$(OPENSCAD) \
					-D cubo_connector=\"$$CONNECTOR\" \
					-D pcb_name=\"$$PCB\" \
					-o $$FILENAME \
					cubo_side_bottom.scad >> build.log 2>&1 ; \
			done \
		done \
	done

cubo-top:
	@for EXTENSION in $(EXTENSION_OPTIONS); do \
		for CONNECTOR in $(CONNECTOR_OPTIONS); do \
			for FILL in $(FILL_OPTIONS); do \
				FILENAME=$$EXTENSION/cubo_top_$$CONNECTOR\_$$FILL.$$EXTENSION ; \
				echo "Generating: $$FILENAME" ; \
				$(OPENSCAD) \
					-D cubo_connector=\"$$CONNECTOR\" \
					-D cubo_fill=\"$$FILL\" \
					-o $$FILENAME \
					cubo_side_top.scad >> build.log 2>&1 ; \
			done \
		done \
	done

cubo-basic-sides:
	@for EXTENSION in $(EXTENSION_OPTIONS); do \
		FILENAME=$$EXTENSION/cubo_generic.$$EXTENSION ; \
		echo "Generating: $$FILENAME" ; \
		$(OPENSCAD) -o $$FILENAME cubo_side_generic.scad >> build.log 2>&1 ; \
	done
	@for EXTENSION in $(EXTENSION_OPTIONS); do \
		FILENAME=$$EXTENSION/cubo_empty.$$EXTENSION ; \
		echo "Generating: $$FILENAME" ; \
		$(OPENSCAD) -o $$FILENAME cubo_side_empty.scad >> build.log 2>&1 ; \
	done
	@for EXTENSION in $(EXTENSION_OPTIONS); do \
		FILENAME=$$EXTENSION/cubo_arch.$$EXTENSION ; \
		echo "Generating: $$FILENAME" ; \
		$(OPENSCAD) -o $$FILENAME cubo_side_arch.scad >> build.log 2>&1 ; \
	done

cubo-grid:
	@for EXTENSION in $(EXTENSION_OPTIONS); do \
		for GRID_NAME in $(GRID_NAME_OPTIONS); do \
			for GRID_SIZE in $(GRID_SIZE_OPTIONS); do \
				FILENAME=$$EXTENSION/cubo_grid_$$GRID_NAME\_$$GRID_SIZE.$$EXTENSION ; \
				echo "Generating: $$FILENAME" ; \
				$(OPENSCAD) \
					-D grid_name=\"$$GRID_NAME\" \
					-D grid_size=\"$$GRID_SIZE\" \
					-o $$FILENAME \
					cubo_side_grid.scad >> build.log 2>&1 ; \
			done \
		done \
	done

cubo-utils:
	@for EXTENSION in $(EXTENSION_OPTIONS); do \
		for MOUNTING in $(MOUNTING_OPTIONS); do \
			FILENAME=$$EXTENSION/cubo_mounting_plate_$$MOUNTING.$$EXTENSION ; \
			echo "Generating: $$FILENAME" ; \
			$(OPENSCAD) \
				-D mounting_type=\"$$MOUNTING\" \
				-o $$FILENAME cubo_mounting_plate.scad >> build.log 2>&1 ; \
		done \
	done
	@for EXTENSION in $(EXTENSION_OPTIONS); do \
		for BASE in $(BASE_OPTIONS); do \
			FILENAME=$$EXTENSION/cubo_stand_$$BASE.$$EXTENSION ; \
			echo "Generating: $$FILENAME" ; \
			$(OPENSCAD) \
				-D stand_type=\"$$BASE\" \
				-o $$FILENAME cubo_stand.scad >> build.log 2>&1 ; \
		done \
	done
	@for EXTENSION in $(EXTENSION_OPTIONS); do \
		FILENAME=$$EXTENSION/cubo_tray.$$EXTENSION ; \
		echo "Generating: $$FILENAME" ; \
		$(OPENSCAD) -o $$FILENAME cubo_tray.scad >> build.log 2>&1 ; \
	done

cubo: clean-openscad cubo-bottom cubo-top cubo-basic-sides cubo-grid cubo-utils
	@$(OPENSCAD) -o $(OUTPUT_IMAGES)/cubo.png cubo_assembled.scad

#
# Get printing time from the gcodes:
# find gcode -type f -exec echo \{\} \; -exec grep "normal mode" \{\} \;
#

slice: clean-prusaslicer
	@for FILENAME in stl/*stl; do \
		echo "Slicing: $$FILENAME" ; \
		$(SLICER) --export-gcode --load assets/slicer.ini \
			--output `echo $$FILENAME | sed 's/stl/gcode/g'` \
	 		$$FILENAME >> slice.log 2>&1 ; \
	done
