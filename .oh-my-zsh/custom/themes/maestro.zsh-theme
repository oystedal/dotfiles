# user, host, full path, and time/date
# on two lines for easier vgrepping
# entry in a nice long thread on the Arch Linux forums: http://bbs.archlinux.org/viewtopic.php?pid=521888#p521888

# ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%}+"
# ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}✱"
# ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✗"
# ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}➦"
# ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%}✂"
# ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[grey]%}✈"

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%} a"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[red]%} m"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[yellow]%} d"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%} r"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%} unmerged"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%} u"

function mygit() {
  ref1=$(git symbolic-ref HEAD 2> /dev/null) || return
  ref2=$(git rev-parse HEAD | head -c 6) || return
  ref="$ref1 %{$fg[white]%}$ref2"
  # ref=$(git symbolic-ref HEAD 2> /dev/null) $(git rev-parse HEAD | head -c 6) || return
  echo "[$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$( git_prompt_status )%{$reset_color%}$ZSH_THEME_GIT_PROMPT_SUFFIX]"
}

function retcode() {}

# alternate prompt with git & hg
PROMPT=$'%{\e[0;35m%}%B┌─[%b%{\e[0m%}%{\e[1;32m%}%n%{\e[1;30m%}@%{\e[0m%}%{\e[0;36m%}%m%{\e[0;35m%}%B]%b%{\e[0m%}%b%{\e[0;35m%}%B[%b%{\e[1;37m%}%~%{\e[0;35m%}%B]%b%{\e[0m%}%{\e[0;35m%}%b%{\e[0m%}$(mygit)%{\e[0m%}%b 
%{\e[0;35m%}%B└─%{\e[0m%}%b '
# \e[0m%}
PS2=$' \e[0;34m%}%B>%{\e[0m%}%b '

