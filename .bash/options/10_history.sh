export HISTCONTROL=ignoredups
export HISTFILESIZE=10000000
export HISTSIZE=10000000
export HISTIGNORE=" *:&:hg*:history*:ls:ll:la:lla:l:clear:bg:fg"
export HISTTIMEFORMAT='%F %T '

#Write out history after each command
export PROMPT_COMMAND='history -a'

#append to the history file, don't overwrite it
shopt -s histappend


