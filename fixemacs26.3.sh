#!/bin/sh

pushd .
cd /Applications/Emacs.app/Contents/MacOS
mv Emacs Emacs-launcher
mv Emacs-x86_64-10_14 Emacs
cd ..
rm -rf _CodeSignature
popd
popd
