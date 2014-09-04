#!/bin/bash

xml_files=`ls | awk '/xml$/'`
beast_run='~/Desktop/progs/Beast2/bin/beast'


for i in $xml_files; do
    ~/Desktop/progs/Beast2/bin/beast -beagle $i
done
