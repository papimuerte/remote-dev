FROM alpine

MAINTAINER Papimuerte

RUN apk update && \
    apk add --no-cache automake autoconf ncurses-dev build-base python3 zsh curl git vim tmux htop stow && \
    rm -f /tmp/* /etc/apk/cache/*

# Install ZSH
RUN sed -i -e "s/bin\/ash/bin\/zsh/" /etc/passwd
ENV SHELL /bin/zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
