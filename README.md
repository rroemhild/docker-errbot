# docker-err

[Err][err] - the pluggable chatbot

`/srv` is exposed as a volume for config, log, plugin and data.

[err]: http://errbot.net

## Create the directories for the volume

```
$ mkdir /tmp/errbot /tmp/errbot/ssl /tmp/errbot/data /tmp/errbot/plugins
chmod -R 777 /tmp/errbot
```

## Get the config template and make your settings

```
$ curl -sL https://github.com/rroemhild/docker-err/raw/master/config-template.py -o /tmp/errbot/config.py
```

```
$ vim /tmp/errbot/config.py
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

## Versions

* Err 2.1.0
* Python 3.4
* Ubuntu 14.04

## Exposed Ports

* 3142 (Webserver if configured)

## Exposed Volumes

* /srv (Bot Data)
