#!/bin/sh

if [ $# -eq 0 ]; then
    echo useless
    exit 0
fi

os=`uname -s`

case $os in
Linux)
    comment="xclip -sel clip"
    ;;
Darwin)
    comment="pbcopy"
    ;;
*)
    echo "not support"
    exit 1
    ;;
esac

count=0

for fn in $@
do
    case $fn in
    *.sh | *.py)
        annotation="# $fn"
        ;;
    *.sql)
        annotation="--- $fn"
        ;;
    *.html)
        annotation="<-- $fn -->"
        ;;    
    *)
        annotation="// $fn"
        ;;
    esac

    echo $annotation
    cat $fn
    ((count++))
    if [ $# -ne $# ]; then
        echo
    fi
done | $comment
