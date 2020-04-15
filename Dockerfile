FROM openjdk:8-jre-alpine

ENV TRACCAR_VERSION 4.0
ENV TRACCAR_WEB_VERSION 0.12.3
ENV MYSQL_HOST localhost
ENV MYSQL_PORT 3306
ENV MYSQL_DATABASE traccar
ENV MYSQL_USER traccar
ENV MYSQL_PASSWORD traccar

WORKDIR /opt/traccar

RUN set -ex && \
    apk add --no-cache wget mysql-client sed && \
    \
    wget -qO /tmp/traccar.zip https://giahungtrieu.net/traccar-other-4.0.zip && \
    unzip -qo /tmp/traccar.zip -d /opt/traccar && \
    wget -qO /opt/traccar/traccar-web.war https://github.com/vitalidze/traccar-web/releases/download/$TRACCAR_WEB_VERSION/traccar-web.war && \
    rm /tmp/traccar.zip && \
    \
    apk del wget
    
COPY start.sh start.sh

VOLUME "/opt/traccar/logs"

EXPOSE 8082
EXPOSE 5000-5150/tcp
EXPOSE 5000-5150/udp

ENTRYPOINT ["/bin/sh"]

CMD ["start.sh"]
