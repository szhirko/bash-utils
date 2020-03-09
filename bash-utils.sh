#!/bin/sh
#!/bin/bash

## version
VERSION="0.0.1"

checkDependencies() {
    
    hasUnresolvedDependencies=0

    while test "$1" != "" ; do
        toolName="$1"
        if test -z $(which "$toolName") 
        then
            echo "Required $toolName tool.\n"\
                 "To fix use:\n"\
                 "    sudo apt install $toolName"
            hasUnresolvedDependencies=1
        fi
        shift
    done

    # todo: remove script comtrol in common method
    if test $hasUnresolvedDependencies = 1 
    then
       exit 0;
    fi
}

echoError(){
    echo "$(tput setaf 1)$@$(tput sgr 0)"
}

echoWarning(){
    echo "$(tput setaf 3)$@$(tput sgr 0)"
}

echoSuccess(){
    echo "$(tput setaf 2)$@$(tput sgr 0)"
}

echoInfo(){
    echo "$(tput setaf 7)$(tput bold)$@$(tput sgr 0)"
}

echoDelimiter(){
    echoInfo "----------------------------------------"
}

trimSpaces(){
    result=$(echo "$1" | awk '{$1=$1};1')
    echo "$result";
}

call() {
    log "$@" 
    function=$1 
    shift;
    $function "$@"
}

log() {
    $(echo $(date '+%Y-%m-%d %H:%M:%S:%N') " " "$0" "$@" >> "$0.log") 
}
