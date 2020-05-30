#!/bin/bash

readonly OUTPUT="pocket-youtube-dl.tar"

rm $OUTPUT
docker build -t digitalpardoe/pocket-youtube-dl:latest .
docker save digitalpardoe/pocket-youtube-dl:latest > $OUTPUT
