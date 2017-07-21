#!/bin/bash

if [ ! $# -eq 1 ];then
    echo "enter a fasta alignment filename"
    exit 1
fi

if [ ! -e "$1" ];then
    echo cannot find file $1
    exit 1
fi

DIR=preparedData/

if [ ! -d "$DIR" ];then
    if [ ! -e "$DIR" ];then
        mkdir $DIR
    else
        echo File named $DIR alprepared exists? Remove it.
        exit 1
    fi
fi

GAPCODE=../bin/gapcode-OSX
path_to_executable=$(which gapcode)
if [ -x "$path_to_executable" ] ; then
    GAPCODE="$path_to_executable"
fi

$GAPCODE -fdnafasta -c $1 > $DIR/gapsAndDNA.nex || exit
cp $1 $DIR/originalDNA.dat

<< COMMENT
x=`grep -n "BEGIN CHARAC" $DIR/gapsAndDNA.nex | tail -1 | sed s/:.*$//g`
head -n $(( x - 1 )) $DIR/gapsAndDNA.nex > $DIR/onlyDNA.nex
head -6 $DIR/gapsAndDNA.nex > $DIR/onlyGaps.nex
tail +$x $DIR/gapsAndDNA.nex >> $DIR/onlyGaps.nex
COMMENT

../bin/addROOT.py $DIR/gapsAndDNA.nex > $DIR/gapsAndDNA.withROOT.nex
../bin/addROOT.py $DIR/originalDNA.dat > $DIR/originalDNA.withROOT.dat
