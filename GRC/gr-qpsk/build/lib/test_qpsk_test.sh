#!/bin/sh
export VOLK_GENERIC=1
export GR_DONT_LOAD_PREFS=1
export srcdir=/home/foci2/Documents/SDR/QPSK/GRC/gr-qpsk/lib
export PATH=/home/foci2/Documents/SDR/QPSK/GRC/gr-qpsk/build/lib:$PATH
export LD_LIBRARY_PATH=/home/foci2/Documents/SDR/QPSK/GRC/gr-qpsk/build/lib:$LD_LIBRARY_PATH
export PYTHONPATH=$PYTHONPATH
test-qpsk 
