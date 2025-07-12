# Use powerline
USE_POWERLINE="true"
# Has weird character width
# Example:
#    is not a diamond
HAS_WIDECHARS="false"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

alias vi='vim -p'
alias wipe='shred -f -n 10 -s 4M -u -z '
alias get_latest_gcode="find /home/john/Downloads/3D -type f -iname '*.*gcode' -printf '%T+ %p\n' | sort -rn | head -n1 | cut -d' ' -f2-"

export GOPATH="${HOME?}/go"
path+=(${GOPATH?})
export PATH

# export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent
gpg-connect-agent updatestartuptty /bye > /dev/null
