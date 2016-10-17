# Swift development environment on Ubuntu
FROM ubuntu:14.04
MAINTAINER Adrian Kosmaczewski <akosma@me.com>

ENV DEBIAN_FRONTEND noninteractive

# Set up the local environment
RUN apt-get -y update
RUN apt-get install -y build-essential software-properties-common python3 man unzip make clang-3.6 libicu52 libedit-dev zsh tmux vim git cowsay sl jq curl wget libxml2 exuberant-ctags fortune-mod lynx tree ruby sqlite3 cdecl cloc libncurses5-dev libncursesw5-dev
RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-3.6 100
RUN update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.6 100
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set default shell to zsh
RUN chsh -s /usr/bin/zsh

# Generate locales
RUN locale-gen en_US.UTF-8

# Create a "swiftalps" user
RUN groupadd swiftalps
RUN useradd -g swiftalps -G sudo swiftalps
RUN echo swiftalps:cransmontana | chpasswd
RUN cp -a /etc/skel /home/swiftalps
RUN chown -R swiftalps.swiftalps /home/swiftalps
RUN echo "swiftalps ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/swiftalps

ENV HOME /home/swiftalps
WORKDIR $HOME

# Copy the configuration files
COPY .bash_aliases $HOME
COPY .ctags $HOME
COPY .gitconfig $HOME
COPY .tmux.conf $HOME
COPY .vimrc $HOME

# Copy Swift 3.0 locally
COPY swift-3.0-RELEASE-ubuntu14.04.tar.gz $HOME

# Copy sample Swift file
COPY shell.swift $HOME

# Let us give swiftalps what belongs to swiftalps
RUN chown -R swiftalps.swiftalps $HOME

# Run the following commands as the swiftalps user
USER swiftalps

# Setup Swift
RUN tar -xvf $HOME/swift-3.0-RELEASE-ubuntu14.04.tar.gz
RUN mv $HOME/swift-3.0-RELEASE-ubuntu14.04 $HOME/swift-3.0

# Install oh-my-zsh
# Thanks to http://stackoverflow.com/a/30731731/133764 !
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
COPY .zshrc $HOME

# Install vim plugins and colors
# First install Pathogen
RUN mkdir -p ~/.vim/autoload ~/.vim/bundle
RUN curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Then install all the rest
WORKDIR $HOME/.vim/bundle
RUN git clone https://github.com/airblade/vim-gitgutter.git
RUN git clone https://github.com/bronson/vim-trailing-whitespace.git
RUN git clone https://github.com/chrisbra/NrrwRgn.git
RUN git clone https://github.com/ctrlpvim/ctrlp.vim.git
RUN git clone https://github.com/keith/swift.vim.git
RUN git clone https://github.com/majutsushi/tagbar.git
RUN git clone https://github.com/mileszs/ack.vim.git
RUN git clone https://github.com/mkitt/tabline.vim.git
RUN git clone https://github.com/scrooloose/nerdcommenter.git
RUN git clone https://github.com/scrooloose/nerdtree.git
RUN git clone https://github.com/sjl/gundo.vim.git
RUN git clone https://github.com/tpope/vim-fugitive.git
RUN git clone https://github.com/vim-airline/vim-airline-themes.git
RUN git clone https://github.com/vim-airline/vim-airline.git

# Install mdp and ponysay
WORKDIR $HOME
RUN git clone https://github.com/visit1985/mdp.git
RUN wget https://github.com/erkin/ponysay/archive/3.0.2.zip
RUN unzip 3.0.2.zip
WORKDIR $HOME/mdp
RUN make
RUN sudo make install
WORKDIR $HOME/ponysay-3.0.2
RUN touch ponysay.info
RUN sudo python3 setup.py --freedom=partial install

# We have finished, cleaning up
USER 0
WORKDIR $HOME
RUN rm $HOME/swift-3.0-RELEASE-ubuntu14.04.tar.gz
RUN rm $HOME/3.0.2.zip
RUN rm -rf $HOME/mdp
RUN rm -rf $HOME/ponysay-3.0.2
RUN chown -R swiftalps.swiftalps $HOME/.zshrc

# Ready to boot
ENTRYPOINT zsh

