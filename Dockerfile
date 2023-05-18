FROM openjdk:8-jre-alpine

ENV STREETLIGHT_VERSION 4.0
ENV STREETLIGHT_WEB_VERSION 0.12.3
ENV MYSQL_HOST localhost
ENV MYSQL_PORT 3306
ENV MYSQL_DATABASE streetlight
ENV MYSQL_USER streetlight
ENV MYSQL_PASSWORD streetlight

WORKDIR /opt/streetlight

RUN set -ex && \
    apk add --no-cache wget mysql-client sed && \
    \
    wget -qO /tmp/streetlight.zip https://api.giahungtrieu.net/streetlight-other-4.0.zip && \
    unzip -qo /tmp/streetlight.zip -d /opt/streetlight && \
    wget -qO /opt/streetlight/streetlight-web.war https://api.giahungtrieu.net/streetlight-web/traccar-web.war && \
    rm /tmp/streetlight.zip && \
    \
    apk del wget
    
COPY start.sh start.sh

VOLUME "/opt/streetlight/logs"

EXPOSE 8082
EXPOSE 5174-5174/tcp
EXPOSE 5174-5174/udp

ENTRYPOINT ["/bin/sh"]

CMD ["start.sh"]
