#!/bin/bash
# Screen Recorder
DIRECTORY=/home/christophe/Vidéos/ScreenCaptures
TIME=$( date +'%Y-%m-%d_%H:%M' )

# Capture Screen or stream
ffmpeg -y -loglevel error -hide_banner -nostats \
-f acompressor=threshold=0.089:ratio=9:attack=200:release=1000 \
-f pulse -ac 2 -ar 48000 -i alsa_output.usb-SteelSeries_SteelSeries_Arctis_5_00000000-00.analog-game.monitor \
-f pulse -ac 2 -ar 48000 -i alsa_input.usb-SteelSeries_SteelSeries_Arctis_5_00000000-00.analog-chat \
-filter_complex amix=inputs=2 \
-f x11grab -hwaccel auto -framerate 60 -video_size 2560x1440 -i :1 \
-c:v h264_nvenc \
-c:a libvorbis -strict -2 -b:a 320k \
-nostdin /home/christophe/Vidéos/ScreenCaptures/tmp.mkv \
# Stream to Twitch
#"rtmp://live.twitch.tv/app/xxxxxxxxxxxxxxx"

# Rename the file tmp.mkv
mv $DIRECTORY/tmp.mkv $DIRECTORY/ENCODEC_AT_$TIME.mkv
sleep 3s

# Encodage VP9
ffmpeg -y -loglevel error -hide_banner -i $DIRECTORY/ENCODEC_AT_$TIME.mkv -framerate 60 -c:v libvpx-vp9 -cpu-used 0 -pix_fmt yuva420p -b:v 0 -crf 30 -row-mt 1 -f webm $DIRECTORY/Record_AT_$TIME.webm
sleep 3s

# Delete file capture not compressing
rm -rf $DIRECTORY/ENCODEC_AT_$TIME.mkv

exit 0
