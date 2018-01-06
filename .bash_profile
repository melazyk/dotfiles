profile_host="https://github.com"
profile_uri="/melazyk/dotfiles/archive/current.tar.gz"
flag_file="$HOME/.bashrc"

update_profile () {
    echo "Updating profile:"
    echo -e "   wget --timeout=5 -qO- ${profile_host}${profile_uri}\n\n"
    wget --timeout=5 -qO- ${profile_host}${profile_uri} | tar --strip-components=1 --exclude README.md -xzvf- -C ~/
    touch $flag_file
}

check_update_profile () {
    local tardate=`wget --timeout=1 -qS --spider ${profile_host}${profile_uri} 2>&1 | awk -F\:\  '/Last-Modified/ {print $2}'`
    if [ -n "$tardate" ] ; then
      [ ! -f $flag_file ] && update_profile && return
      local tarts=`date +%s --date="$tardate"`
      local locts=`stat -c '%Y' $flag_file`
      if [ $tarts -gt $locts ] ; then
        update_profile
      fi
    fi
}

type -p wget >/dev/null && \
type -p date >/dev/null && \
type -p stat >/dev/null && \
type -p echo >/dev/null && \
type -p tar >/dev/null && \
type -p touch >/dev/null && \
type -p awk >/dev/null && \
check_update_profile

[ -f ~/.bashrc ] && . ~/.bashrc
