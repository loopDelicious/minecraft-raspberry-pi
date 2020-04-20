FROM ubuntu:bionic

ENV ADMIN_USERNAME=admin \
    ADMIN_PASSWORD=Swordfish \
    MAX_PLAYERS=30

COPY webadmin.ini.tpl /opt/

WORKDIR /opt
RUN apt-get update && apt-get install -y curl gettext-base && \
    curl -Ls https://download.cuberite.org/linux-armhf-raspbian/Cuberite.tar.gz | tar -xzf - && \
    mv Server cuberite

WORKDIR /opt/cuberite
CMD envsubst < /opt/webadmin.ini.tpl > webadmin.ini && ./Cuberite -s $MAX_PLAYERS

EXPOSE 8080 25565