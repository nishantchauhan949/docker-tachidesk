FROM alpine:latest

RUN apk --update add curl openjdk8-jre-base tzdata bash

# RUN apt update

# RUN apt install curl openjdk-8-jdk tzdata

# RUN addgroup -g 1000 -S suwayomi && adduser -u 1000 -S suwayomi -G suwayomi

# RUN mkdir -p /home/suwayomi && chown -R suwayomi:suwayomi /home/suwayomi
# RUN mkdir -p /home/suwayomi

RUN if [ -d /home/suwayomi ]; then pwd; else mkdir -p /home/suwayomi; fi;

# USER suwayomi

WORKDIR /home/suwayomi

RUN if [ -f /home/suwayomi/startup/startup_script.sh ]; then pwd; else curl -s --create-dirs -L https://raw.githubusercontent.com/suwayomi/docker-tachidesk/main/scripts/startup_script.sh -o /home/suwayomi/startup/startup_script.sh; fi;

# RUN curl -s --create-dirs -L https://raw.githubusercontent.com/suwayomi/docker-tachidesk/main/scripts/startup_script.sh -o /home/suwayomi/startup/startup_script.sh

RUN curl -L $(curl -s https://api.github.com/repos/suwayomi/tachidesk-server/releases/latest | grep -o "https.*jar") -o /home/suwayomi/startup/tachidesk_latest.jar

EXPOSE 4567

CMD ["/bin/sh", "/home/suwayomi/startup/startup_script.sh"]
