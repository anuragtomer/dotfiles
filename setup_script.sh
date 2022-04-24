#!/bin/sh
set -x
echo "Install everything?(y/n):"
read everything
#if [ "$everything" == "y" || "$everything" == "Y" ]; then
  sudo apt -y update
  sudo apt -y upgrade
  sudo apt -y install htop ctags cscope git zsh wget curl tmux libgmp-dev libreadline-dev powerline
  sudo apt -y install build-essential cmake vim-nox python3-dev mono-complete golang nodejs default-jdk npm
  chsh -s $(which zsh)
  cd ~/Downloads
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  cd
  mkdir -p .vim/colors
  wget "https://raw.githubusercontent.com/anuragtomer/dotfiles/main/apprentice.vim" -O ~/.vim/colors/apprentice.vim
  mkdir -p ~/.vim/bundle/
  git clone https://github.com/ycm-core/YouCompleteMe.git ~/.vim/bundle/YouCompleteMe
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  git clone --depth=1 https://github.com/vim-syntastic/syntastic.git ~/.vim/bundle/syntastic
  #wget https://www.vim.org/scripts/download_script.php?src_id=7218 -O ~/.vim/bundle/a.vim
  wget http://cscope.sourceforge.net/cscope_maps.vim -O ~/.vim/bundle/cscope_maps.vim
  cd ~/.vim/bundle/YouCompleteMe
  git submodule update --init --recursive
  python3 install.py --all
  cd ~
  # general vim config
  wget "https://raw.githubusercontent.com/anuragtomer/dotfiles/main/.vimrc_centos" -O ~/.vimrc
  echo "set tabstop=2 shiftwidth=2 expandtab\nset mouse=a\n" >> ~/.vimrc
  #vundle
  echo "set nocompatible              \" be iMproved, required
  filetype off                  \" required

  \" set the runtime path to include Vundle and initialize
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()
  \" alternatively, pass a path where Vundle should install plugins
  \"call vundle#begin('~/some/path/here')

  \" let Vundle manage Vundle, required
  Plugin 'VundleVim/Vundle.vim'

  \" The following are examples of different formats supported.
  \" Keep Plugin commands between vundle#begin/end.
  \" plugin on GitHub repo
  Plugin 'tpope/vim-fugitive'
  \" plugin from http://vim-scripts.org/vim/scripts.html
  \" Plugin 'L9'
  \" Git plugin not hosted on GitHub
  Plugin 'git://git.wincent.com/command-t.git'
  Plugin 'scrooloose/syntastic'
  \" git repos on your local machine (i.e. when working on your own plugin)
  \"Plugin 'file:///home/gmarik/path/to/plugin'
  \" The sparkup vim script is in a subdirectory of this repo called vim.
  \" Pass the path to set the runtimepath properly.
  Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
  \" Install L9 and avoid a Naming conflict if you've already installed a
  \" different version somewhere else.
  \" Plugin 'ascenator/L9', {'name': 'newL9'}

  \" All of your Plugins must be added before the following line
  # lh-cpp
  Bundle 'LucHermitte/lh-vim-lib'
  Bundle 'LucHermitte/lh-style'
  Bundle 'LucHermitte/lh-tags'
  Bundle 'LucHermitte/lh-dev'
  Bundle 'LucHermitte/lh-brackets'
  Bundle 'LucHermitte/searchInRuntime'
  Bundle 'LucHermitte/mu-template'
  Bundle 'tomtom/stakeholders_vim'
  Bundle 'LucHermitte/alternate-lite'
  Bundle 'LucHermitte/lh-cpp'

  \" Track the engine.
  Plugin 'SirVer/ultisnips'

  \" Snippets are separated from the engine. Add this if you want them:
  Plugin 'preservim/tagbar'
  Plugin 'honza/vim-snippets'
  call vundle#end()            \" required
  filetype plugin indent on    \" required
  \" To ignore plugin indent changes, instead use:
  \"filetype plugin on
  \"
  \" Brief help
  \" :PluginList       - lists configured plugins
  \" :PluginInstall    - installs plugins; append '!' to update or just :PluginUpdate
  \" :PluginSearch foo - searches for foo; append '!' to refresh local cache
  \" :PluginClean      - confirms removal of unused plugins; append '!' to auto-approve removal
  \"
  \" see :h vundle for more details or wiki for FAQ
  \" Put your non-Plugin stuff after this line" >> ~/.vimrc
  #syntastic
  echo "set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0" >> ~/.vimrc
  # a.vim
  #echo "source ~/.vim/bundle/a.vim" >> ~/.vimrc
  # ultisnip

  echo "\" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
  \" - https://github.com/Valloric/YouCompleteMe
  \" - https://github.com/nvim-lua/completion-nvim
  let g:UltiSnipsExpandTrigger=\"<tab>\"
  let g:UltiSnipsJumpForwardTrigger=\"<c-b>\"
  let g:UltiSnipsJumpBackwardTrigger=\"<c-z>\"

  \" If you want :UltiSnipsEdit to split your window.
  let g:UltiSnipsEditSplit=\"vertical\"" >> ~/.vimrc
  # tagbar
  echo "nmap <F8> :TagbarToggle<CR>" >> ~/.vimrc
  exit 0
  vim +PluginInstall +qall
  # Latest gdb
  wget "https://ftp.gnu.org/gnu/gdb/gdb-11.2.tar.xz" -O ~/Downloads/gdb.tar.gz
  tar -xvzf gdb.tar.gz
  cd gdb-11.2
  wget "https://www.linuxfromscratch.org/patches/blfs/svn/gdb-11.2-upstream_fixes-1.patch"
  patch -Np1 -i ./gdb-11.2-upstream_fixes-1.patch
  mkdir build && cd build
  ../configure --prefix=/usr --with-system-readline --with-python=/usr/bin/python3
  make
  sudo make install
  cd

