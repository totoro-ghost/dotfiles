# rofi-bookmarks
Small python script to open firefox bookmarks with rofi.

![rofi-bookmarks showcase](images/rofi-bookmarks_showcase.png)

## Features
* Icons!
* Only show bookmarks in a specified bookmark folder
* Show entire path for bookmarks in folders

## How to use
Needs python 3.7 or higher (and rofi)

Put rofi-bookmarks.py somewhere in `$PATH` and run rofi with:
```
rofi -show bookmarks -modi 'bookmarks: rofi-bookmarks.py <arguments>'
```
or add `bookmarks: rofi-bookmarks.py <arguments>` to `modi` in `config.rasi`
and then run rofi with
```
rofi -show bookmarks
```

## Options
* Specify search-path by adding it as argument (/ separated)
  ```
  rofi-bookmarks.py 'path/to/folder'
  ```
* `--separator` changes folder separator (default: ' / '), *only for display, search path still uses '/'*
  ```
  rofi-bookmarks.py --separator '\'
  ```
* `--profile` changes firefox profile, if default selection isn't the correct one
  ```
  rofi-bookmarks.py --profile alternate-profile
  ```
