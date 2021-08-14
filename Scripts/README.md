# My Scripts

My Collection of Scripts.

## Tips

### youtube-dl

- for large files

```
youtube-dl [VideoUrl] -f 140 --external-downloader aria2c --external-downloader-args "-j 12 -s 12 -x 12 -k 5M"
```

- for small files

```
youtube-dl [VideoUrl] -f 140 --external-downloader aria2c --external-downloader-args "-j 8 -s 8 -x 8 -k 5M"
```

- `-x` for audio

## ffmpeg

- merge audio and video into a single file

```
ffmpeg -i [video.mp4] -i [audio.mp3] -c:v copy -c:a [out.mp4]
```

## google test to speech api

```
wget -q -U Mozilla -O output.mp3 "http://translate.google.com/translate_tts?ie=UTF-8&total=1&idx=0&textlen=32&client=tw-ob&q=test&tl=En-gb"
```