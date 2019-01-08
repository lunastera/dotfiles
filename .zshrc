# 重いときにこれで調べよう！
# zmodload zsh/zprof && zprof

# これがないとtmuxくんに怒られる ないならないでいい感じのテーマになる
export TERM="xterm-256color"

export ZSH=/Users/era/.oh-my-zsh

# ZSH_THEME="agnoster"
ZSH_THEME="powerlevel9k/powerlevel9k"

# highlight -> suggestionの順じゃないと何故か爆発する
plugins=(
  git
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# path PATH MANPATHにユニーク属性をつける 値が重複しなくなる
# typeset -U path PATH MANPATH

# どこにおいても対して変わらない環境変数達
export LANG=ja_JP.UTF-8
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export PATH="$PATH:/Applications/MAMP/bin/php/php5.4.10/bin"
export PATH="$HOME/.nodebrew/current/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export MANPATH="/usr/local/share/man:$MANPATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
#export JAVA_HOME=`/usr/libexec/java_home -v "11"`
#export PATH="$JAVA_HOME/bin:$PATH"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_112patched.jdk/Contents/Home"
#export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-11.0.1.jdk/Contents/Home"
export PATH="/usr/local/bin/scala/bin:$PATH"
export SCALA_HOME="/usr/local/bin/scala"
export GIT_EDITOR=vim
export PATH="$HOME/.stack/stack-1.6.5:$PATH"
export GOPATH="$HOME/.go"
export GOPATH="$GOPATH/bin"
# ============== nodebrew ==============
# export NODEBREW_HOME="/usr/local/var/nodebrew/current"

# export NODEBREW_ROOT="/usr/local/var/nodebrew"

export PATH="/usr/local/var/nodebrew/current/bin:$PATH"

# ============== rbenv ==============
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# ============== cocos2d ==============
# Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
#export COCOS_CONSOLE_ROOT=/Applications/cocos2dx/cocos2d-x-3.11.1/tools/cocos2d-console/bin
#export PATH=$PATH:$COCOS_CONSOLE_ROOT
# Add environment variable COCOS_X_ROOT for cocos2d-x
#export COCOS_X_ROOT=/Applications/cocos2dx
#export PATH=$PATH:$COCOS_X_ROOT
# Add environment variable COCOS_TEMPLATES_ROOT for cocos2d-x
#export COCOS_TEMPLATES_ROOT=/Applications/cocos2dx/cocos2d-x-3.11.1/templates
#export PATH=$PATH:$COCOS_TEMPLATES_ROOT

# ============== python-system-pip ==============
# 必ずpip install --user　でインストールすること
# export PATH="$HOME/Library/Python/2.7/bin:$PATH"

# ============== thefuck ==============
eval $(thefuck --alias)

# ============== npmbin ===============
# ローカルのnode_modulesにPATHを通すコマンド
# npmbin [command]
npmbin(){[ $# -ne 0 ] && $(npm bin)/$*}

# ============== pyenv ~ powerline ==============
# export PATH="$HOME/.pyenv/bin:$PATH"
# brewとの干渉を避ける
# if which pyenv 2>&1 >/dev/null; then alias brew="env PATH=${PATH//$(pyenv root)\/shims:/} brew"; fi

# eval "$(pyenv init -)"

# 3.5.xのpowerline
#powerline-daemon -q
# . ~/.local/lib/python3.5/site-packages/powerline/bindings/zsh/powerline.zsh

# 3.6.xのpowerline
# source ~/Library/Python/3.6/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh

# system(2.7.x)のpowerline
#powerline-daemon -q
# . /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh

# ============== phpenv ==============
# rbenv改造してるせいか、rbenvよりPATHの優先順位が高くないとバグる
# export PATH="$HOME/.phpenv/bin:$PATH"

# eval "$(phpenv init -)"

# vimで操作遅いのを改善
KEYTIMEOUT=1
# gitコマンドでサブコマンドやブランチ名の補完ができるようになるやつ
fpath=(~/.zsh/completion $fpath)
# 色を使用可能に
autoload -Uz colors; colors

# 補完
autoload -U compinit
compinit -u
# title
function chpwd() {
	echo -ne "\033]0;$(pwd | rev | awk -F \/ '{print "/"$1"/"$2}'| rev)\007"
}

#===========オプション==============
# 日本語ファイル名表示可能
setopt print_eight_bit
# フリーコントロール無効
setopt no_flow_control
# ディレクトリ名だけでcd
setopt auto_cd
# cdで自動pushd
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups
# グロッビングの設定　正直ない方がいい
setopt nonomatch

# 空Enterで背景切り替え
# cbg数字で切り替え画像変更
# なんかグローバル化ー＞初期化でわけなあかんかった
typeset -g -a image_list
image_list=("" "/Users/era/Pictures/background/riuichi08.jpg")
image_index=1
function change_img() {
  # 数値以外が入る可能性がある場合こっち
     if [ $# -ne 1 ]; then
         image_list=("" "/Users/era/Pictures/background/riuichi08.jpg")
     else
         image_list=("" "/Users/era/Pictures/background/$1.jpg")
     fi
    # image_list=("" "/Users/era/Pictures/background/background$1.jpg")
}
toggle_bg() {
  # Enter押した時＄Bufferに何もなかったら
  if [ -z "$BUFFER" ]; then
    # indexが2なら1に設定
    if test $image_index -eq 2; then
      image_index=1
    else
			image_index=$(($image_index+1))
    fi
    image_path=$image_list[$image_index]
		# osascriptで背景設定
    osascript -e "tell application \"iTerm\"
      tell current session of first window
				set background image to \"$image_path\"
      end tell
    end tell"
    zle reset-prompt
    # 構文解釈して次の行へ
  else
    # こっちも設定しとかないと大変なことになる(Enterが押せない)
    zle accept-line
  fi
}

# Enterにバインド
zle -N toggle_bg
bindkey '^m' toggle_bg

function gitlab() {
	if test $1 = up; then
		docker-compose -f /Users/era/docker/gitlab/docker-compose.yml start
	elif test $1 = down; then
		docker-compose -f /Users/era/docker/gitlab/docker-compose.yml stop
	else
		echo "$1 : not command."
	fi
}

function show() {
	cmd="\${$1//:/'\n'"
	eval "$(echo -e $cmd)"
}

function 256color() {
  for i in {0..255} ; do
    printf "\x1b[48;5;%sm%3d\e[0m " "$i" "$i"
    if (( i == 15 )) || (( i > 15 )) && (( (i-15) % 6 == 0 )); then
      printf "\n";
    fi
  done
}

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

# alias
alias -s rb='ruby'
alias -s py='python3'
alias -s php='php -f'
alias python="pyhton3"
alias cbg='change_img'
alias mumei='change_img mumei01'
alias riuichi='change_img riuichi1'
alias la='ls -a'
alias ll='ls -l'
alias tma='tmux a -t'
alias dps='docker ps --format "table {{.Names}}\t{{.RunningFor}}\t{{.Status}}\t{{.Ports}}"'

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

#POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{cyan}\u256D\u2500%f"
#POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="╭─%f"
# POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="╰─%F{008}\uF460 %f"
#POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
#POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{008}> %f"

POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="╭"
# POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="❱ "
# POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="╰\uF460 "
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
