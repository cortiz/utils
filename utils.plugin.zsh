## alias
PARENT=`dirname $0`
SELF=${BASH_SOURCE[0]:-${(%):-%x}}
alias untar='tar -zxvf '
alias sha256='shasum -a 256'
alias sha512='shasum -a 512'
alias www='python -m http.server 8000'
alias ipe='curl ipinfo.io/ip'
alias stmp='$PARENT/fakesmtp.py'
alias ff='find . -type f -name'
alias k8='kubectl'
alias dk='docker'
alias ccat='highlight'
alias ncat='cat -n'
alias nccat='highlight -n'
## Functions
#

# view Basic Certificate info
viewcert(){
openssl x509 -in $1 --serial --subject --issuer --dates --fingerprint --noout -nameopt multiline -purpose
}
# Use lf to switch directories and bind it to ctrl-o

## view Basic Certificate Request info
viewreq(){
openssl req -in $1  --subject  --noout -nameopt multiline
}

## Creates a Random String
genpwd(){
if [ -z "$1" ];
then
    SIZE=16
else
    SIZE="$1"
fi
 cat /dev/urandom | tr -dc 'a-zA-Z0-9~%^&*()_+-=><?' | fold -w $SIZE | head -n 1
}

# Use lf to switch directories and bind it to ctrl-o
 lfcd () {

 tmp="$(mktemp)"
 lf -last-dir-path="$tmp" "$@"
 if [ -f "$tmp" ]; then
    dir="$(cat "$tmp")"
    rm -f "$tmp"
    [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
 fi
}

bindkey -s '^o' 'lfcd\n'

## Reload Zsh File
reload(){ 
    source ~/.zshrc
}

mkcd() { 
    mkdir -p $1; cd $1 
}

pid() {
   ps aux | grep $1 | awk '{print $2 " " $11}'
}

encrypt() {
    if [ ! -f "$1" ];then
        echo "Need a file to encrypt"
    fi
    openssl enc -in "$1" -aes-256-cbc -base64 -iter 2048
}

decrypt() {
    if [ ! -f "$1" ];then
        echo "Need a file to encrypt"
    fi
    openssl enc -d -in "$1" -aes-256-cbc -base64 -iter 2048 
}

oport(){
    if [  -z "$1" ]; then
        echo "Port number need"
    else
        if  [[ `command -v ss 2>/dev/null` ]]; then 
            sudo ss -tlpn | grep $1
        else
            sudo netstat -tlpn | grep $1
        fi
    fi
}
