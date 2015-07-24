# Err - the pluggable chatbot

FROM debian:jessie

MAINTAINER Rafael Römhild <rafael@roemhild.de>

ENV ERR_USER err
ENV DEBIAN_FRONTEND noninteractive
ENV PATH /srv/venv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Set default locale for the environment
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Add err user and group
RUN groupadd -r $ERR_USER \
    && useradd -r \
       -g $ERR_USER \
       -d /srv \
       $ERR_USER

# Install packages and perform cleanup
RUN apt-get update \
  && apt-get -y install --no-install-recommends \
         git \
         locales \
         dnsutils \
         python3-dnspython \
         python3-openssl \
         python3-pip \
         python3-cffi \
         python3-pyasn1 \
    && locale-gen C.UTF-8 \
    && /usr/sbin/update-locale LANG=C.UTF-8 \
    && echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen \
    && locale-gen \
    && pip3 install virtualenv \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir /srv/data /srv/plugins /srv/errbackends \
    && chown -R $ERR_USER: /srv

USER $ERR_USER
WORKDIR /srv

COPY requirements.txt /srv/requirements.txt

RUN virtualenv --system-site-packages -p python3 /srv/venv
RUN /srv/venv/bin/pip3 install --no-cache-dir -r requirements.txt

COPY config.py /srv/config.py

EXPOSE 3142
VOLUME ["/srv"]

CMD ["-c", "/srv"]
ENTRYPOINT ["/srv/venv/bin/err.py"]
