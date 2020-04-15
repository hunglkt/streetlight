FROM openjdk:8-jre-slim

ENV TRACCAR_VERSION 4.8

WORKDIR /opt/traccar

RUN set -ex && \
    apt-get update &&\
    TERM=xterm DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends unzip wget && \
    wget -qO /tmp/traccar.zip https://giahungtrieu.net/traccar-other-4.0.zip && \
    unzip -qo /tmp/traccar.zip -d /opt/traccar && \
    apt-get autoremove --yes unzip wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/*

ENTRYPOINT ["java", "-Xms512m", "-Xmx512m", "-Djava.net.preferIPv4Stack=true"]

CMD ["-jar", "tracker-server.jar", "conf/traccar.xml"]
