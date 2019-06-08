# QPSK

Simulations will be performed starting from simple modulations to more complex transceivers involving carrier and symbol phase offsets and channel fading.

Each simulation will include a block diagram, a matlab file and a gnu radio flow chart.

The immediate milestone will be to transmit and receive the text message using the actual radios.

# Simulation 1
![GitHub Logo](/Diagrams/Simulation1.jpg)

# Receiver and Transmitter 1
Using portions from Simulation1 we create Transmitter1. We use Receiver1 to capture the signal at various receiver gains. This section reveals the optimal receiver gains along with affects of transmitting unbalanced bits in non-optimal settings.
Transmitting alternating bits and receiving with RX Gains 0dB - 60dB
![GitHub Logo](/Diagrams/AlternatingBitsGain.jpg)
Transmitting message bits and receiving with RX Gains 0dB - 60dB
![GitHub Logo](/Diagrams/messageRxGain.jpg)

# Simulation 2
Bit randomization, derandomization and symbol timing recovery are added to the Simulation 2. The symbol timing recovery is done together with the match filter using an 8-bank polyphase filter to which one filter bank is selected to retrieve the optimal symbol. Carrier Frequency offsets of +/- 0.01 MHz can also be simulated here as differential encoding and polyphase timing recovery are robust against carrier frequency offsets.

![GitHub Logo](/Diagrams/Simulation2.jpg)

# Receiver and Transmitter 2
Using the components built in simulation 2 we build transmitter 2 and receiver 2. We test the receiver with minimal carreir frequency offset and with carrier offset equal to +/-0.01% to ensure we are meeting receiver specs.

As you see on the images and video link, the bottom plots are symbols before they are differentially encoded, the top symbols are after they are differentially encoded. As the carrier frequency offset increases the symbols begin to vigorously circulate. However the phase difference between succesive symbols remains about 0,90,180 or 270. The top plot illustrates the differentially decoded receivers ability to circumvent the rotating symbols resulting from the carrier offset. 

Receiving with small carrier frequency offset:

[![IMAGE ALT TEXT HERE](http://img.youtube.com/vi/Y3vxdlXoFrQ/0.jpg)](https://www.youtube.com/watch?v=Y3vxdlXoFrQ)

Receiving with large carrier frequency offset:

[![IMAGE ALT TEXT HERE](http://img.youtube.com/vi/ZyHpjHddlck/0.jpg)](https://www.youtube.com/watch?v=ZyHpjHddlck&feature=youtu.be)

# Passthrough
The passthrough system is essentially a repeater which passes the raw signal through the LimeSDR with the goal of minimizing any affects on the signal. The system includes a digial gain to ensure the signal's power isn't dissipated as it passes through the system.

![GitHub Logo](/Diagrams/passthrough.jpg)

In setting the default gain we look at signal arriving at the passthrough system.

![GitHub Logo](/Diagrams/passthrough_in.jpg)

We then compare this to the local receiver's received signal in the absence of a digital gain, or digital gain equaling 1. The image below shows the signal is greatly dissipated. The signal power has dropped to near the noise level. We can see the signal-to-noise ratio has significantly dropped. 

![GitHub Logo](/Diagrams/passthrough_nogain.jpg)

We vary the gain until we match the inputs signal power. Below we see the digital gain has brought back the signal's integrity which will allow the local receiver to recover the signal.

![GitHub Logo](/Diagrams/passthrough_x8gain.jpg)
