# rroemhild/errbot

- [Introduction](#introduction)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
    - [Image Runtime Config](#image-runtime-config)
    - [Bot Runtime Config](#bot-runtime-config)
- [Persistence](#persistence)
- [Use your own config file](#use-your-own-config-file)
- [Run Err with extra arguments](#run-err-with-extra-arguments)
    - [Alternative config file](#alternative-config-file)
    - [Err Help](#err-help)
    - [Run with text debug backend](#run-with-text-debug-backend)
- [Exposed Ports](#exposed-ports)

# Introduction

Dockerfile to build an [Errbot](http://errbot.io) (the pluggable chatbot) container image.

Current Version: `4.0.3`

# Quick Start

```
docker run -d \
    --name err \
    -e BOT_USERNAME=err@xmmp.local \
    -e BOT_PASSWORD=errbotpwd \
    -e BOT_ADMINS=admin@xmpp.local \
    -e CHATROOM_PRESENCE=err@conference.xmpp.local \
    -e "TZ=Europe/Berlin" \
    rroemhild/err
```

or try the docker compose example

```bash
wget https://raw.githubusercontent.com/rroemhild/docker-err/master/docker-compose.yml
docker-compose up
```

# Configuration

## Image Runtime Config

- **WAIT**: Seconds to sleep before starting the bot. Defaults to `None`

## Bot Runtime Config

Below is the complete list of available options that can be used to customize your Err bot. See [config-template.py](https://raw.githubusercontent.com/gbin/err/master/errbot/config-template.py) for complete settings documentation.

- **BACKEND**: Chat server type. (XMPP, Text, HipChat, Slack, IRC). Defaults to `XMPP`.
- **BOT_LOG_LEVEL**: Change log level. Defaults to `INFO`.
- **BOT_USERNAME**: The UID for the bot user.
- **BOT_PASSWORD**: The corresponding password for the user.
- **BOT_TOKEN**: Token for HipChat and Slack backend.
- **BOT_SERVER**: Server address for XMPP and HipChat.
- **BOT_PORT**: Server port.
- **BOT_SSL**: Use SSL for IRC backend. Default to `False`.
- **BOT_ENDPOINT**: HipChat endpoint for hosted HipChat.
- **BOT_NICKNAME**: Nickname for IRC backend.
- **BOT_ADMINS**: Bot admins separated with comma. Defaults to `admin@localhost`.
- **CHATROOM_PRESENCE**: Chatrooms your bot should join on startup.
- **CHATROOM_FN**: The FullName, or nickname, your bot should use. Defaults to `Err`.
- **XMPP_CA_CERT_FILE**: Path to a file containing certificate authorities. Default to `None`.
- **BOT_PREFIX**: Command prefix for the bot. Default to `!`.
- **BOT_PREFIX_OPTIONAL_ON_CHAT**: Optional prefix for normal chat. Default to `False`.
- **BOT_ALT_PREFIXES**: Alternative prefixes.
- **BOT_ALT_PREFIX_SEPARATORS**: Alternative prefixes separators.
- **BOT_ALT_PREFIX_CASEINSENSITIVE**:  Require correct capitalization. Defaults to `False`.
- **HIDE_RESTRICTED_COMMANDS**: Hide the restricted commands from the help output. Defaults to `False`.
- **HIDE_RESTRICTED_ACCESS**: Do not reply error message. Defaults to `False`.
- **DIVERT_TO_PRIVATE**: Private commands.
- **MESSAGE_SIZE_LIMIT**: Maximum length a single message may be. Defaults to `10000`.

# Persistence

For storage of the application data, you should mount a volume at

* `/srv`

Create the directories for the volume

```bash
mkdir /tmp/errbot /tmp/errbot/ssl /tmp/errbot/data /tmp/errbot/plugins
chmod -R 777 /tmp/errbot
```

# Use your own config file

```bash
curl -sL https://raw.githubusercontent.com/gbin/err/master/errbot/config-template.py -o /tmp/errbot/config.py
```

# Run Err with extra arguments

If you pass arguments to Errbot you have to set the `-c /srv/config.py` argument by your self to run with the default config.

## Alternative config file

```bash
docker run -it -v /tmp/errbot:/srv rroemhild/errbot -c /srv/production.py
```

## Err Help

```bash
$ docker run rroemhild/errbot -h
```

## Run with text debug backend

```bash
docker run -it -v /tmp/errbot:/srv rroemhild/errbot -c /srv/config.py -T
```

# Exposed Ports

* 3142 (Webserver if configured)
