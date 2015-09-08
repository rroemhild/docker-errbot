# docker-err

[Err](http://errbot.net) - the pluggable chatbot

## Image runtime config

Environment       | Default                       | Description
----------------- | ----------------------------- | ----------------
WAIT              | None                          | Seconds to sleep before starting the bot

## Bot runtime config

See [config-template.py](https://raw.githubusercontent.com/gbin/err/master/errbot/config-template.py) for settings documentation.

Environment       | Default                      | Description
----------------- | ---------------------------- | --------------------
BACKEND           | XMPP                         | Chat server type. (XMPP, Text, HipChat, Slack, IRC)
BOT_LOG_LEVEL     | INFO                         | Change log level
BOT_USERNAME      |                              | The JID of the user
BOT_PASSWORD      |                              | The corresponding password for the user
BOT_TOKEN         |                              | Token for HipChat and Slack backend
BOT_SERVER        |                              | Server address for XMPP and HipChat
BOT_PORT          |                              | Server port
BOT_SSL           | false                        | IRC Backend: Use SSL
BOT_ENDPOINT      |                              | HipChat endpoint for hosted HipChat
BOT_NICKNAME      |                              | IRC Backend: Nickname
BOT_ADMINS        | admin@localhost              | Bot admins separated with comma
CHATROOM_PRESENCE | err@conference.localhost     | The FullName, or nickname, your bot should use
CHATROOM_FN       | Err                          | Chatrooms your bot should join on startup
XMPP_CA_CERT_FILE | None                         | Path to a file containing certificate authorities
BOT_PREFIX        | !                            | Command prefix
BOT_PREFIX_OPTIONAL_ON_CHAT | False              | Optional prefix for normal chat
BOT_ALT_PREFIXES            |                    | Alternative prefixes
BOT_ALT_PREFIX_SEPARATORS   |                    | Alternative prefixes separators
BOT_ALT_PREFIX_CASEINSENSITIVE | False           | Require correct capitalization
HIDE_RESTRICTED_COMMANDS    | False              | Hide the restricted commands from the help output
HIDE_RESTRICTED_ACCESS      | False              | Do not reply error message
DIVERT_TO_PRIVATE           |                    | Private commands
MESSAGE_SIZE_LIMIT          | 10000              | Maximum length a single message may be

## Quickstart example

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

## Docker Compose quick start

```
$ wget https://raw.githubusercontent.com/rroemhild/docker-err/master/docker-compose.yml
$ docker-compose up
```

## Volume

```/srv``` is exposed as a volume for config, log, plugin and data.

### Create the directories for the volume

```
mkdir /tmp/errbot /tmp/errbot/ssl /tmp/errbot/data /tmp/errbot/plugins
chmod -R 777 /tmp/errbot
```

## Use your config file

```
$ curl -sL https://raw.githubusercontent.com/gbin/err/master/errbot/config-template.py -o /tmp/errbot/config.py
```

## Run Err

### Run in foreground

```
$ docker run -v /tmp/errbot:/srv rroemhild/err
```

### Run in background

```
$ docker run -d --name err -v /tmp/errbot:/srv rroemhild/err
```

### Run Err with extra arguments

If you want to pass arguments to Err you have to set the `-c /srv` argument by your self.

#### Err usage

```
$ docker run rroemhild/err -h
```

#### Run with text debug backend

```
$ docker run -it -v /tmp/errbot:/srv rroemhild/err -c /srv -T
```

#### Run with IRC backend in background

```
$ docker run -d --name err -v /tmp/errbot:/srv rroemhild/err -c /srv -I
```

## Exposed Ports

* 3142 (Webserver if configured)

## Exposed Volumes

* /srv (Bot Data)
