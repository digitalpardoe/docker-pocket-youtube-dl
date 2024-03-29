FROM alpine:3.16

RUN apk add --no-cache ffmpeg
RUN apk add --no-cache ruby ruby-json 
RUN apk add --no-cache python3 py3-pip py3-pycryptodomex py3-websockets py3-mutagen

RUN pip install --upgrade yt-dlp

ENV POCKET_CONSUMER_KEY=""
ENV POCKET_ACCESS_TOKEN=""

VOLUME ["/downloads"]

COPY ["pocket-youtube-dl.rb", "/usr/local/bin/pocket-youtube-dl"]

ENTRYPOINT ["/usr/local/bin/pocket-youtube-dl"]

LABEL org.opencontainers.image.source https://github.com/digitalpardoe/docker-pocket-youtube-dl