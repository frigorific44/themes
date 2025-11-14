# Themes
This is a repository of my personal setup for maintaining cohesive themes. Contained are template files for theming various programs, the themes themselves, as well as themes and scripts to facilitate a theme which changes throughout the year. Template files are substituted with a theme's color and then distributed across the file system.

## Requirements

Beyond basic Linux shell utilities, [pastel](https://github.com/sharkdp/pastel) is also used for color manipulation and display in the terminal.

## Usage

Running any of the shell scripts without any arguments produces their basic usage. The exception to this is `gen_seasonal`.

Basic usage entails invoking `run.sh` with the theme you wish to use as an argument:

```
./run.sh themes/gruvbox.theme
```

It is strongly advised that you check the file paths contained in the template files to ensure each one matches your system's configuration locations. Along with this suggestion, `run.sh` does not create directories by default, as if a directory doesn't exist, there's a chance you don't need that template and its respective configuration clutter.

## Themes

Each theme contains in sequence a background, accent, and foreground color, as well as the the six hues used in the first 16 ANSI terminal colors: red, yellow, green, cyan, blue, and magenta. Comments in theme files can begin with the pound symbol `#`, and each color can be defined in any format interpretable by pastel. Hue shades are handled within each template by substitutions using the shell function `l-adj`, as different programs and toolkits require different amounts of granularity, though the luminosity has a set step distance to achieve a modicum of consistency.

## Templates

The first line of each template file is its location in the file system. Shell variables such as `$fg` defined in `run.sh`, or environmental variables like `$HOME` will be substituted. Command substitutions can also be made within pairs of `%( )%`.

## Seasons

My current preferred usage of this repository is to utilize seasonal themes. Invoking `seasons/gen_seasonal.sh` will create a new theme with colors interpolated based on the current time of year, automatically invoking `run.sh` on the generated seasonal theme. The content of the themes contained in `seasons/` are formatted the same as those contained in `themes/`, except their names correspond to their beginning date to mark what colors should be interpolated between. There can be any number of seasonal themes, but the ones I use correspond to the four seasons. The interpolation is done on a polar representation of the colors, so this should be kept in mind when creating seasonal themes, and you can use `seasons/compare.sh` to check that the interpolations between themes are satisfactory.
