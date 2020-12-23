From debian:buster-slim
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    ffmpeg \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* \
&& pip3 install requests

ADD ["rec_radio.py", "/usr/local/bin/rec_radio.py"]
RUN chmod +x /usr/local/bin/rec_radio.py
VOLUME ["/media/recorder"]
ENTRYPOINT ["/usr/local/bin/rec_radio.py"]
