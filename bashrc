#
test -s ~/.alias && . ~/.alias || true

# Set erase to be ^H (backspace key) to allow backspacing
# (fat fingering) passwords in password prompts.
stty erase ^H

# Disable flow control to free up ^Q
# to use as control character in screen
[ -t 0 ] && stty -ixon
alias screen="/usr/bin/screen -h 2000"

export TERM="screen"
#[ ! -z "${TERM}" ] && [ "${TERM}" == "screen" ] && \
#    export PROMPT_COMMAND='echo -ne "\ek${HOSTNAME}\e\\"' && \
#    export TERM="screen-256color"

[ ! -z "${TERM}" ] && [ "${TERM}" == "screen" ] && \
    export TERM="screen-256color"

[ ! -z "${TERM}" ] && [ "${TERM}" == "xterm" ] && \
    export TERM="xterm-256color"

[ -x ${HOME}/bin ]                && export PATH="${HOME}/bin:${PATH}"
[ -x ${HOME}/tmux/bin/tmux ]      && export PATH="${HOME}/tmux/bin:${PATH}"
[ -x ${HOME}/opt/pdsh/bin ]       && export PATH="${HOME}/opt/pdsh/bin:${PATH}"
[ -x ${HOME}/opt/vim/bin ]        && export PATH="${HOME}/opt/vim/bin:${PATH}"
[ -x ${HOME}/opt/tree/bin ]       && export PATH="${HOME}/opt/tree/bin:${PATH}"
[ -x /opt/puppetlabs/bin/puppet ] && export PATH="/opt/puppetlabs/bin/puppet:${PATH}"

[ -x ${HOME}/tmux/share/man ]     && export MANPATH="${HOME}/tmux/share/man:${MANPATH}"
[ -x ${HOME}/opt/pdsh/man ]       && export MANPATH="${HOME}/opt/pdsh/man:${MANPATH}"

[ -x ${HOME}/opt/vim/bin/vim ]    && export EDITOR="${HOME}/opt/vim/bin/vim"

# Set window title at login
#/usr/bin/tty | grep -q "not a tty" || echo -ne "\ek${HOSTNAME}\e\\"

GIT_PROMPT_ONLY_IN_REPO=1
source /home/rebelm/dot/bash-git-prompt/prompt-colors.sh
[ -e ~/.gitprompt.sh ] && . ~/.gitprompt.sh

# Because GIT_PROMPT_ONLY_IN_REPO is set above the non-git prompt
# must be set as well.  With the repo name added to the git-prompt it
# becomes annoyingly long for a one line prompt, so it is now split in
# two lines.  The non-git prompt is still only one line.
# It may not be possible to add a status code as that
# functionality uses PROMPT_COMMAND in gitprompt already.
PS1="[${Blue}\$(date +%H:%M:%S)${ResetColor}] ${Green}\u${ResetColor}@${Green}\h${ResetColor}> "

export GIT_PAGER=/bin/cat
export PATH=~/foo:/home/jonssl/opt/vim/bin:${PATH}

#source ~/ansible-2.2.1.0-0.2.rc2/hacking/env-setup

if [ ${HOSTNAME} == "adm10alp" ] || [ ${HOSTNAME} == "adm01alp" ]
then
    # Only do the ssh-agent tango if there's an actual
    # interactive session, not for scp for example.
    /usr/bin/tty | grep -q "not a tty"
    if [ $? -ne 0 ]
    then
        if [ -z $SSH_AUTH_SOCK ]
        then
            eval $(ssh-agent -s)
            /usr/bin/tty | grep -q "not a tty"
            if [ $? -ne 0 ]
            then
                ssh-add "${HOME}/.ssh/id_rsa_$(hostname)"
                ssh-add "${HOME}/.ssh/id_rsa_adm01alp"
            fi

            rm ${HOME}/.ssh/ssh_auth_sock
            ln -sfv $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
            export SSH_AUTH_SOCK="${HOME}/.ssh/ssh_auth_sock"
        fi
    fi
fi

if [ -x /usr/local/bin/hostlist ]
then
    complete -W "$(hostlist)" ssh scp ping
fi

if [ -x /usr/local/libexec/usertool/sudossh ]
then
    . /usr/local/libexec/usertool/sudossh
fi
