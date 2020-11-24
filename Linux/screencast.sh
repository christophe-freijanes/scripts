#!/bin/bash
# Screen Recorder
DIRECTORY=/home/christophe/Vidéos/ScreenCaptures
TIME=$( date +'%d-%m-%Y_%H:%M' )
# Capture Screen or stream
ffmpeg -y -loglevel error -hide_banner -nostats \
-f acompressor=threshold=0.089:ratio=9:attack=200:release=1000 \
-f pulse -ac 2 -ar 48000 -i alsa_output.usb-SteelSeries_SteelSeries_Arctis_5_00000000-00.analog-game.monitor \
-f pulse -ac 2 -ar 48000 -i alsa_input.usb-SteelSeries_SteelSeries_Arctis_5_00000000-00.analog-chat \
-filter_complex amix=inputs=2 \
-f x11grab -hwaccel auto -framerate 60 -video_size 2560x1440 -i :1 \
-c:a libvorbis -ac 2 -ar 48000 \
-c:v h264_nvenc -profile:v high -preset:v slow -rc vbr_2pass -qmin 17 -qmax 22 -2pass 1 $DIRECTORY/ENCODEC_AT_$TIME.mp4
# Stream to Twitch
#"rtmp://live.twitch.tv/app/xxxxxxxxxxxxxxx"

exit 0
