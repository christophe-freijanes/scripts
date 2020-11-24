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
-c:v h264_nvenc -profile:v high -preset:v slow $DIRECTORY/tmp.mov
# Stream to Twitch
#"rtmp://live.twitch.tv/app/xxxxxxxxxxxxxxx"

# Rename the file tmp.mkv
mv $DIRECTORY/tmp.mov $DIRECTORY/ENCODEC_AT_$TIME.mov
sleep 3s

# Encodage VP9
ffmpeg -y -i $DIRECTORY/ENCODEC_AT_$TIME.mov -vf scale=2560x1440 -b:v 10000k \
-minrate 9000k -maxrate 26100k -tile-columns 2 -g 240 -threads 8 \
-quality good -crf 31 -c:v libvpx-vp9 -c:a libvorbis \
-pass 1 -speed 4 -f webm $DIRECTORY/Cast_$TIME.webm && \
ffmpeg -y -i $DIRECTORY/ENCODEC_AT_$TIME.mov -vf scale=2560x1440 -b:v 10000k \
-minrate 9000k -maxrate 26100k -tile-columns 3 -g 240 -threads 8 \
-quality good -crf 31 -c:v libvpx-vp9 -c:a libvorbis \
-pass 2 -speed 4 -y $DIRECTORY/Cast_$TIME.webm \

sleep 3s
# Delete file capture not compressing
rm -rf $DIRECTORY/ENCODEC_AT_$TIME.mov

exit 0
