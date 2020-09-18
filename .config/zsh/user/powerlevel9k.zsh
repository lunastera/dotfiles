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
