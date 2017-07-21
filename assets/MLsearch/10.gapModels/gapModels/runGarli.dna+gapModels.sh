#!/bin/bash

DIR=preparedData
if [ ! -d preparedData ] | [ ! -e preparedData/gapsAndDNA.nex ];then
    echo "no gap-coded data found"
    echo "execute prepareNexusData.sh or prepareFastaData.sh before executing this script"
    exit 1
else
    echo data is prepared ...
fi

DIR=garliOutput
if [ ! -d "$DIR" ];then
    if [ ! -e "$DIR" ];then
        mkdir $DIR
    else
        echo File named $DIR alprepared exists? Remove it.
        exit 1
    fi
fi

#if "garli" is in the path, use that, otherwise assume OSX
path_to_executable=$(which garli)
if [ -x "$path_to_executable" ] ; then
    EXEC="$path_to_executable"
else
    EXEC=../../executables/Garli-2.01-OSX
fi

DNA=1
DIMM=1
MK=1
if [ "$#" -eq 1 ];then
    if [ "$1" = "dimm" ];then
        DNA=0
        MK=0
    elif [ "$1" = "mk" ];then
        DNA=0
        DIMM=0
    elif [ "$1" = "dna" ];then
        DIMM=0
        MK=0
    fi
fi

$EXEC configs/garli.dna.2fastStep.coll.conf

if [ "$DNA" -eq "1" ];then
    $EXEC configs/garli.dna.fromDna2fastStep.coll.conf
fi

if [ "$DIMM" -eq "1" ];then
    echo DIMM
    $EXEC configs/garli.dnaMix.fromDna2fastStep.coll.conf
fi

if [ "$MK" -eq "1" ];then
    echo MK
    $EXEC configs/garli.dnaBinaryNoZeros.fromDna2fastStep.coll.conf
fi


