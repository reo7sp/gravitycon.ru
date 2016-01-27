FROM reo7sp/nginx
MAINTAINER Oleg Morozenkov

RUN apt-get update && \
	apt-get install -y npm && \
	rm -rf /var/lib/apt/lists/* && \
	ln -s /usr/bin/nodejs /usr/bin/node && \
	npm install -g gulp && \
	npm install

COPY . /tmp/gravitycon.ru
WORKDIR /tmp/gravitycon.ru
RUN gulp compile && \
	mkdir -p /var/lib/www/gravitycon.ru && \
	cp -r /tmp/gravitycon.ru/bin/* /var/lib/www/gravitycon.ru/ && \
	rm -rf /tmp/gravitycon.ru/*

RUN rm -rf /etc/nginx/sites-enabled/*
COPY nginxsite.conf /etc/nginx/sites-enabled/

VOLUME /var/lib/www/host.gravitycon.ru

EXPOSE 80
