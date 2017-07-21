#!/bin/bash

if [ ! $# -eq 1 ];then
    echo "enter a nexus alignment filename"
    exit 1
fi

if [ ! -e "$1" ];then
    echo cannot find file $1
    exit 1
fi

DIR=preparedData

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

$GAPCODE -fnexus -c $1 > $DIR/gapsAndDNA.nex || exit
cp $1 $DIR/originalDNA.dat

../bin/addROOT.py $DIR/gapsAndDNA.nex > $DIR/gapsAndDNA.withROOT.nex
../bin/addROOT.py $DIR/originalDNA.dat > $DIR/originalDNA.withROOT.dat
