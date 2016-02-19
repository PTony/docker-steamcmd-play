FROM debian:jessie

ENV RUNUSER steamusr
ENV USER_HOME /home/${RUNUSER}
ENV STEAMCMD_LOC ${USER_HOME}/steamcmd
ENV STEAMCMD ${STEAMCMD_LOC}/steamcmd.sh

# Install dependencies and clean
RUN apt-get update && \
        DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        ca-certificates \
        lib32gcc1 \
        wget \
        && apt-get -y clean \
        && rm -rf /var/lib/apt/lists/*

# Create user account, his home dir and steamcmd dir, then dl and extract steamcmd and finally give ownership of his homedir to user
RUN mkdir -p ${STEAMCMD_LOC} \
        && wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz -O- | tar -xzvC ${STEAMCMD_LOC} \
        && useradd ${RUNUSER} \
        && chown -R ${RUNUSER}:${RUNUSER} ${USER_HOME}

WORKDIR ${STEAMCMD_LOC}

USER ${RUNUSER}

ENTRYPOINT ["./steamcmd.sh"]
