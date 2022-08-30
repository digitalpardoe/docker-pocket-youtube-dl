FROM ubuntu:jammy

RUN apt-get update && \
    apt-get install -qq --no-install-recommends -y \
      cron \
      ffmpeg \
      ruby \
      ruby-json \
      python3 \
      python3-pip \
      python3-pycryptodome \
      python3-websockets \
      python3-mutagen

RUN apt-get clean && apt-get autoclean
RUN rm -rf /var/lib/apt/lists/*

RUN touch /var/log/cron.log

RUN pip install --upgrade yt-dlp

ENV POCKET_CONSUMER_KEY=""
ENV POCKET_ACCESS_TOKEN=""

VOLUME ["/downloads"]

COPY ["pocket-youtube-dl.rb", "/usr/local/bin/pocket-youtube-dl"]

ENV PUID=0
ENV PGID=0

COPY ["entrypoint.sh", "/usr/local/bin/entrypoint.sh"]

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

LABEL org.opencontainers.image.source https://github.com/digitalpardoe/docker-pocket-youtube-dl