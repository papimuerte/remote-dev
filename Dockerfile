FROM ubuntu:18.04

ENV GO_VERSION 1.5.1

ENV PYTHON2_VERSION 2.7.10
ENV PYTHON3_VERSION 3.5.0

ENV RUBY_VERSION 2.6.5

ENV NODE_VERSION 12.11.1

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    aufs-tools \
    automake \
    build-essential \
    git \
    curl \
    vim-nox \
    zsh \
    ruby \
    python3 \
    python3-pip \
    tmux \
 && rm -rf /var/lib/apt/lists/*


# Create my user
RUN useradd nate --uid 1000 --shell /bin/zsh
RUN mkdir -p /home/nate
# Add dotfiles

# Ensure ownership of $HOME is correct.

RUN chown -R nate: /home/nate

# Cleanup
RUN apt-get clean && rm -rf /tmp/*

WORKDIR /home/nate
USER nate

RUN curl -fLo /home/nate/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

RUN git clone https://github.com/papimuerte/dotfiles.git 
RUN ln -s .vimrc dotfiles/.vimrc
# Need to run :PlugInstall in vim
CMD ["/bin/zsh"]
