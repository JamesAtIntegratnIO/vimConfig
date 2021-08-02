#! /usr/bin/env bash
#
# bootstrap installs vim

VIMCONFIG_ROOT=$(pwd -P)

set -e

echo ''

info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

link_file () {
  local src=$1 dst=$2

  local overwrite= backup= skip=
  local action=

  if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
  then

    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
    then

      local currentSrc="$(readlink $dst)"

      if [ "$currentSrc" == "$src" ]
      then

        skip=true;

      else

        user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac

      fi

    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]
    then
      rm -rf "$dst"
      success "removed $dst"
    fi

    if [ "$backup" == "true" ]
    then
      mv "$dst" "${dst}.backup"
      success "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]
    then
      success "skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]  # "false" or empty
  then
    ln -s "$1" "$2"
    success "linked $1 to $2"
  fi
}

install_vim_plug() {
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

install_vim_files() {
    info 'installing vimFiles'
    local overwrite_all=false backup_all=false skip_all=false
    for src in $(find -H "$VIMCONFIG_ROOT" -name '*.symlink' -not -path '*.git*')
    do
        dst="$HOME/.$(basename "${src%.*}")"
        link_file "$src" "$dst"
    done
}

install_vim_plugins() {
    info 'installing Vim Plugins'
    vim +PlugInstall +qall
    success "Vim Plugins Installed"
}

install_vim_nox() {
    info 'installing vim'
    unameOut="$(uname -s)"
    case "$unameOut" in 
	Linux* )	machine="Linux";;
	Darwin* )	machine="Mac";;
	* ) ;;
    esac
    if [[ ${machine} == "Linux" ]] 
    then
        info "in machine == linux"
	if [ -n "$(command -v apt)" ]
	    then APT_CMD=$(which apt)
	fi
	if [ -n "$(command -v yum)" ]
	    then YUM_CMD=$(which yum)
	fi
    fi
    if [[ ${machine} == "Mac" ]]
    then
	info "in machine == Mac"
        BREW_CMD="$(which brew)"
    fi
    if [[ ! -z ${APT_CMD} ]]
    then
        info 'using apt'
        sudo $APT_CMD install -y vim-nox
    elif [[ ! -z ${BREW_CMD} ]]
    then
        $BREW_CMD install macvim
        macPath=$(which macvim)
        ln -s macPath /usr/local/bin/vim
    elif [[ ! -z ${YUM_CMD}  ]]
    then
        sudo $YUM_CMD install -y vim-nox
    fi
}

install_go_binaries() {
    vim +GoInstallBinaries +qall
}

install_coc_extensions() {
    vim +CocInstall\
        coc-json\
        coc-tsserver\
        coc-markdownlint\
        coc-pyright\
        coc-snippets\
	+qall
    vim +call 'mkdp#util#install()'\
        +qall

    local overwrite_all=true backup_all=false skip_all=false
    link_file ./coc-settings.json $HOME/.vim/coc-settings.json
}

info "starting install"

install_vim_nox
install_vim_plug
install_vim_files
install_vim_plugins
install_go_binaries
install_coc_extensions
