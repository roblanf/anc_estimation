#!/bin/bash

xml_files=`ls | awk '/xml$/'`


for i in $xml_files; do
    /Users/sebastianducheneAIr/Desktop/temp_beast2/beast2/BEAST2/bin/beast -beagle $i
done
