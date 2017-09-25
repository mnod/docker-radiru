#! /bin/bash

workdir=/media/recorder
test -d ${workdir} || exit

test $# -gt 3 && exit
station=$1
minutes=$2
comment=$3

timestamp=`TZ='Asia/Tokyo' date +%Y%m%dT%H%M%S`
length=`expr ${minutes} \* 60 + 60`

case $station in
  "NHKR1")
    url=https://nhkradioakr1-i.akamaihd.net/hls/live/511633/1-r1/1-r1-01.m3u8
    ;;
  "NHKR2")
    url=https://nhkradioakr2-i.akamaihd.net/hls/live/511929/1-r2/1-r2-01.m3u8
    ;;
  "NHK-FM")
    url=https://nhkradioakfm-i.akamaihd.net/hls/live/512290/1-fm/1-fm-01.m3u8
    ;;
  *)
    exit
    ;;
esac

if [ -z "$comment" ]; then
  filename=${workdir}/${timestamp}_${station}.m4a
else
  filename=${workdir}/${timestamp}_${station}_${comment}.m4a
fi

ffmpeg -i ${url} -to ${length} -c copy ${filename}
