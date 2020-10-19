# Overview

This directory contains a library of various bits of code to
command the Pioneer L3 machine in different languages on
different platforms.

# AmigaBASIC

Sample code for using COM1 (serial port) to talk with the LDP

# Tandy200

The code I wrote for the Maker Faire that lets you move around
with the "Mind's Eye" CGI Laserdisc (side 1).

# Python

Some programs to do stuff with the LDP from my modern MacBook.


# Other Authoring Platforms

This section just contains procedures for setting up and working 
with Pioneer Level 3 serial commanding with various other authoring
systems that may already have library support packaged with them.

## AmigaVision 2.04

Install AmigaVision onto your hard drive.

Insert the Player floppy, and install that to your hard drive as well.

Also on the Player floppy is a DEVS directory.

Copy the contents of DEVS to your DEVS: directory
 - DF0:devs/player.device  file
 - DF0:devs/players/       directory

For my Pioneer CLD-V2400 LaserDisc player with Level 3 controls,
I set it up as such:

Start up AmigaVision
- Configuration Menu, Video Setup
- Select "Pioneer 2200", at 48000 baud.
- Serial Device should be: serial.device Unit 1
- Click [OK]

- Tools Menu, Videodisc...   To bring up the control panel.
- This can be used to control the player if all is working ok


I've never actually used AmigaVision, so I don't know how to use
it from there. Have fun!
