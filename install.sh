#!/bin/bash

add-apt-repository ppa:alex-p/tesseract-ocr
apt-get update

apt-get install libtesseract-dev libleptonica-dev tesseract-ocr-eng tesseract-ocr tesseract-ocr-script-frak
pip3 install ocrd ocrd_tesserocr ocrd_cis

echo '{ "model": "script/Fraktur" }' > param-tess-fraktur.json
