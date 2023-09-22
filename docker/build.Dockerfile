FROM maven:3.9.4-eclipse-temurin-17-alpine
WORKDIR build
COPY . .
RUN apk add --no-cache --update git bash patch zip && git config --global user.name "Kig Docker" && git config --global user.email "docker@playkig.com" && bash build.sh