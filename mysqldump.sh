#!/usr/bin/env bash
pathTo='/tmp'
dbuser='root'
dbpass='1'

check_bzip() {
    type bzip2 $2>1 $1>/dev/null
    if [ $? != 0 ]
    then
        echo 'bzip2 not found!'
        exit 1
    fi
}

check_bzip

if [ $# == 0 ]
then
        echo 'Expected Database names'
        exit 1
fi

for dbname in $*
do
        checkdb=`mysqlshow -u $dbuser -p$dbpass | grep $dbname`
        if ! [ "$checkdb" ]
        then
                echo "База данных '$dbname' несуществует!"
        else
                filedate=`date +"%Y-%m-%d_%H:%M:%S"`
                mysqldump -u $dbuser -p$dbpass $dbname | bzip2 > "$pathTo/$dbname-$filedate.sql.bz2"

                if [ $? == 0 ]
                then
                        echo "dump was created $dbname"
                else
                        echo "Error of db dump $dbname"
                fi
        fi
done
