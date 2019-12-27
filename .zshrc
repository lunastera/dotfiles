# Use when the response is slow
# zmodload zsh/zprof && zprof

# Without it, tmux does not work properly
export TERM="xterm-256color"

ZSH=$HOME/.oh-my-zsh
ZSH_THEME="powerlevel9k/powerlevel9k"

plugins=(
  git
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Give "PATH MANPATH fpath" a unique attribute
# Unique attributes prevent duplicate values
typeset -U PATH MANPATH fpath

export LANG=ja_JP.UTF-8
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export PATH="$HOME/.nodebrew/current/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export MANPATH="/usr/local/share/man:$MANPATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export PATH="/usr/local/bin/scala/bin:$PATH"
export SCALA_HOME="/usr/local/bin/scala"
export PATH="$HOME/.stack/stack-1.6.5:$PATH"
export GOPATH="$HOME/.go"
export PATH="$PATH:$GOPATH/bin"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
export LIBRARY_PATH="$LIBRARY_PATH:/usr/local/opt/openssl/lib/"
export GIT_EDITOR=vim

# ============== option ==============
setopt print_eight_bit    # 日本語ファイル名表示可能
setopt no_flow_control    # Ctrl+S/Ctrl+Q によるフロー制御を無効
setopt auto_cd            # ディレクトリ名だけでcd
setopt auto_pushd         # cdで自動pushd
setopt pushd_ignore_dups  # pushd時、重複したディレクトリを追加しない

# alias
alias la='ls -a'
alias ll='ls -l'
alias tma='tmux a -t'
alias dps='docker ps --format "table {{.Names}}\t{{.RunningFor}}\t{{.Status}}\t{{.Ports}}"'

# ESC delay resolution for vim
KEYTIMEOUT=1

# colors
# Used in complete
autoload -Uz colors
colors

# For checking 256 colors
function 256color() {
  for i in {0..255} ; do
    printf "\x1b[48;5;%sm%3d\e[0m " "$i" "$i"
    if (( i == 15 )) || (( i > 15 )) && (( (i-15) % 6 == 0 )); then
      printf "\n";
    fi
  done
}

# title
function chpwd() {
	echo -ne "\033]0;$(pwd | rev | awk -F \/ '{print "/"$1"/"$2}'| rev)\007"
}

# Mainly for sbt.
function set-hostname() {
  scutil --set HostName $(scutil --get LocalHostName)
}

# Using commands in the local node_modules
# npmbin [command]
npmbin(){[ $# -ne 0 ] && $(npm bin)/$*}

# ============== complete ==============
fpath=(~/.zsh/completion $fpath)
fpath+=~/.zfunc

autoload -U compinit
compinit

zstyle ':completion:*' format '%BCompleting %d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' completer _oldlist _complete _history _match _ignored _prefix

zstyle ':completion:*:default' menu select=1    # 補完候補を ←↓↑→ で選択 (補完候補が色分け表示される)

# ============== anyenv ==============
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

# ============== sdkman ==============
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# ============== poetry ==============
export PATH="$HOME/.poetry/bin:$PATH"

# ============== fzf ==============
export FZF_DEFAULT_OPTS="--reverse --ansi --select-1 --border"

function select-history() {
  BUFFER=$(history -n -r | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^r' select-history

function fd() {
  DIR=`find * -maxdepth 0 -type d -print 2> /dev/null | fzf-tmux` \
    && cd "$DIR"
}

function fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}
zle -N fda
bindkey "^f" fda

__docker_pre_test() {
  if [[ -z "$1" ]] && [[ $(docker ps --format '{{.Names}}') ]]; then
    return 0;
  fi

  if [[ ! -z "$1" ]] && [[ $(docker ps -a --format '{{.Names}}') ]]; then
    return 0;
  fi

  echo "No containers found";
  return 1;
}

docker-rm() {
  __docker_pre_test "all" && docker ps -a -f status=exited | fzf -m | awk '{print $1}' | while read -r name; do docker rm -f $name; done
}

function fzf-src () {
  local selected_dir=$(ghq list -p | fzf)
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
}
zle -N fzf-src
bindkey '^]' fzf-src

# fshow - git commit browser (enter for show, ctrl-d for diff)
function fshow() {
  local out shas sha q k
  while out=$(
      git log --graph --color=always \
          --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
      fzf --ansi --multi --no-sort --reverse --query="$q" \
          --print-query --expect=ctrl-d); do
    q=$(head -1 <<< "$out")
    k=$(head -2 <<< "$out" | tail -1)
    shas=$(sed '1,2d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
    [ -z "$shas" ] && continue
    if [ "$k" = ctrl-d ]; then
      git diff --color=always $shas | less -R
    else
      for sha in $shas; do
        git show --color=always $sha | less -R
      done
    fi
  done
}

# ============== powerlevel9k ==============

# Easily switch primary foreground/background colors
# DEFAULT_FOREGROUND=006 
# DEFAULT_BACKGROUND=235
DEFAULT_FOREGROUND=255 
DEFAULT_BACKGROUND=073 # purple=104
DEFAULT_COLOR=$DEFAULT_FOREGROUND

# powerlevel9k prompt theme
#DEFAULT_USER=$USER

POWERLEVEL9K_MODE="nerdfont-complete"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1               # 表示ディレクトリ数
#POWERLEVEL9K_SHORTEN_STRATEGY="truncate_right" # ディレクトリ短くする方法の指定

POWERLEVEL9K_DIR_OMIT_FIRST_CHARACTER=false

POWERLEVEL9K_ALWAYS_SHOW_CONTEXT=true
POWERLEVEL9K_ALWAYS_SHOW_USER=false

# POWERLEVEL9K_CONTEXT_TEMPLATE="\uF109 %m" # hostname
POWERLEVEL9K_CONTEXT_TEMPLATE="\ue737 %n" # username

POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="$DEFAULT_FOREGROUND"
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND="$DEFAULT_BACKGROUND"
POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND="$DEFAULT_FOREGROUND"
POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND="$DEFAULT_BACKGROUND"

# POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR="\uE0B4"
# POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR="%F{$(( $DEFAULT_BACKGROUND - 2 ))}|%f"
# POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR="\uE0B6"
# POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR="%F{$(( $DEFAULT_BACKGROUND - 2 ))}|%f"

POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=false

POWERLEVEL9K_STATUS_VERBOSE=true
POWERLEVEL9K_STATUS_CROSS=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="╭"
# POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="❱ "
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{014}\u2570%F{cyan}\uF460%F{073}\uF460%F{109}\uF460%f "

#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context ssh root_indicator dir_writable dir )
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon root_indicator context dir_writable dir vcs)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(root_indicator context dir_writable dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time background_jobs status time ssh)

POWERLEVEL9K_VCS_CLEAN_BACKGROUND="28"
POWERLEVEL9K_VCS_CLEAN_FOREGROUND="$DEFAULT_FOREGROUND"
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND="142"
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND="$DEFAULT_FOREGROUND"
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND="magenta"
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND="$DEFAULT_FOREGROUND"

POWERLEVEL9K_DIR_HOME_BACKGROUND="008"
POWERLEVEL9K_DIR_HOME_FOREGROUND="$DEFAULT_FOREGROUND"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="008"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="$DEFAULT_FOREGROUND"
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="008"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="$DEFAULT_FOREGROUND"
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND="008"
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="$DEFAULT_FOREGROUND"

POWERLEVEL9K_STATUS_OK_FOREGROUND="green"
POWERLEVEL9K_STATUS_OK_BACKGROUND="237"

POWERLEVEL9K_STATUS_ERROR_FOREGROUND="red"
POWERLEVEL9K_STATUS_ERROR_BACKGROUND="237"

POWERLEVEL9K_HISTORY_FOREGROUND="$DEFAULT_FOREGROUND"

POWERLEVEL9K_TIME_FORMAT="%D{%T \uF017}"
POWERLEVEL9K_TIME_FOREGROUND="$DEFAULT_FOREGROUND"
POWERLEVEL9K_TIME_BACKGROUND="$DEFAULT_BACKGROUND"

POWERLEVEL9K_VCS_GIT_GITHUB_ICON="\ue708"
POWERLEVEL9K_VCS_GIT_BITBUCKET_ICON="\uf171"
POWERLEVEL9K_VCS_GIT_GITLAB_ICON="\uf296"
POWERLEVEL9K_VCS_GIT_ICON=""

POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND="$DEFAULT_FOREGROUND"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND="$DEFAULT_BACKGROUND"
POWERLEVEL9K_EXECUTION_TIME_ICON="\u23F1"

#POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
#POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0

POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND="$DEFAULT_BACKGROUND"
POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND="$DEFAULT_FOREGROUND"

POWERLEVEL9K_USER_ICON="\uF415" # 
POWERLEVEL9K_USER_DEFAULT_FOREGROUND="$DEFAULT_FOREGROUND"
POWERLEVEL9K_USER_DEFAULT_BACKGROUND="$DEFAULT_BACKGROUND"
POWERLEVEL9K_USER_ROOT_FOREGROUND="$DEFAULT_FOREGROUND"
POWERLEVEL9K_USER_ROOT_BACKGROUND="$DEFAULT_BACKGROUND"

POWERLEVEL9K_ROOT_INDICATOR_FOREGROUND="$DEFAULT_FOREGROUND"
POWERLEVEL9K_ROOT_INDICATOR_FOREGROUND="magenta"
POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND="$DEFAULT_BACKGROUND"
POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND="$(( $DEFAULT_BACKGROUND + 2 ))"
POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND="$(( $DEFAULT_BACKGROUND - 2 ))"
#POWERLEVEL9K_ROOT_ICON=$'\uFF03' # ＃
POWERLEVEL9K_ROOT_ICON=$'\uF198'  # 

POWERLEVEL9K_SSH_FOREGROUND="$DEFAULT_FOREGROUND"
POWERLEVEL9K_SSH_FOREGROUND="yellow"
POWERLEVEL9K_SSH_BACKGROUND="$DEFAULT_BACKGROUND"
POWERLEVEL9K_SSH_BACKGROUND="$(( $DEFAULT_BACKGROUND + 2 ))"
POWERLEVEL9K_SSH_BACKGROUND="$(( $DEFAULT_BACKGROUND - 2 ))"
POWERLEVEL9K_SSH_ICON="\uF489"  # 

POWERLEVEL9K_HOST_LOCAL_FOREGROUND="$DEFAULT_FOREGROUND"
POWERLEVEL9K_HOST_LOCAL_BACKGROUND="$DEFAULT_BACKGROUND"
POWERLEVEL9K_HOST_REMOTE_FOREGROUND="$DEFAULT_FOREGROUND"
POWERLEVEL9K_HOST_REMOTE_BACKGROUND="$DEFAULT_BACKGROUND"

POWERLEVEL9K_HOST_ICON_FOREGROUND="$DEFAULT_FOREGROUND"
POWERLEVEL9K_HOST_ICON_BACKGROUND="$DEFAULT_BACKGROUND"
POWERLEVEL9K_HOST_ICON="\uF109" # 

POWERLEVEL9K_OS_ICON_FOREGROUND="$DEFAULT_FOREGROUND"
POWERLEVEL9K_OS_ICON_BACKGROUND="$DEFAULT_BACKGROUND"

POWERLEVEL9K_LOAD_CRITICAL_BACKGROUND="$DEFAULT_BACKGROUND"
POWERLEVEL9K_LOAD_WARNING_BACKGROUND="$DEFAULT_BACKGROUND"
POWERLEVEL9K_LOAD_NORMAL_BACKGROUND="$DEFAULT_BACKGROUND"
POWERLEVEL9K_LOAD_CRITICAL_FOREGROUND="red"
POWERLEVEL9K_LOAD_WARNING_FOREGROUND="yellow"
POWERLEVEL9K_LOAD_NORMAL_FOREGROUND="green"
POWERLEVEL9K_LOAD_CRITICAL_VISUAL_IDENTIFIER_COLOR="red"
POWERLEVEL9K_LOAD_WARNING_VISUAL_IDENTIFIER_COLOR="yellow"
POWERLEVEL9K_LOAD_NORMAL_VISUAL_IDENTIFIER_COLOR="green"

POWERLEVEL9K_BATTERY_LEVEL_BACKGROUND_COLOR="$DEFAULT_BACKGROUND"
POWERLEVEL9K_BATTERY_CHARGING_BACKGROUND="$DEFAULT_BACKGROUND"
POWERLEVEL9K_BATTERY_CHARGED_BACKGROUND="$DEFAULT_BACKGROUND"
POWERLEVEL9K_BATTERY_DISCONNECTED_BACKGROUND="$DEFAULT_BACKGROUND"

# 重いときに調べよう！！！
#if (which zprof > /dev/null) ;then
#  zprof | less
#fi
