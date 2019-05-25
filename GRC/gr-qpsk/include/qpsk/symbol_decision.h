/* -*- c++ -*- */
/* 
 * Copyright 2019 <+YOU OR YOUR COMPANY+>.
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


#ifndef INCLUDED_QPSK_SYMBOL_DECISION_H
#define INCLUDED_QPSK_SYMBOL_DECISION_H

#include <qpsk/api.h>
#include <gnuradio/block.h>

namespace gr {
  namespace qpsk {

    /*!
     * \brief <+description of block+>
     * \ingroup qpsk
     *
     */
    class QPSK_API symbol_decision : virtual public gr::block
    {
     public:
      typedef boost::shared_ptr<symbol_decision> sptr;

      /*!
       * \brief Return a shared_ptr to a new instance of qpsk::symbol_decision.
       *
       * To avoid accidental use of raw pointers, qpsk::symbol_decision's
       * constructor is in a private implementation
       * class. qpsk::symbol_decision::make is the public interface for
       * creating new instances.
       */
      static sptr make();
    };

  } // namespace qpsk
} // namespace gr

#endif /* INCLUDED_QPSK_SYMBOL_DECISION_H */

