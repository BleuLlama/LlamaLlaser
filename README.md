# LlamaLlaser

This repo is to contain various LaserDisc commanding programs and
experiments.

The inception of this project goes back to Kevin Savetz reviving
David Lubar's "Rollercoaster" game; "Adventures In Videoland", which was an
Applesoft BASIC program, running on an Apple II, connected to a
Laserdisc player via its serial port, containing the Discovision
release of the movie "Rollercoaster".  It was a text adventure game,
with laserdisc-provided visuals.  (links to come soon.)


# Repo Contents

## Resources
The **Resources** directory contains my command cheatsheet, and the
manual from which all of the content was extracted from.


## Library

This directory contains the various libraries and example code that 
communicate from various systems to the LaserDisc player.

## Library/Tandy200

The **TANDY200** directory contains BASIC language programs that I have
written to do similar processes.  My version is based on the Tandy
200 portable computer.  It has a different syntax to Applesoft
BASIC, but I hope to have ports to it available eventually.

Mine is based on using a Pioneer CLD-V2400 player, with the NTSC
Image Entertainment disc "The Mind's Eye", which is available used
at fairly cheap prices, and contains lots of great 90s CG animations.

## Library/Python

The **Python**  directory contains the various python programs for capturing
from the LDP, as well as for commanding it in various ways.  It 
also contains a library that bundles the serial interface into a 
more pythony interface.

## Hardware

This directory contains related hardware projects, with kicad schematics,
board layouts and also the schematics in PDF format.

Note: you may also be interested in my [LlamaVideoSwitcher](https://github.com/BleuLlama/LlamaVideoSwitcher)  project.


# Future

I will probably bring my LaserDisc simulator into this repo eventually,
and extend it to support the Level III commands that I am using in
my program. 


--- 

# Resources

Links to stuff I've found useful or gotten inspiration from for this project

- [Cheatsheet for Level III commands](Reference/Pioneer_L3_cheatsheet.md)
- [CLDV-2400/CLD-2600 Manual](Reference/cld2400.pdf)

Other links

- [The Mind's Eye - on LDDB](https://www.lddb.com/laserdisc/03999/ID8530MM/Mind's-Eye-The)

