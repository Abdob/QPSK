# QPSK

Simulations will be performed starting from simple modulations to more complex transceivers involving carrier and symbol phase offsets and channel fading.

Each simulation will include a block diagram, a matlab file and a gnu radio flow chart.

The immediate milestone will be to transmit and receive the text message using the actual radios.

# Simulation 1
![GitHub Logo](/Diagrams/Simulation1.jpg)

# Simulation 2
Bit randomization, derandomization and symbol timing recovery are added to the Simulation 2. The symbol timing recovery is done together with the match filter using an 8-bank polyphase filter to which one filter bank is selected to retrieve the optimal symbol. Carrier Frequency offsets of +/- 0.01 MHz can also be simulated here as differential encoding and polyphase timing recovery are robust against carrier frequency offsets.

![GitHub Logo](/Diagrams/Simulation2.jpg)

[![IMAGE ALT TEXT HERE](http://img.youtube.com/vi/YOUTUBE_VIDEO_ID_HERE/0.jpg)](http://www.youtube.com/watch?v=YOUTUBE_VIDEO_ID_HERE)

# Receiver Gain Settings
Using portions from Simulation1 we create Transmitter1. We use Receiver1 to capture the signal at various receiver gains. This section reveals the optimal receiver gains along with affects of transmitting unbalanced bits in non-optimal settings.
Transmitting alternating bits and receiving with RX Gains 0dB - 60dB
![GitHub Logo](/Diagrams/AlternatingBitsGain.jpg)
Transmitting message bits and receiving with RX Gains 0dB - 60dB
![GitHub Logo](/Diagrams/messageRxGain.jpg)


