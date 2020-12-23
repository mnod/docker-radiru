#! /usr/bin/env python3

import xml.etree.ElementTree as ET
import requests                                                                                                           
import sys
from datetime import datetime
import subprocess

def get_m3u8(targetarea='tokyo', station='fm'):
    hls = station + "hls"
    url = 'https://www.nhk.or.jp/radio/config/config_web.xml'
    try:
        r = requests.get(url)
        if r.status_code != 200:
            raise Exception("unexpected code")
    except Exception as E:
        print(str(E))
        sys.exit(1)
     
    root = ET.fromstring(r.text)
    config_dict = []
    for data in root.iter('data'):
        area = data.find('area').text
        r1hls = data.find('r1hls').text
        r2hls = data.find('r2hls').text
        fmhls = data.find('fmhls').text
        config_dict.append({"area": area, "r1hls":r1hls, "r2hls":r2hls, "fmhls":fmhls})

    for d in config_dict:
        if d['area'] == targetarea:
            return(d[hls])

def main():
    targetarea  = 'tokyo'
    workdir     = '/media/recorder'
    stationlist = {
        "NHK-FM":"fm",
        "NHKR1":"r1",
        "NHKR2":"r2"
    }

    if len(sys.argv) >= 5 or len(sys.argv) <=2:
        print("error")
        sys.exit(1)
    stationname = sys.argv[1]
    minutes     = sys.argv[2]
    try:
        comment = sys.argv[3]
    except Exception as E:
        comment = ""

    timestamp  = datetime.now().strftime('%Y%m%dT%H%M%S')
    m3u8       = get_m3u8(station=stationlist[stationname])
    seconds    = int(minutes) * 60
    if comment != "":
        filename = workdir + "/" + timestamp + "_" + stationname + "_" + comment + ".m4a"
    else:
        filename = workdir + "/" + timestamp + "_" + stationname + ".m4a"
    subprocess.run(["ffmpeg", "-i", m3u8, "-t", str(seconds), "-c", "copy", filename])

if __name__ == '__main__':
    main()
