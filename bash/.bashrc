. ~/.git-completion.bash
. ~/.git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=true
export PS1='[\u@\h \w$(__git_ps1)]\$ '

SCRIPTS='~/Repositories/UnixSettings/scripts'
export PATH=$SCRIPTS:$PATH
