#!/bin/sh
string=? ; exec /proj/scheme/Executables/x-mzscheme -g -r $0 "$@"

(define KEEP
  '( "cquotes.html"
     "squotes.html"
     "umlauts"
     "htdp.html"
     "teaching.ss"
     "all.ss"
     "gc.ss"
     "index.ss"))

;; all files ending in .xml and all directories
