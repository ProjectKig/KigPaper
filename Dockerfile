FROM maven:3.6.1-jdk-8-alpine
COPY . .
RUN apk add --no-cache --update git bash patch && git config --global user.name "Kig Docker" && git config --global user.email "docker@cai.rip" && bash build.sh

FROM openjdk:8-jdk-alpine
RUN apk add --no-cache --update curl ca-certificates openssl git tar bash sqlite fontconfig \
    && adduser --disabled-password --home /home/container container && mkdir -p /home/server/plugins \
    && chown -R container:container /home/server && echo eula=true > eula.txt
USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container
COPY --from=0 ./KigPaper-Server/target/paperspigot*.jar /home/server/server.jar
COPY ./docker/entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
