# DRUM_Approximate_Multiplier

Dynamic Range Unbiased Multiplier (DRUM) is an approximate multiplier with a minimal and clean design.

This is based on the approximate multiplier described in the paper [here](Resources/DRUM.pdf).

## Main Multiplier

The Main Multiplier truncates an *N bit* operand to a *K bit* operand. The approximate multiplier works well because of the fact that the least significant bit takes on the expected value of the bit's preceding it. This makes the operand unbiased and gives a very small error on average.

In this design, i've used *8 bit* operands for the approximate multiplier and *4 bit* operands for the core multiplier.

## Core Multiplier

The Core Multiplier utilizes a 4x4 high speed Wallace Tree Multiplier which is a better alternative compared to a normal Array Multiplier.

## Leading One Detector

This module takes in a *N bit* bit input and throws out a *N bit* output which marks the position of the leading *1* in the bit field. This is then taken in by an encoder which spits out the *log_2(N) bit* encoded value of the position.

## Simulation

The VCD file for the main multiplier can be found [here](Waveforms/main_multiplier.vcd). The waveforms can be visualized using gtkwave.

## To Do

One of the main advantages of the DRUM approximate multiplier is it's scalability. To achieve this, it is a good idea to parameterize all the modules (Which is left for later). For now, The Main Multiplier and The Leading One Detector is properly parameterized.


