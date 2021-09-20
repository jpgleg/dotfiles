# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export HISTCONTROL=ignoreboth
export HISTIGNORE="cd:cd ..:ls:ls -al:history:tmux:screen:top:[bf]g:exit:logout"
export HISTSIZE=1000000
export HISTTIMEFORMAT=""

shopt -s checkwinsize cdspell checkhash cmdhist histappend no_empty_cmd_completion

# uncolored user@host:cwd$
export PS1='\u@\h:\w\$ '

# If this is an xterm set the title to user@host:dir
if [[ "$TERM" =~ xterm*|rxvt* ]]; then
  title_string='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
  PROMPT_COMMAND="${title_string}"
fi
PROMPT_COMMAND="history -a; ${PROMPT_COMMAND}"

# set some default variables
export EDITOR='vim -p'
export TZ='America/Los_Angeles'
umask 0026

# Source various files and other bash utilities
export GOPATH="${HOME}/go"
source_files=(
  "${HOME}/.bash_aliases"
  "${HOME}/bin"
  "${GOPATH}/bin"
  '/etc/bash_completion'
)

for filename in ${source_files[@]}; do
  if [ -f "${filename}" ]; then
    source "${filename}" 2>&1 > /dev/null
  elif [ -d "${filename}" ]; then
    if [[ ! "${PATH}" =~ .*${filename}.* ]]; then
      export PATH="${PATH}:${filename}"
    fi
  fi
done

if [[ "${HOSTNAME}" == *"myrkul"* ]]; then
  export GPG_TTY="$(tty)"
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  gpgconf --launch gpg-agent
fi
