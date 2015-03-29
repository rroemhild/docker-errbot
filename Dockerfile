# Err - the pluggable chatbot

FROM debian:jessie

MAINTAINER Rafael Römhild <rafael@roemhild.de>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update && \
    apt-get -qqy install \
        dnsutils \
        git \
        python3-dnspython \
        python3-openssl \
        python3-pip \
        python3-pyasn1
RUN pip3 install err sleekxmpp irc pyasn1-modules
## pytz for err-time

RUN groupadd -r err && \
    useradd -r -g err -d /srv -s /sbin/nologin -c "ErrBot" err

USER err
EXPOSE 3142
VOLUME ["/srv"]

CMD ["-c", "/srv"]
ENTRYPOINT ["/usr/local/bin/err.py"]
