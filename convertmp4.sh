#!/bin/bash

# 前もって brew install MP4Box ; brew install faad2 として MP4Box, faad2 をインストールしておいてください

f=$1
g=`basename "$1" .mp4`
cp "${f}" temp.mp4
/usr/local/bin/MP4Box -raw 2 temp.mp4
if test -f temp_track2.264 ; then
  # track 2 is H264 file; remove it and try again with track 1
  rm temp_track2.264
  /usr/local/bin/MP4Box -raw 1 temp.mp4
  mv temp_track1.aac temp.aac
else
  mv temp_track2.aac temp.aac
fi
rm temp.mp4
/usr/local/bin/faad temp.aac
rm temp.aac
/usr/local/bin/xld --profile aac temp.wav
rm temp.wav
mv temp.m4a "${g}.m4a"
exit 0
