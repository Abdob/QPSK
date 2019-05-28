/* -*- c++ -*- */

#define QPSK_API

%include "gnuradio.i"			// the common stuff

//load generated python docstrings
%include "qpsk_swig_doc.i"

%{
#include "qpsk/diff_encoder.h"
#include "qpsk/symbol_decision.h"
#include "qpsk/de_randomizer.h"
%}


%include "qpsk/diff_encoder.h"
GR_SWIG_BLOCK_MAGIC2(qpsk, diff_encoder);
%include "qpsk/symbol_decision.h"
GR_SWIG_BLOCK_MAGIC2(qpsk, symbol_decision);
%include "qpsk/de_randomizer.h"
GR_SWIG_BLOCK_MAGIC2(qpsk, de_randomizer);
