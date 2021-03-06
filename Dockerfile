FROM alpine:3.13

RUN apk add --no-cache ruby ffmpeg ruby-json python3 py3-pip
RUN pip install --upgrade youtube-dl

ENV POCKET_CONSUMER_KEY=""
ENV POCKET_ACCESS_TOKEN=""

VOLUME ["/downloads"]

COPY ["pocket-youtube-dl.rb", "/usr/local/bin/pocket-youtube-dl"]

RUN echo '* * * * * /usr/local/bin/pocket-youtube-dl' > /etc/crontabs/root

CMD ["/usr/sbin/crond", "-f"]

LABEL org.opencontainers.image.source https://github.com/digitalpardoe/docker-pocket-youtube-dl