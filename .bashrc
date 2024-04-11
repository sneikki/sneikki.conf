#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.welcome_screen ]] && . ~/.welcome_screen

_set_liveuser_PS1() {
    PS1='[\u@\h \W]\$ '
    if [ "$(whoami)" = "liveuser" ] ; then
        local iso_version="$(grep ^VERSION= /usr/lib/endeavouros-release 2>/dev/null | cut -d '=' -f 2)"
        if [ -n "$iso_version" ] ; then
            local prefix="eos-"
            local iso_info="$prefix$iso_version"
            PS1="[\u@$iso_info \W]\$ "
        fi
    fi
}
_set_liveuser_PS1
unset -f _set_liveuser_PS1

ShowInstallerIsoInfo() {
    local file=/usr/lib/endeavouros-release
    if [ -r $file ] ; then
        cat $file
    else
        echo "Sorry, installer ISO info is not available." >&2
    fi
}


alias ls='ls -F --color=auto'
alias ll='ls -Flav --ignore=..'   # show long listing of all except ".."
alias l='ls -Flav --ignore=.?*'   # show long listing but no hidden dotfiles except "."
alias tree='tree -FCL 2 -I ".git" -I "node_modules" --gitignore --noreport --dirsfirst'
alias tred='tree -d'
alias trel='tree -L'
alias tredl='tred -L'
alias gitree='trel 1 -av'
alias watch:any="watch --color --interval 1 --no-title"
alias watch:git="watch:any git"
alias lg=lazygit
alias r=ranger

[[ "$(whoami)" = "root" ]] && return

[[ -z "$FUNCNEST" ]] && export FUNCNEST=100          # limits recursive functions, see 'man bash'

## Use the up and down arrow keys for finding a command in history
## (you can write some initial letters of the command first).
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

################################################################################
## Some generally useful functions.
## Consider uncommenting aliases below to start using these functions.
##
## October 2021: removed many obsolete functions. If you still need them, please look at
## https://github.com/EndeavourOS-archive/EndeavourOS-archiso/raw/master/airootfs/etc/skel/.bashrc

_open_files_for_editing() {
    # Open any given document file(s) for editing (or just viewing).
    # Note1:
    #    - Do not use for executable files!
    # Note2:
    #    - Uses 'mime' bindings, so you may need to use
    #      e.g. a file manager to make proper file bindings.

    if [ -x /usr/bin/exo-open ] ; then
        echo "exo-open $@" >&2
        setsid exo-open "$@" >& /dev/null
        return
    fi
    if [ -x /usr/bin/xdg-open ] ; then
        for file in "$@" ; do
            echo "xdg-open $file" >&2
            setsid xdg-open "$file" >& /dev/null
        done
        return
    fi

    echo "$FUNCNAME: package 'xdg-utils' or 'exo' is required." >&2
}

#------------------------------------------------------------

## Aliases for the functions above.
## Uncomment an alias if you want to use it.
##

# alias ef='_open_files_for_editing'     # 'ef' opens given file(s) for editing
# alias pacdiff=eos-pacdiff
################################################################################

add_to_path () {
    PATH="$1:$PATH"
}


export FLYCTL_INSTALL="/home/nuutti/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

add_to_path "~/.bin:$PATH"
add_to_path "~/.local/bin:$PATH"
add_to_path "~/.fly"
add_to_path "~/.dotnet/tools"

shopt -s checkwinsize
shopt -s histappend

# colors for less manpages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

export HISTFILESIZE=10000
export HISTSIZE=500
export HISTCONTROL=erasedups:ignoredups:ignorespace

export VISUAL=nvim
export EDITOR=vim

git-branch() {
  git rev-parse --abbrev-ref HEAD 2> /dev/null
}

git-dirty() {
  [[ $(git status --porcelain 2> /dev/null) ]] && echo "+"
}

git-info() {
  git rev-parse 2> /dev/null && echo " [$(git-branch)$(git-dirty)]"
}

workdir() {
  pwd | sed -E -e "s|^$HOME|~|" -e "s:(/[^/]+)((/[^/]+)+)((/[^/]+){2}):\1/...\4:"
}

get_git() {
  echo '$(\
    if git rev-parse --is-inside-work-tree &> /dev/null; then \
      dirty=$(git-dirty); \
      info=" "
      (( ${#dirty} > 0 )) && info+="\[\e[1;33m\]" || info+="\[\e[2;34m\]"; \
      info+="($(git-branch)$(git-dirty))\[\e[0m\]";\
      echo "$info"
    else \
      echo ""; \
    fi)'
}

colorize() {
  echo "\[\e[$1m\]$2"
}

PROMPT_DIRTRIM=2
prompt_ps1=
# prompt_ps1+=$(colorize "2;34" '\u@')
prompt_ps1+=$(colorize "35" '\w')
prompt_ps1+=$(colorize "0")
# prompt_ps1+=$(get_git)
prompt_ps1+=$(colorize "33" " $ ")
prompt_ps1+=$(colorize "0")
# prompt_ps1+=$(colorize "33;1" " :: ")

prompt_ps2=
prompt_ps2+=$(colorize "35;1" ">> ")
prompt_ps2+=$(colorize)

export PS1=$prompt_ps1
export PS2=$prompt_ps2

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(rbenv init - bash)"
