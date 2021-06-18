# Utlity renames
alias cat="bat"
alias mk="mkdir -p"
alias mkdir="mkdir -p"
alias mv="mv -v"
alias rm="rm -v"
alias cp="cp -v"
alias files="ll | grep \"^-\""
alias directories="ll | grep \"^d\""
alias cls="clear"
alias clr="clear"
alias clrscr="clear"
alias finder="open ."

# Searches
alias search="find . -name"
alias fsearch="find . -type f -name"
alias dsearch="find . -type d -name"
alias quit='/usr/bin/osascript -e "tell application \"$TERMINAL\" to quit";exit'

# Web
alias hosts="sudo $EDITOR /etc/hosts"
alias flushdns="dscacheutil -flushcache"
alias ip="ipconfig getifaddr en0"
alias pubip="dig @resolver4.opendns.com myip.opendns.com +short"
alias pubip6="dig @resolver1.ipv6-sandbox.opendns.com AAAA myip.opendns.com +short -6"
