FROM ubuntu:17.10
MAINTAINER Chun Nien <contact@chunnien.com>
ARG user=user
ARG pwd=userpwd


# Install packages
RUN apt update && apt upgrade -y && DEBIAN_FRONTEND=noninteractive apt-get -y install sudo openssh-server pwgen
RUN apt install -y git cmake gcc gfortran python-dev libblas-dev liblapack-dev cython python-pip python3-dev python3-pip software-properties-common make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev tk-dev neovim libopenblas-dev liblapack-dev libav-tools ruby iptables
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN useradd --create-home --shell /bin/bash ${user}
VOLUME /home/${user}/volume
RUN echo "${user}:${pwd}" | chpasswd && adduser ${user} sudo
RUN mkdir /run/sshd
RUN echo "Port 22" | tee --append /etc/ssh/sshd_config
RUN echo "PermitRootLogin no" | tee --append /etc/ssh/sshd_config
RUN echo "AllowUsers ${user}" | tee --append /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ADD run.sh /run.sh
RUN chmod +x /*.sh

COPY pyenv.sh /home/${user}/pyenv.sh
RUN chmod +x /home/${user}/pyenv.sh
RUN chown -R ${user} /home/${user}
ENV HOME /home/${user}
USER ${user}
WORKDIR /home/${user}
RUN ./pyenv.sh
RUN rm pyenv.sh
COPY pyenv_activate.sh /home/${user}/pyenv_activate.sh
RUN chmod +x /home/${user}/pyenv_activate.sh
RUN chown -R ${user} /home/${user}/pyenv_activate.sh

USER root
WORKDIR /

EXPOSE 22

CMD ["/run.sh"]
