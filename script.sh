#!/bin/bash

set -x

if [[ -n "$1" ]]
then
    ajaxheader="HTTP/1.1 200 OK\nServer: cweb/1.0\nAccess-Control-Allow-Headers: X-Requested-With\nAccess-Control-Allow-Origin: *\nConnection: close\nContent-Type: text\n\n"
    requestsring=${1%?}
    part=($requestsring)

    echo -e "$ajaxheader"

    action="${part[0]}"
    context="${part[1]%\?*}"
    parameter="${part[1]#*\?}"

    if [[ "$action" == "OPTIONS" ]]
    then
        exit

    elif [[ "$context" == "/someshit" ]]
    then
        echo "thats nice"

    elif [[ "$context" == "/run" ]]
    then
        command=`echo "$parameter" |base64 -d`

        echo "command=|$command|"

        $command 2>&1

    elif [[ "$context" == "/dosummat" ]]
    then
        hostname 2>&1

    elif [[ "$context" == "/build" ]]
    then
        set -x

        {

        apt install -y gcc g++ make

        echo '#include <stdio.h>
        int main()
        {
            puts ("Hello");
            return 0;
        }
        ' >test.cpp


        gcc test.cpp -o test
        ./test
        rm -vf test

        echo -e '
        test: test.cpp
\tgcc test.cpp -o test
        ' >Makefile

        make
        ./test

        exit 0

        } 2>&1

    else
        echo "request=|${requestsring}| context=|${context}| parameter=|${parameter}|"

        echo -e "$(date) request=|${requestsring}| part[1]=|${part[1]}|"
    fi

    exit
else

    echo "prepare"

    while nc -v -k -l -p 80 -c 'read request; '"$0"' "$request"'
    do
        echo "next"
    done

    echo "done"
fi
