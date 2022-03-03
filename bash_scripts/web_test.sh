#!/bin/bash

#This is script is for testing goal manager flex

##########################
###### Useful flags ######
##########################
## -d detached mode    ###
## -v split vertically ###
## -h split horizontally #
## -s name the session ###
## -n name the window ####
## C-m enter a command ###
##########################

#var for session name
sn=state_supervisor

# Start the session and name it according to the variable $sn, name the window etc
tmux new-session -s "$sn" -n state_supervisor -d

# If -d is given, the session does not make the new window the current window
# -v: vertical split
# -h: horizontal split
# -t: target pane (followed by desired pane)

tmux split-window -dh $TMUX_PANE
tmux split-window -v $TMUX_PANE
tmux split-window -v -t 0.2 $TMUX_PANE

#Run robot router
tmux send-keys -t 0.0 "google-chrome https://globotix.github.io/webrtc-streaming/" C-m

#Run robot router
tmux send-keys -t 0.1 "python3 ../robot_router.py" C-m

#Launch webrtc server
tmux send-keys -t 0.2 "roslaunch webrtc_ros rs_webrtc_ros.launch" C-m

#Websocket debugging
tmux send-keys -t 0.3 "python -m websockets wss://globotix-webrtc-streaming.herokuapp.com/" 

tmux -2 attach-session -d