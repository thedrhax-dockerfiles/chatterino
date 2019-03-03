# Chatterino 2 in Docker [![](https://images.microbadger.com/badges/image/thedrhax/chatterino2.svg)](https://hub.docker.com/r/thedrhax/chatterino2)

This image contains a compiled version of [Chatterino 2](https://github.com/fourtf/chatterino2) Twitch chat client. The main purpose of this image is to collect chat logs from multiple channels at the same time.

## Example

The command listed below will save chat logs of channels `channel1` and `channel2` into volume named `logs`.

```
docker run --rm -v logs:/logs -e TZ="Europe/Moscow" -e CHANNELS="channel1 channel2" thedrhax/chatterino2
```