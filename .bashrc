#-----------------------------------
# global define
#-----------------------------------

if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

#-----------------------
# Greeting, motd etc...
#-----------------------

# Colors
red='\e[0;31m'
RED='\e[1;31m'
blue='\e[0;34m'
BLUE='\e[1;34m'
cyan='\e[0;36m'
CYAN='\e[1;36m'
green='\e[0;32m'
GREEN='\e[1;32m'
yellow='\e[0;33m'
YELLOW='\e[1;33m'
purple='\e[0;35m'
PURPLE='\e[1;35m'
grey='\e[0;37m'
NC='\e[0m'              # No Color


if [ `id -u` -eq 0 ]; then
    USERCOLOR=$RED
    SUFFIX="#"
else
    SUFFIX="$"
fi

#---------------
# Prompt
#---------------

function powerprompt()
{
    PS1="\[${USERCOLOR}\]\u\[${green}\]@\[${BLUE}\]\h\[${GREEN}\]: \[${PURPLE}\]\w\[${GREEN}\] \[${PURPLE}\]\[${PURPLE}\]\!\[${green}\]$SUFFIX\[${NC}\] " #;;
}

powerprompt

#-------------------
# aliases
#-------------------
alias h='history'
alias j='jobs -l'
alias r='rlogin'
alias ..='cd ..'
alias path='echo -e ${PATH//:/\\n}'

# ls version
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.flac=01;35:*.mp3=01;35:*.mpc=01;35:*.ogg=01;35:*.wav=01;35:';
alias la='ls -al --color=auto'
alias ll='ls -l --color=auto'
alias ls='ls --color=auto'

# strange aliases
alias removepyc="find . -name '*.pyc' -delete -print"
alias mkdirdate="mkdir `date +%Y%m%d`"
alias vimdatefile="vim `date +%Y%m%d`.txt"
export PYTHONSTARTUP=~/.pythonrc

# for less
alias more='less'
export PAGER=less
export LESSCHARSET='UTF-8'
export LESS='-i -w  -z-4 -g -e -M -X -F -R -P%t?f%f \
:stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'

export EDITOR=vim

export DEBFULLNAME='Konstantin Nikiforov'
export DEBEMAIL=nikiforov.ks@gmail.com


#-----------------------------------
# Functions for system
#-----------------------------------

function my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }
function pp() { my_ps f | awk '!/awk/ && $0~var' var=${1:-".*"} ; }

function my_ip() # get ip addresses
{
    MY_IP=$(/sbin/ifconfig | awk '/inet/ { print $2 } ' | sed -e s/addr://)
}

function ii()   # Quick info
{
    echo -e "\n${RED}`hostname`"
    echo -e "\nAdditional info :$NC " ; uname -a
    echo -e "\n${RED}Who is logged:$NC " ; w -h
    echo -e "\n${RED}Date:$NC " ; date
    echo -e "\n${RED}Uptime :$NC " ; uptime
    echo -e "\n${RED}Memory :$NC " ; free
    my_ip 2>&- ;
    echo -e "\n${RED}IP adresses :$NC";
    for i in $MY_IP
    do
        echo $i
    done
    echo
}

# other utilits
function my_watch()
{
    while :;
    do
        clear
        echo "Run: $@"
        echo
        eval "$@"
        sleep 1
    done
}

function create_profile_archive(){
    TMP_PROFILE_ARCHIVE="/tmp/${USER}.profile.tar.gz"
    cd ~
    find .bashrc .pythonrc .vimrc .vim -not -name .netrwhist -not -path '.vim/plugged/*' -type f -print0 | xargs -r -0   tar -czvf $TMP_PROFILE_ARCHIVE
    cd - >/dev/null
    echo
    ls -lh $TMP_PROFILE_ARCHIVE
}

if [ $TERM == "screen" ]; then
        settitle() {
                printf "\033k$1\033\\"
        }

        ssh() {
            n=$#;
            settitle ${!n}
            /usr/bin/ssh $*
        }
fi


shopt -s extglob
set +o nounset

complete -A hostname   telnet ping ssh
complete -A variable   export local readonly unset
complete -A enabled    builtin
complete -A alias      alias unalias
complete -A function   function
complete -A user       su mail finger

complete -A helptopic  help
complete -A shopt      shopt
complete -A stopped -P '%' bg
complete -A job -P '%'     fg jobs disown

complete -A directory  mkdir rmdir
complete -A directory   -o default cd

complete -W "$(ls /etc/init.d/)" service chkconfig

# Archive
complete -f -o default -X '*.+(zip|ZIP)'  zip
complete -f -o default -X '!*.+(zip|ZIP)' unzip
complete -f -o default -X '*.+(z|Z)'      compress
complete -f -o default -X '!*.+(z|Z)'     uncompress
complete -f -o default -X '*.+(gz|GZ)'    gzip
complete -f -o default -X '!*.+(gz|GZ)'   gunzip
complete -f -o default -X '*.+(bz2|BZ2)'  bzip2
complete -f -o default -X '!*.+(bz2|BZ2)' bunzip2

_get_longopts ()
{
    $1 --help | sed  -e '/--/!d' -e 's/.*--\([^[:space:].,]*\).*/--\1/'| \
grep ^"$2" |sort -u ;
}

_longopts_func ()
{
    case "${2:-*}" in
        -*)     ;;
        *)      return ;;
    esac

    case "$1" in
        \~*)    eval cmd="$1" ;;
        *)      cmd="$1" ;;
    esac
    COMPREPLY=( $(_get_longopts ${1} ${2} ) )
}
complete  -o default -F _longopts_func configure bash wget curl id info ls

# GoPath
export GOPATH=~/go
export PATH=$PATH:/usr/lib/go-1.9/bin:$GOPATH/bin

# system autocomplets
[[ -f /etc/bash_completion ]] && source /etc/bash_completion

# local bashrc file
[[ -f ~/.bashrc_local ]] && source ~/.bashrc_local
