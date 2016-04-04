FROM mono:latest
MAINTAINER Cassiano Leal <cassianoleal@gmail.com>
ENV USER app
RUN useradd --system ${USER} --home-dir /app
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
 && apt-get update -q \
 && apt-get install curl -qy \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN mkdir -p /app/.config
RUN mkdir /config
RUN jackett_ver=$(curl -L -s https://github.com/Jackett/Jackett/releases/latest | grep -E \/tag\/ | awk -F "[><]" '{print $3}') \
 && curl -L -s -o /jackett.tar.gz https://github.com/Jackett/Jackett/releases/download/$jackett_ver/Jackett.Binaries.Mono.tar.gz \
 && tar -xvf /jackett.tar.gz -C /app --strip-components=1 \
 && rm /jackett.tar.gz
RUN chown -R ${USER}:${USER} /app
RUN chown -R ${USER}:${USER} /config
RUN ln -s /config /app/.config/Jackett
USER app
EXPOSE 9117
WORKDIR /app
VOLUME /config
CMD ["/usr/bin/mono", "/app/JackettConsole.exe"]
