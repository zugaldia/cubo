module
cubo_label(text = "cubo", text_size = 10)
{
    color("#E95420") linear_extrude(1)
        text(text,
             size = text_size,
             font = "Ubuntu Condensed",
             halign = "center",
             valign = "center");
}

cubo_label("This is a test.");
