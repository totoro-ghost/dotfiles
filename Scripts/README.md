# My Scripts

My Collection of Scripts.

## Description of scripts

- `alacritty` - this contains some scripts related to alacritty
- `asciiart` - some ascii art, one of them i use for neofetch
- `basic` - this contains notifications scripts for brightness, volume, mic
- `dmenu` - this contains dmenu scripts
- `firefox` - this contain firefox related scripts
- `i3` - contain i3 related script
- `i3lock` - contain lockscreen scripts
- `info` - just some info script i was trying to make
- `music` - this contains scripts i bound to shortcut keys on my keyboard, to play, stop music, it stops every player running, etc.
- `ocr` - this contain a script which take screenshot and then copy the text to clipboard, OCR used [tesseract](https://github.com/tesseract-ocr/tesseract)
- `palettes` - contain some palletes for imagegonord
- `image_nord.py` - test script for imagegonord
- `idleshutdown` - turns off pc if you forget touching it for two hours
- `resol.sh` - fix the resolution, i use it sometimes
- `screenshot` - i use this with rofi-screenshot, [here is repo](https://github.com/totoro-ghost/screenshot)
- `wallpaper.sh` - i use this to set wallpaper, and i link this everywhere i need to change wallpaper

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