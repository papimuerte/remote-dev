FROM ubuntu:18.04

ENV GO_VERSION 1.5.1

ENV PYTHON2_VERSION 2.7.10
ENV PYTHON3_VERSION 3.5.0

ENV RUBY_VERSION 2.6.5

ENV NODE_VERSION 12.11.1

RUN apt-get update && apt-get install -y \
    aufs-tools \
    automake \
    build-essential \
    git \
    curl \
    vim-nox \
    ruby2.6.5 \
    zsh \
 && rm -rf /var/lib/apt/lists/*

# Create my user
RUN useradd nate --uid 1000 --shell /bin/zsh

# Add dotfiles
ADD dotfiles/zsh /home/nate/.zsh
ADD dotfiles/zshrc /home/nate/.zshrc
ADD dotfiles/tmux.conf /home/nate/.tmux.conf
ADD dotfiles/gitconfig /home/nate/.gitconfig
ADD dotfiles/gitignore /home/nate/.gitignore
ADD dotfiles/vimrc /home/nate/.vimrc

# Ensure ownership of $HOME is correct.
RUN chown -R nate: /home/nate

# Cleanup
RUN apt-get clean && rm -rf /tmp/*

WORKDIR /home/nate
USER nate
