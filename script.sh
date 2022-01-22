#!/bin/sh

set -x

{

echo "@"
echo "$@"

date

echo "TEST script"

pwd
ls
id

apk --no-cache add gcc g++ make

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

echo '
test: test.cpp
	gcc test.cpp -o test
' >Makefile

make
./test

exit 0

} 2>@1
