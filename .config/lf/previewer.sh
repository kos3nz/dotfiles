#!/usr/bin/env bash

case "$1" in
  *) bat --force-colorization --style=numbers,changes,header,header-filesize,grid --terminal-width $(($2 - 3)) "$1"
esac
