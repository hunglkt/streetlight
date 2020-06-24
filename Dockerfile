FROM openjdk:8-jre-alpine

ENV TRACCAR_VERSION 4.0
ENV TRACCAR_WEB_VERSION 0.12.3
ENV MYSQL_HOST localhost
ENV MYSQL_PORT 3306
ENV MYSQL_DATABASE streetlight
ENV MYSQL_USER streetlight
ENV MYSQL_PASSWORD streetlight

WORKDIR /opt/streetlight

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

VOLUME "/opt/streetlight/logs"

EXPOSE 8083
EXPOSE 5174-5174/tcp
EXPOSE 5174-5174/udp

ENTRYPOINT ["/bin/sh"]

CMD ["start.sh"]
