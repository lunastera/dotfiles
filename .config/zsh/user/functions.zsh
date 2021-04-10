# Util functions
# ==============

# for checking 256 colors
function 256color() {
  for i in {0..255} ; do
    printf "\x1b[48;5;%sm%3d\e[0m " "$i" "$i"
    if (( i == 15 )) || (( i > 15 )) && (( (i-15) % 6 == 0 )); then
      printf "\n";
    fi
  done
}

# zsh title
function chpwd() {
	echo -ne "\033]0;$(pwd | rev | awk -F \/ '{print "/"$1"/"$2}'| rev)\007"
}

# for sbt
function set-hostname() {
  scutil --set HostName $(scutil --get LocalHostName)
}

# using commands in the local node_modules
# npmbin [command]
npmbin(){[ $# -ne 0 ] && $(npm bin)/$*}
