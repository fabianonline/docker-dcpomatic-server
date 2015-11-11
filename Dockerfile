FROM ubuntu:14.04
MAINTAINER Fabian Schlenz <mail@fabianonline.de>

RUN (export DEBIAN_FRONTEND=noninteractive ; \
	apt-get update && \
	apt-get install -y libsamplerate0 libsndfile1 libboost-date-time1.54.0 \
		libxmlsec1 libboost-regex1.54.0 libboost-thread1.54.0 libxmlsec1-openssl \
		libmagick++5 libssh-4 libzip2 libcurl3 libcairomm-1.0-1 libpangomm-1.4-1 \
		libsm6 wget libgtk2.0-0 libxml++2.6-2 libboost-filesystem1.54.0 && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*)

ENV DCPOMATIC_VERSION 2.4.0

RUN (export DEBIAN_FRONTEND=noninteractive ; \
	cd /tmp && \
	wget -q -O dcpomatic.deb "http://dcpomatic.com/downloads/2.4.0/ubuntu-14.04-64/dcpomatic_2.4.0-1_amd64.deb" && \
	dpkg -i dcpomatic.deb && \
	apt-get clean && \
	rm -rf dcpomatic.deb /var/lib/apt/lists/* /tmp/* /var/tmp/*)
	
EXPOSE 6192
EXPOSE 6193/udp

ENTRYPOINT ["dcpomatic2_server_cli"]
