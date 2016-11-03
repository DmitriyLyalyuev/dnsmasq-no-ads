FROM alpine:3.4
MAINTAINER Dmitriy Lyalyuev <dmitriy@lyalyuev.info>
LABEL Description='DNSmasq with no ads support'

RUN apk --update add dnsmasq wget ca-certificates unzip \
    && rm -rf /var/cache/apk/*

ADD ./start.sh /opt/start.sh
RUN chmod 755 /opt/start.sh

EXPOSE 53/tcp
EXPOSE 53/udp

CMD /opt/start.sh
