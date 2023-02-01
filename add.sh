#!/bin/bash

rm -r $1/OCR-D-*
rm $1/mets.xml

ocrd workspace init $1
ocrd workspace -d $1 set-id "ocrd:t001"

NUM=$(find $1 -name "*.tif" | wc -l)
for n in $(eval echo "{01..$NUM}");
do
	echo "${n} of ${NUM}"
	ocrd workspace -d $1 add -G OCR-D-IMG -i OCR-D-IMG_00${n} -m image/tiff -g dat-${1}-${n} ${1}/${1}_000${n}.tif
done;


ocrd process -m $1/mets.xml\
  'cis-ocropy-binarize -I OCR-D-IMG -O OCR-D-SEG-PAGE' \
  'tesserocr-segment-region -I OCR-D-SEG-PAGE -O OCR-D-SEG-BLOCK' \
  'tesserocr-segment-line -I OCR-D-SEG-BLOCK -O OCR-D-SEG-LINE' \
  'tesserocr-recognize -I OCR-D-SEG-LINE -O OCR-D-OCR-TESSEROCR -p param-tess-fraktur.json' 
