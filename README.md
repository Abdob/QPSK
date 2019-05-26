# QPSK

Simulations will be performed starting from simple modulations to more complex transceivers involving carrier and symbol phase offsets and channel fading.

Each simulation will include a block diagram, a matlab file and a gnu radio flow chart.

The immediate milestone will be to transmit and receive the text message using the actual radios.

# Simulation 1
![GitHub Logo](/Diagrams/Simulation1.jpg)

# Receiver Gain Settings
Using portions from Simulation1 we create Transmitter1. We use Receiver1 to capture the signal at various receiver gains. This section reveals the optimal receiver gains along with affects of transmitting unbalanced bits in non-optimal settings.
Transmitting alternating bits and receiving with RX Gains 0dB - 60dB
![GitHub Logo](/Diagrams/AlternatingBitsGain.jpg)
Transmitting message bits and receiving with RX Gains 0dB - 60dB
![GitHub Logo](/Diagrams/messageRxGain.jpg)
