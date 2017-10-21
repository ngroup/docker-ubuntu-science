FROM ubuntu:17.10
MAINTAINER Chun Nien <contact@chunnien.com>
ARG user=user
ARG pwd=user


# Install packages
RUN apt update && apt upgrade -y && DEBIAN_FRONTEND=noninteractive apt-get -y install \
    sudo openssh-server pwgen git cmake gcc gfortran python-dev libblas-dev \
    liblapack-dev cython python-pip python3-dev python3-pip software-properties-common \
    make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
    wget curl llvm libncurses5-dev tk-dev neovim libopenblas-dev liblapack-dev libav-tools \
    ruby iptables htop && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN useradd --create-home --shell /bin/bash ${user}
RUN echo "${user}:${pwd}" | chpasswd && adduser ${user} sudo
RUN mkdir /run/sshd \
    && echo "Port 22" | tee --append /etc/ssh/sshd_config \
    && echo "PermitRootLogin no" | tee --append /etc/ssh/sshd_config \
    && echo "AllowUsers ${user}" | tee --append /etc/ssh/sshd_config

VOLUME /home/${user}/volume
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

RUN mkdir -p /scripts
COPY run.sh /scripts/run.sh
COPY pyenv.sh /scripts/pyenv.sh
COPY pyenv_activate.sh /scripts/pyenv_activate.sh
RUN chmod +x /scripts/*.sh

USER root
WORKDIR /

EXPOSE 22

CMD ["/run.sh"]
