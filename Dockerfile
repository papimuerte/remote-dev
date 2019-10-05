FROM alpine

RUN apk update && \
    apk add --no-cache automake autoconf ncurses-dev build-base python3 zsh curl git vimnox tmux htop stow && \
    rm -f /tmp/* /etc/apk/cache/*

# Install ZSH
RUN sed -i -e "s/bin\/ash/bin\/zsh/" /etc/passwd
ENV SHELL /bin/zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Dotfile setup
RUN git clone --depth 1 https://github.com/papimuerte/dotfiles /root/dotfiles \
  && rm /root/.zshrc \
  && cd /root/dotfiles \
  && stow vim zsh tmux

# Vim plugins
WORKDIR /root/.vim/bundle
RUN git clone --depth 1 https://github.com/VundleVim/Vundle.vim \
  && git clone --depth 1 https://github.com/arcticicestudio/nord-vim \
  && git clone --depth 1 https://github.com/sheerun/vim-polyglot \
  && git clone --depth 1 https://github.com/tpope/vim-fugitive \
  && git clone --depth 1 https://github.com/vim-airline/vim-airline \
  && git clone --depth 1 https://github.com/vim-airline/vim-airline-themes \
  && git clone --depth 1 https://github.com/w0rp/ale \
  && git clone --depth 1 https://github.com/nvie/vim-flake8 \
  && git clone --depth 1 https://github.com/editorconfig/editorconfig-vim \
  && git clone --depth 1 https://github.com/mileszs/ack.vim \
  && git clone --depth 1 https://github.com/ctrlpvim/ctrlp.vim \
  && git clone --depth 1 https://github.com/scrooloose/nerdcommenter \
  && git clone --depth 1 https://github.com/scrooloose/nerdtree \
  && git clone --depth 1 https://github.com/Xuyuanp/nerdtree-git-plugin \
  && git clone --depth 1 https://github.com/tpope/vim-surround \
  && git clone --depth 1 https://github.com/easymotion/vim-easymotion \
  && git clone --depth 1 https://github.com/airblade/vim-gitgutter \
  && git clone --depth 1 https://github.com/Shougo/neocomplete.vim \
  && git clone --depth 1 https://github.com/Chiel92/vim-autoformat \
  && git clone --depth 1 https://github.com/terryma/vim-multiple-cursors \
  && git clone --depth 1 https://github.com/ntpeters/vim-better-whitespace \
  && git clone --depth 1 https://github.com/terryma/vim-expand-region \
  && git clone --depth 1 https://github.com/ap/vim-buftabline \
  && git clone --depth 1 https://github.com/davidhalter/jedi-vim \
  && git clone --depth 1 https://github.com/vim-python/python-syntax \
  && git clone --depth 1 https://github.com/vim-scripts/sessionman.vim \
  && git clone --depth 1 https://github.com/luochen1990/rainbow \
  && git clone --depth 1 https://github.com/mhinz/vim-startify \
  && git clone --depth 1 https://github.com/kshenoy/vim-signature \
  && git clone --depth 1 https://github.com/Yggdroot/indentLine \
  && git clone --depth 1 https://github.com/vim-ruby/vim-ruby.git

RUN pip3 install powerline-status jedi flake8
RUN pip3 install --user tmuxp

RUN mkdir /root/dev
VOLUME /root/dev

WORKDIR /root

ENV TERM=xterm-256color
ENV LANG=en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8

CMD ["zsh"]
