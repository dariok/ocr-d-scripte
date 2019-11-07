#!/bin/bash

ocrd workspace init .
ocrd workspace set-id "ocrd:t001"

NUM=$(find . -name "*.tif" | wc -l)
for n in $(eval echo "{01..$NUM}");
do
	echo "${n} of ${NUM}"
	ocrd workspace add -G OCR-D-IMG -i OCR-D-IMG_00${n} -m image/tiff -g dat-19140103-${n} 19140103_000${n}.tif
done;

ocrd process \
  'cis-ocropy-binarize -I OCR-D-IMG -O OCR-D-SEG-PAGE' \
  'tesserocr-segment-region -I OCR-D-SEG-PAGE -O OCR-D-SEG-BLOCK' \
  'tesserocr-segment-line -I OCR-D-SEG-BLOCK -O OCR-D-SEG-LINE' \
  'tesserocr-recognize -I OCR-D-SEG-LINE -O OCR-D-OCR-TESSEROCR -p param-tess-fraktur.json' 
