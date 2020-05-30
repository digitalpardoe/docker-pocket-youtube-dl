#!/bin/bash

docker build -t digitalpardoe/pocket-youtube-dl:latest .
docker save digitalpardoe/pocket-youtube-dl:latest > pocket-youtube-dl.tar