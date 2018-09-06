#!/bin/bash

here="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
now=$(date +'%Y%m%d')
repo="dot_repounix"

getrepo() {
    repobase="${HOME}/git/${1}"
    reponame="${2}"
    gituri="${3}"
    [ -d "${repobase}" ] || mkdir "${repobase}"

    if [ ! -d "${repobase}/${reponame}" ]
    then
        cd "${repobase}"
        git clone "${gituri}"
    fi
}

symlink() {
    local link_source="${1}"
    local link_target="${2}"

    if [ -h "${link_target}" ]
    then
        if [ ! -e "${link_target}" ]
        then
            rm -v -f "${link_target}"
        fi
    else
        if [ -e "${link_target}" ]
        then
            mv -v "${link_target}"{,."${now}"}
        fi
    fi

    if [ ! -h "${link_target}" ]
    then
        ln -v -s "${link_source}" "${link_target}"
    fi
}

getrepo ${repo} vim-plug git@gitlab.pjm.com:unix/vim-plug.git
mkdir -p ${HOME}/.vim/{autoload,colors}
[ -h "${HOME}/.vim/autoload/plug.vim" ] || ln -s "${HOME}/git/${repo}/vim-plug/plug.vim" "${HOME}/.vim/autoload/plug.vim"

getrepo ${repo} bash-git-prompt git@gitlab.pjm.com:unix/bash-git-prompt.git
[ -h "${here}/bash-git-prompt" ] || ln -s "${HOME}/git/${repo}/bash-git-prompt" "${here}/bash-git-prompt"
[ -h "${here}/gitprompt.sh" ] || ln -s "${HOME}/git/${repo}/bash-git-prompt/gitprompt.sh" "${here}/gitprompt.sh"
sed "s@REPLACE_THIS@${here}@" "${here}/bashrc_template" > "${here}/bashrc"
sed "s@REPLACE_THIS@${here}@" "${here}/git-prompt-colors.sh_template" > "${here}/git-prompt-colors.sh"

symlink "${here}/gitconfig"            "${HOME}/.gitconfig"
symlink "${here}/bashrc"               "${HOME}/.bashrc"
symlink "${here}/screenrc"             "${HOME}/.screenrc"
symlink "${here}/alias"                "${HOME}/.alias"
symlink "${here}/tmux.conf"            "${HOME}/.tmux.conf"
symlink "${here}/tmux.conf.sh"         "${HOME}/.tmux.conf.sh"
symlink "${here}/git-prompt-colors.sh" "${HOME}/.git-prompt-colors.sh"
symlink "${here}/gitprompt.sh"         "${HOME}/.gitprompt.sh"
symlink "${here}/vimrc"                "${HOME}/.vimrc"
