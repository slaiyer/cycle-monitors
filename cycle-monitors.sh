#!/bin/bash

####################################################################
# For current viewport information, in a fullscreen xterm:
#   `xdotool getwindowgeometry --shell "$(xdotool getactivewindow)"`
# To do:
#   - Load monitor configuration from ~/.config/monitors.xml
#   - Daemonize at startup
#       - Listen for hotkeys
#       - Maintain details of MRU window in each monitor
####################################################################

#####################
# CONFIGURATION BEGIN

# Monitor sequence
C=0 # Center
L=1 # Left
R=2 # Right

# Monitor resolutions
#       X     Y
C_dim=( 1920  1080 )
L_dim=( 1920  1080 )
R_dim=( 1920  1080 )

# CONFIGURATION END
###################

# Minimal edge information required to work with given arrangement
L_Xr=${L_dim[0]}            # | L ] R |
C_Yt=${L_dim[1]}            # --=====--
C_Xl=$(( L_dim[0] / 2 ))    #   [ C |

# Calculate midpoint coordinates of monitors
#      Center                       Left                Right
Xmid=( $(( C_Xl + (C_dim[0] / 2) )) $(( L_dim[0] / 2 )) $(( L_Xr + (R_dim[0] / 2) )) )
Ymid=( $(( C_Yt + (C_dim[1] / 2) )) $(( L_dim[1] / 2 )) $(( R_dim[1] / 2          )) )

# Load current mouse coordinates
eval "$( xdotool getmouselocation --shell )"

# Cycle direction based on optional presence of script argument(s)
if (( "$#" > 0 )); then # Counter-clockwise
    if (( Y > C_Yt )); then
        # C -> R
        next_mon="$R"
    elif (( X < L_Xr )); then
        # L -> C
        next_mon="$C"
    else
        # R -> L
        next_mon="$L"
    fi
else # Clockwise
    if (( Y > C_Yt )); then
        # C -> L
        next_mon="$L"
    elif (( X < L_Xr )); then
        # L -> R
        next_mon="$R"
    else
        # R -> C
        next_mon="$C"
    fi
fi

###########################
# SLOPPY WINDOW FOCUS MODE:

xdotool mousemove "${Xmid[$next_mon]}" "${Ymid[$next_mon]}"

############################
## MANUAL WINDOW FOCUS MODE:
#
## Load active window coordinates
#eval "$(xdotool getwindowgeometry --shell "$(xdotool getactivewindow)")"
#
#get_window_at() {
#    # Move mouse to coordinates; get window ID beneath
#    eval "$(xdotool mousemove --shell "$1" "$2" getmouselocation)"
#
#    # Move mouse to coordinates; get window ID beneath it; restore mouse position
#    #eval "$(xdotool mousemove --shell "$1" "$2" getmouselocation mousemove restore)""
#
#    # Return window ID
#    echo "$WINDOW"
#}
#
#xdotool windowactivate "$(get_window_at "${Xmid[$next_mon]}" "${Ymid[$next_mon]}")"
#
## Inlining function contents does not work for some reason
## Activate window at the center of next monitor
##xdotool windowactivate \
##    "$(eval \
##        "$(xdotool mousemove --shell --sync "${Xmid[$next_mon]}" "${Ymid[$next_mon]}")" getmouselocation; \
##        echo "$WINDOW")"

