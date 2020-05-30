This image polls the Pocket API and downloads any YouTube videos it finds in your "My List" before archiving the video in Pocket.

For this to work you'll need a
Pocket access token which you can get by following the instructions here: [https://www.jamesfmackenzie.com/getting-started-with-the-pocket-developer-api/](https://www.jamesfmackenzie.com/getting-started-with-the-pocket-developer-api/).

I mostly put this together for automatically pulling videos into Plex on a Synology.

The default configuration attempts to download the highest quality MP4 it can and
names it as the title of the video.

This image isn't interactive, you won't see much, if any, output when it runs.

## Usage

```
docker run \
  -e POCKET_CONSUMER_KEY=<your-pocket-consumer-key> \
  -e POCKET_ACCESS_TOKEN=<your-pocket-access-token> \
  -v </path/to/downloads/folder>:/downloads \
  digitalpardoe/pocket-youtube-dl
```

## Parameters

* `-v /downloads` - folder videos are downloaded to

## Environmental Variables

### Required

* `POCKET_CONSUMER_KEY` - your pocket application consumer key
* `POCKET_ACCESS_TOKEN` - your pocket access token

### Optional

* `YOUTUBE_DL_OUTPUT_TEMPLATE` - youtube-dl output template
* `YOUTUBE_DL_DOWNLOAD_FORMAT` - youtube-dl download format specification