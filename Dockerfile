FROM ubuntu:wily

ENV RUNUSER daemon
ENV DAEMON_HOME /home/${RUNUSER}
ENV STEAMCMD_LOC ${DAEMON_HOME}/steamcmd
ENV STEAMCMD ${STEAMCMD_LOC}/steamcmd.sh

RUN apt-get update && \
        DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        lib32gcc1 \
        && apt-get -y clean \
        && rm -rf /var/lib/apt/lists/*

RUN mkdir -p ${STEAMCMD_LOC}  && \
        curl -s http://media.steampowered.com/installer/steamcmd_linux.tar.gz | tar -v -C ${STEAMCMD_LOC} -zx && \
        chown -R ${RUNUSER}:${RUNUSER} ${DAEMON_HOME}

WORKDIR ${STEAMCMD_LOC}

USER ${RUNUSER}

ENTRYPOINT ["/home/daemon/steamcmd/steamcmd.sh"]
