# zprof
# zmodload zsh/zprof && zprof

export TERM="xterm-256color"

# XDG Base Directory Specification
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache

ZROOTDIR=$XDG_DATA_HOME/zsh

# history
HISTFILE=$ZROOTDIR/histfile
HISTSIZE=10000000
SAVEHIST=10000000
setopt hist_ignore_dups     # 直前と同じコマンドは履歴に追加しない
setopt hist_ignore_all_dups # 重複したコマンドは古い方をすべて削除
setopt inc_append_history   # イクリメンタルに履歴追加
setopt hist_reduce_blanks   # 余分な空白は詰めて保存

# oh-my-zsh
export ZSH=$XDG_DATA_HOME/ohmyzsh
ZSH_CUSTOM=$XDG_CONFIG_HOME/ohmyzsh/custom
ZSH_THEME="powerlevel9k/powerlevel9k"

plugins=(
  git
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# environment
typeset -U PATH MANPATH fpath

export LANG=ja_JP.UTF-8
export GIT_EDITOR=vim
KEYTIMEOUT=1

export FZF_DEFAULT_OPTS="--reverse --ansi --select-1 --border"
# export SBT_OPTS="-Dsbt.global.base=$XDG_CACHE_HOME/sbt -Dsbt.boot.directory=$XDG_CACHE_HOME/sbt/boot -Dsbt.preloaded=$XDG_CACHE_HOME/sbt/preloaded -Dsbt.global.staging=$XDG_CACHE_HOME/sbt/staging -Dsbt.global.zinc=$XDG_CACHE_HOME/sbt/zinc -Dsbt.dependency.base=$XDG_CACHE_HOME/sbt/dependency -Dsbt.repository.config=$XDG_CONFIG_HOME/sbt/repositories -Dsbt.global.settings=$XDG_CONFIG_HOME/sbt/global -Dsbt.global.plugins=$XDG_CONFIG_HOME/sbt/plugins -Dsbt.ivy.home=$XDG_CACHE_HOME/ivy2"
export MAVEN_OPTS="-Dmaven.repo.local=$XDG_CACHE_HOME/m2/repository"
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export MANPATH=/usr/local/share/man:$MANPATH
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/
export CARGO_HOME=$XDG_DATA_HOME/cargo
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export STACK_ROOT=$XDG_DATA_HOME/stack
export GOPATH=$XDG_DATA_HOME/go
export SDKMAN_DIR=$XDG_DATA_HOME/sdkman
export JAVA_HOME=$SDKMAN_DIR/candidates/java/current
export ANYENV_ROOT=$XDG_DATA_HOME/anyenv
export POETRY_HOME=$XDG_DATA_HOME/poetry

export GEM_HOME=$XDG_CACHE_HOME/gem
export GEM_SPEC_CACHE=$GEM_HOME/specs
export BUNDLE_USER_HOME=$XDG_CACHE_HOME/bundle
export PERL_CPANM_HOME=$XDG_CACHE_HOME/cpanm
export SOLARGRAPH_CACHE=$XDG_CACHE_HOME/solargraph
export CP_HOME_DIR=$XDG_CACHE_HOME/cocoapods
export ELM_HOME=$XDG_CACHE_HOME/elm
export GORE_HOME=$XDG_CACHE_HOME/gore
export NPM_CONFIG_CACHE=$XDG_CACHE_HOME/npm
export IPYHTONDIR=$XDG_CACHE_HOME/ipython
export DOCKER_TMPDIR=$XDG_CACHE_HOME/docker

export ANYENV_DEFINITION_ROOT=$XDG_CONFIG_HOME/anyenv/anyenv-install
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export DOCKER_CONFIG=$XDG_CONFIG_HOME/docker
export JUPYTER_CONFIG_DIR=$XDG_CONFIG_HOME/jupyter
export AWS_CONFIG_FILE=$XDG_CONFIG_HOME/aws/config
export AWS_SHARED_CREDENTIALS_FILE=$XDG_CONFIG_HOME/aws/credentials

export PATH=/usr/local/sbin:/usr/local/bin:$PATH
export PATH=$POETRY_HOME/bin:$PATH
export PATH=$XDG_DATA_HOME/bin:$PATH
export PATH=$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH
export PATH=$JAVA_HOME/bin:$PATH
export PATH=/usr/local/opt/mysql@5.6/bin:$PATH
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
export PATH=$STACK_ROOT:$PATH
export PATH=$CARGO_HOME/bin:$RUSTUP_HOME/bin:$PATH
export PATH=$ANYENV_ROOT/bin:$PATH
export PATH=$GOPATH/bin:$PATH

# option
setopt print_eight_bit    # 日本語ファイル名表示可能
setopt no_flow_control    # Ctrl+S/Ctrl+Q によるフロー制御を無効
setopt auto_cd            # ディレクトリ名だけでcd
setopt auto_pushd         # cdで自動pushd
setopt pushd_ignore_dups  # pushd時、重複したディレクトリを追加しない

# complete
fpath=($ZROOTDIR/completion $fpath)
fpath=($ZROOTDIR/zfunc $fpath)

autoload -Uz compinit && compinit
autoload -Uz colors && colors

zstyle ':completion:*' format '%BCompleting %d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' completer _oldlist _complete _history _match _ignored _prefix

zstyle ':completion:*:default' menu select=1  # 補完候補を ←↓↑→ で選択 (補完候補が色分け表示される)

# zmv
autoload -Uz zmv
alias zmv='noglob zmv'

# alias
alias la='ls -a'
alias ll='ls -l'
alias tma='tmux a -t'
alias dps='docker ps --format "table {{.Names}}\t{{.RunningFor}}\t{{.Status}}\t{{.Ports}}"'

# suffix
alias -s sh=sh

# load scripts
eval "$(anyenv init -)"
[[ -s $SDKMAN_DIR/bin/sdkman-init.sh ]] && source $SDKMAN_DIR/bin/sdkman-init.sh
source $XDG_CONFIG_HOME/zsh/user/functions.zsh
source $XDG_CONFIG_HOME/zsh/user/powerlevel9k.zsh

if (type zprof > /dev/null 2>&1) ;then
  zprof | less
fi
