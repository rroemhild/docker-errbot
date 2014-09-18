# Err - the pluggable chatbot

FROM ubuntu:trusty

MAINTAINER Rafael Römhild <rafael@roemhild.de>

RUN apt-get -qq update
RUN DEBIAN_FRONTEND=noninteractive apt-get -qqy install curl python3-pyasn1 python3-dnspython python3-openssl
RUN curl -sL https://bootstrap.pypa.io/get-pip.py | python3 -
RUN pip3 install err sleekxmpp irc pyasn1-modules

EXPOSE 3142

VOLUME ["/srv"]
CMD ["-c", "/srv"]
ENTRYPOINT ["/usr/local/bin/err.py"]
