#!/usr/bin/env python2
# -*- coding: utf-8 -*-
##################################################
# GNU Radio Python Flow Graph
# Title: Top Block
# Generated: Fri May 24 20:40:12 2019
##################################################

from distutils.version import StrictVersion

if __name__ == '__main__':
    import ctypes
    import sys
    if sys.platform.startswith('linux'):
        try:
            x11 = ctypes.cdll.LoadLibrary('libX11.so')
            x11.XInitThreads()
        except:
            print "Warning: failed to XInitThreads()"

from PyQt5 import Qt, QtCore
from gnuradio import blocks
from gnuradio import digital
from gnuradio import eng_notation
from gnuradio import gr
from gnuradio.eng_option import eng_option
from gnuradio.filter import firdes
from optparse import OptionParser
import qpsk
import sys
from gnuradio import qtgui


class top_block(gr.top_block, Qt.QWidget):

    def __init__(self):
        gr.top_block.__init__(self, "Top Block")
        Qt.QWidget.__init__(self)
        self.setWindowTitle("Top Block")
        qtgui.util.check_set_qss()
        try:
            self.setWindowIcon(Qt.QIcon.fromTheme('gnuradio-grc'))
        except:
            pass
        self.top_scroll_layout = Qt.QVBoxLayout()
        self.setLayout(self.top_scroll_layout)
        self.top_scroll = Qt.QScrollArea()
        self.top_scroll.setFrameStyle(Qt.QFrame.NoFrame)
        self.top_scroll_layout.addWidget(self.top_scroll)
        self.top_scroll.setWidgetResizable(True)
        self.top_widget = Qt.QWidget()
        self.top_scroll.setWidget(self.top_widget)
        self.top_layout = Qt.QVBoxLayout(self.top_widget)
        self.top_grid_layout = Qt.QGridLayout()
        self.top_layout.addLayout(self.top_grid_layout)

        self.settings = Qt.QSettings("GNU Radio", "top_block")

        if StrictVersion(Qt.qVersion()) < StrictVersion("5.0.0"):
            self.restoreGeometry(self.settings.value("geometry").toByteArray())
        else:
            self.restoreGeometry(self.settings.value("geometry", type=QtCore.QByteArray))

        ##################################################
        # Blocks
        ##################################################
        self.qpsk_symbol_decision_0 = qpsk.symbol_decision()
        self.qpsk_diff_encoder_0 = qpsk.diff_encoder(True)
        self.digital_diff_phasor_cc_0 = digital.diff_phasor_cc()
        self.blocks_unpack_k_bits_bb_0 = blocks.unpack_k_bits_bb(8)
        self.blocks_pack_k_bits_bb_0 = blocks.pack_k_bits_bb(8)
        self.blocks_multiply_const_vxx_2 = blocks.multiply_const_vcc((0.5, ))
        self.blocks_multiply_const_vxx_1 = blocks.multiply_const_vcc((-.5 - .5j, ))
        self.blocks_multiply_const_vxx_0 = blocks.multiply_const_vcc((2, ))
        self.blocks_interleaved_char_to_complex_0 = blocks.interleaved_char_to_complex(False)
        self.blocks_file_source_0 = blocks.file_source(gr.sizeof_char*1, '/home/foci2/Documents/SDR/QPSK/GRC/message.dat', False)
        self.blocks_file_sink_0_0_0_0_1_0 = blocks.file_sink(gr.sizeof_char*1, '/home/foci2/Documents/SDR/QPSK/GRC/received.dat', False)
        self.blocks_file_sink_0_0_0_0_1_0.set_unbuffered(False)
        self.blocks_file_sink_0_0_0_0_1 = blocks.file_sink(gr.sizeof_gr_complex*1, '/home/foci2/Documents/SDR/QPSK/GRC/diff.dat', False)
        self.blocks_file_sink_0_0_0_0_1.set_unbuffered(False)
        self.blocks_conjugate_cc_0 = blocks.conjugate_cc()
        self.blocks_complex_to_interleaved_char_0 = blocks.complex_to_interleaved_char(False)
        self.blocks_add_const_vxx_1 = blocks.add_const_vcc((0.5 + 0.5j, ))
        self.blocks_add_const_vxx_0 = blocks.add_const_vcc((-.5-.5j, ))

        ##################################################
        # Connections
        ##################################################
        self.connect((self.blocks_add_const_vxx_0, 0), (self.blocks_multiply_const_vxx_0, 0))
        self.connect((self.blocks_add_const_vxx_1, 0), (self.blocks_complex_to_interleaved_char_0, 0))
        self.connect((self.blocks_complex_to_interleaved_char_0, 0), (self.blocks_pack_k_bits_bb_0, 0))
        self.connect((self.blocks_conjugate_cc_0, 0), (self.blocks_multiply_const_vxx_1, 0))
        self.connect((self.blocks_file_source_0, 0), (self.blocks_unpack_k_bits_bb_0, 0))
        self.connect((self.blocks_interleaved_char_to_complex_0, 0), (self.blocks_add_const_vxx_0, 0))
        self.connect((self.blocks_multiply_const_vxx_0, 0), (self.qpsk_diff_encoder_0, 0))
        self.connect((self.blocks_multiply_const_vxx_1, 0), (self.qpsk_symbol_decision_0, 0))
        self.connect((self.blocks_multiply_const_vxx_2, 0), (self.blocks_add_const_vxx_1, 0))
        self.connect((self.blocks_pack_k_bits_bb_0, 0), (self.blocks_file_sink_0_0_0_0_1_0, 0))
        self.connect((self.blocks_unpack_k_bits_bb_0, 0), (self.blocks_interleaved_char_to_complex_0, 0))
        self.connect((self.digital_diff_phasor_cc_0, 0), (self.blocks_conjugate_cc_0, 0))
        self.connect((self.qpsk_diff_encoder_0, 0), (self.digital_diff_phasor_cc_0, 0))
        self.connect((self.qpsk_symbol_decision_0, 0), (self.blocks_file_sink_0_0_0_0_1, 0))
        self.connect((self.qpsk_symbol_decision_0, 0), (self.blocks_multiply_const_vxx_2, 0))

    def closeEvent(self, event):
        self.settings = Qt.QSettings("GNU Radio", "top_block")
        self.settings.setValue("geometry", self.saveGeometry())
        event.accept()


def main(top_block_cls=top_block, options=None):

    if StrictVersion("4.5.0") <= StrictVersion(Qt.qVersion()) < StrictVersion("5.0.0"):
        style = gr.prefs().get_string('qtgui', 'style', 'raster')
        Qt.QApplication.setGraphicsSystem(style)
    qapp = Qt.QApplication(sys.argv)

    tb = top_block_cls()
    tb.start()
    tb.show()

    def quitting():
        tb.stop()
        tb.wait()
    qapp.aboutToQuit.connect(quitting)
    qapp.exec_()


if __name__ == '__main__':
    main()
