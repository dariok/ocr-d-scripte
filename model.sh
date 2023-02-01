#!/bin/bash

cp $1.traineddata /usr/share/tesseract-ocr/4.00/tessdata/
echo { \"model\": \"${1}\" } > param-tess-fraktur.json
