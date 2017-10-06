# cycle-monitors
Cycle mouse pointer through windows in different monitors under X11

Supported monitor arrangement:
```
---------
| L | R |
---------
  | C |
  -----
```

## Prerequisites
- X11
- `xdotool`

## Usage
Create global hotkey binding to:
- `/path/to/cycle-monitors.sh` for clockwise cycling
- `/path/to/cycle-monitors.sh rev` for counter-clockwise cycling

## Configuration
- List monitor sequence
- Supply monitor resolutions

### Test environment
- Center: 1920x1080 12"
- Left:   1920x1080 22"
- Right:  1920x1080 22"
```
$ xdpyinfo | grep version
    version number:    11.0
    X.Org version: 1.19.3

$ xdotool --version
    xdotool version 3.20150503.1
```
