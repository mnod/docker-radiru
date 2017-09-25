From debian:stretch
RUN apt-get update && apt-get install -y \
    ffmpeg \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

ADD rec_radio.sh /usr/local/bin/rec_radio.sh
ENTRYPOINT ["/usr/local/bin/rec_radio.sh"]
