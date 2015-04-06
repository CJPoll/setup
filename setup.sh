#!/bin/bash - 
#===============================================================================
#
#          FILE: setup.sh
# 
#         USAGE: ./setup.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Cody Poll (CJPoll), CJPoll@gmail.com
#  ORGANIZATION: 
#       CREATED: 01/03/2015 12:12
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

function installed()
{
    echo "Installed $1";
}

function install()
{
	PROGRAM="$1";
    INSTALLED=$( brew ls ${PROGRAM} )
    if [ -z "${INSTALLED}" ]; then
        brew install ${PROGRAM};
        installed ${PROGRAM};
    else
        echo "${PROGRAM} is already installed";
    fi
}

function get_dots()
{
	git clone https://github.com/CJPoll/devenvset ~/devenvset;
	cp "devenvset/files/default/*" ~;
    installed "devenvset";
}

function update_git()
{
	install git;
}

function get_ack()
{
	install ack;
}

function get_gsed()
{
	install gnu-sed;
}

function get_zsh()
{
	install zsh;
	chsh -s /usr/local/bin/zsh;
}

function get_cmake()
{
	install cmake;
}

function install_brew()
{
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
    installed "Homebrew";
}

function get_tmux()
{
	install tmux;
}

function get_python()
{
	install python;
}

function get_powerline()
{
	pip install git+git://github.com/powerline/powerline;
    installed "Powerline";
}

function get_vim()
{
	install vim;
}

function get_ctags()
{
	install ctags;
}

function create_custom_gits()
{
    DIR="${HOME}/.git-custom"
    if [ -d ${DIR} ]; then
        cd ${DIR};
        git pull origin master;
        echo "Updated $HOME/.git-custom"
    else
        git clone https://github.com/cjpoll/git-custom ${DIR};
        echo "Installed $HOME/.git-custom"
    fi
}

function main()
{
	install_brew;
	update_git;
	get_zsh;
	get_dots;
	get_ack;
	get_gsed;
	get_cmake;
	get_tmux;
	get_python;
	get_powerline;
	get_vim;
	get_ctags;
    create_custom_gits;
}

main;
