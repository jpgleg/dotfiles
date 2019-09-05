function extract() {
  # TODO(john): Make this take an optional target directory?
  if [ -f "$1" ] ; then
    case "$1" in
      *.tar.bz2) tar xvjf "$1" ;;
      *.tar.gz) tar xvzf "$1" ;;
      *.bz2) bunzip2 "$1" ;;
      *.rar) rar x "$1" ;;
      *.gz) gunzip "$1" ;;
      *.tar) tar xvf "$1" ;;
      *.tbz2) tar xvjf "$1" ;;
      *.tgz) tar xvzf "$1" ;;
      *.zip) unzip "$1" ;;
      *.Z) uncompress "$1" ;;
      *.7z) 7z x "$1" ;;
      *) echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

function dedupe() {
  if [[ $# -lt 1 ]]; then
    echo 'Usage: dedupe [-i (in place)] <list of files from which to remove duplicate lines>'
    return
  fi

  local awk_pattern='!($0 in a){a[$0];print}'
  if [[ $1 == '-i' ]]; then local in_place=1; shift; fi

  for file in "${@}"; do
    if [[ "${in_place}" ]]; then
      awk "${awk_pattern}" "${file}" | sponge "${file}"
    else
      awk "${awk_pattern}" "${file}"
    fi
  done
}

# Switch between space and comma separated lists.
function sep() {
  input=${@:-`cat /dev/stdin`};  a=' '; b=',';
  if [[ "${input}" == *,* ]]; then a=','; b=' '; fi
  echo "${input}" | sed -r "s/$a+/$a/g;s/$a/$b/g;"
}

# Cymru IP->ASN mapping
# http://www.team-cymru.com/IP-ASN-mapping.html
function ip_to_asn() {
  ip_addresses="${@:-`cat /dev/stdin`}"
  ip_addresses="$(echo ${ip_addresses} | xargs | tr ' ' '\n')"
  echo -e "begin\n${ip_addresses}\nend" | \
    nc whois.cymru.com 43
}

alias wipe='shred -f -n 10 -s 4M -u -z '
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Pipe to X clipboard.
alias clip='xclip -selection c'

# Always load vim with tabbed pages.
alias v{i,im}='/usr/bin/vim -p'

# Typos and common stupidities.
alias ':q'='exit'

# enable colors in ls and greps
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
  eval "`dircolors -b`"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
fi
