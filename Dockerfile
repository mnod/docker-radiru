FROM alpine:latest

RUN apk update \
&& apk add \
   python3 \
   py3-pip \
   ffmpeg \
   tzdata \
&& cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
&& apk del tzdata \
&& rm -rf /var/cache/apk/*

ADD ["rec_radio.py", "/usr/local/bin/rec_radio.py"]
RUN chmod +x /usr/local/bin/rec_radio.py
VOLUME ["/media/recorder"]
ENTRYPOINT ["/usr/local/bin/rec_radio.py"]
