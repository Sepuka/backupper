#!/usr/bin/env bash
case $# in
    2) pathFrom=$1; pathTo=$2 ;;
    *) echo "Expected first parameter for archive, second - destination path"; exit 1 ;;
esac

dirName=`basename $pathFrom`
fileName=`date +"%Y-%m-%d_%H:%M:%S"`
pathFull="$pathTo/$dirName""_""$fileName.tar.gz"

if ! test -w $pathTo
then
    echo "unable to write $pathTo"
    exit 1
else
    tar czf $pathFull $pathFrom
fi

if [ $? == 0 ]
then
    echo "archive was created in $pathFull"
else
    echo "error archiving"
    exit 1
fi
