/* -*- c++ -*- */
/* 
 * Copyright 2019 fociSpectral.
 * 
 * This is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3, or (at your option)
 * any later version.
 * 
 * This software is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this software; see the file COPYING.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street,
 * Boston, MA 02110-1301, USA.
 */

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <gnuradio/io_signature.h>
#include "diff_encoder_impl.h"
#include <stdio.h>      /* printf */
#include <math.h>       /* atan2 */

namespace gr {
  namespace qpsk {

    diff_encoder::sptr
    diff_encoder::make(bool altern)
    {
      return gnuradio::get_initial_sptr
        (new diff_encoder_impl(altern));
    }

    /*
     * The private constructor
     */
    diff_encoder_impl::diff_encoder_impl(bool altern)
      : gr::block("diff_encoder",
	       	gr::io_signature::make(1, 1, sizeof(gr_complex)),
              	gr::io_signature::make(1, 1, sizeof(gr_complex))),
		d_altern(altern),d_last_out({1,1})
	{
	 //set_history(2);
	}

    /*
     * Our virtual destructor.
     */
    diff_encoder_impl::~diff_encoder_impl()
    {
    }

    void
    diff_encoder_impl::forecast (int noutput_items, gr_vector_int &ninput_items_required)
    {
    unsigned ninputs = ninput_items_required.size ();
    for(unsigned i = 0; i < ninputs; i++)
      ninput_items_required[i] = noutput_items;
    }

    int
    diff_encoder_impl::general_work (int noutput_items,
                       gr_vector_int &ninput_items,
                       gr_vector_const_void_star &input_items,
                       gr_vector_void_star &output_items)
    {
	const gr_complex *in = (const gr_complex *) input_items[0];
	const gr_complex expminj34 = gr_complex(-0.707106781186547, -0.7071067811865480);
        gr_complex *out = (gr_complex *) output_items[0];
        gr_complex origin = gr_complex(0,0);
	gr_complex last_out = d_last_out;
	
      	// Do <+signal processing+>
	 //out[0] = d_last_out;//{in[0].real(), in[0].imag()};
	// in += 1; // ensure that i - 1 is valid.
        for(int i = 0; i < noutput_items; i++)
        {
		// ML decoder, determine the minimum distance from all constellation points
/*
for i=2:length(tSyms)
    tdSyms(i) = tdSyms(i-1)*exp(-j*angle(tSyms(i)))*exp(-j*pi*3/4);
end
 */
		double rP = in[i].real();
		double iP = in[i].imag();
		float angle = (float)atan2(iP, rP);
		gr_complex mulAngle = gr_complex(0, -1*angle);
		out[i] = last_out*exp(mulAngle)*expminj34;
		last_out = out[i];
        }
	d_last_out = last_out;
      // Tell runtime system how many input items we consumed on
      // each input stream.
      consume_each (noutput_items);

      // Tell runtime system how many output items we produced.
      return noutput_items;
    }

  } /* namespace qpsk */
} /* namespace gr */

