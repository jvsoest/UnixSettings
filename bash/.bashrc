source ~/.git-completion.bash
source ~/.git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=true

COLOR_RED="$(echo -e "\033[0;31m")"
COLOR_YELLOW="$(echo -e "\033[0;33m")"
COLOR_GREEN="$(echo -e "\033[0;32m")"
COLOR_OCHRE="$(echo -e "\033[38;5;95m")"
COLOR_BLUE="$(echo -e "\033[0;34m")"
COLOR_MAGENTA="$(echo -e "\033[0;105M")"
COLOR_WHITE="$(echo -e "\033[0;37m")"
COLOR_RESET="$(echo -e "\033[0m")"

export PS1='[\[${COLOR_GREEN}\]\u\[${COLOR_RESET}\]@\[${COLOR_OCHRE}\]\h \[${COLOR_BLUE}\]\w\[${COLOR_YELLOW}\]$(__git_ps1)\[${COLOR_RESET}\]]\$ ' 

SCRIPTS='~/Repositories/UnixSettings/scripts'
export PATH=$SCRIPTS:$PATH
