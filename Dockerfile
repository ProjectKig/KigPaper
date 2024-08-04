ARG git_ref
FROM --platform=linux/amd64 ghcr.io/projectkig/kigpaper/kig-paper-builder:${git_ref} AS builder

FROM eclipse-temurin:17-jre
RUN apt-get update && apt-get install -y curl ca-certificates openssl git tar bash sqlite3 fontconfig \
    && adduser --disabled-password --home /home/container container && mkdir -p /home/server/plugins \
    && chown -R container:container /home/server && echo eula=true > eula.txt \
    && rm -rf /var/lib/apt/lists/*
USER container
ARG git_ref=master
ENV USER=container HOME=/home/container KIG_PLATFORM=hotspot
WORKDIR /home/container
COPY --from=builder ./build/PaperSpigot-Server/target/paperspigot*.jar /home/server/server.jar
COPY ./docker/entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
