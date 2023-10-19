module
cubo_label(text = "cubo", text_size = 10)
{
    linear_extrude(1)
        text(text,
             size = text_size,
             font = "Ubuntu Condensed",
             halign = "center",
             valign = "center");
}

color("#E95420")
cubo_label("This is a test.");
