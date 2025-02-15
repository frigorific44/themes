# Themes
This is a repository of my personal setup for maintaining cohesive themes. Each sub-directory (currently only gruvbox) is a theme for use across multiple applications. Within each theme is a set of template files. The first line of each template file is its location in the file system, and the rest is the theme file as it will be, save for variables that will be replaced by the shell script. The actual colors are contained within the shell script and are generally intended to be robust enough to cover the various needs of the applications they theme.
## Usage
Using the shell script within the theme directory should be the extent of what you need to do. However, before doing so, it's worth checking the above mention file paths in the first line of each theme template to ensure it matches the template directories on your system.
``./gruvbox/gruvy.sh``
