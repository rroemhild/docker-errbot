# docker-err

[Err](http://errbot.net) - the pluggable chatbot

## Bot runtime config

See [config-template.py](https://raw.githubusercontent.com/gbin/err/master/errbot/config-template.py) for settings documentation.

Environment       | Default
----------------- | -----------
BACKEND           | XMPP
BOT_LOG_LEVEL     | INFO
BOT_USERNAME      |
BOT_PASSWORD      |
BOT_SERVER        |
BOT_ADMINS        | admin@localhost
CHATROOM_PRESENCE | err@conference.localhost
CHATROOM_FN       | Err
XMPP_CA_CERT_FILE | None

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

## Volume

`/srv` is exposed as a volume for config, log, plugin and data.

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
