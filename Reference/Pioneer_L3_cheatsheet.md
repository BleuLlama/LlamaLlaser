
Pioneer Level III Cheatsheet
	2018-Nov-05
	Scott Lawrence
	yorgle@gmail.com

---

# Overview

This document is mainly for general notes about the
various Pioneer Level III commands that my player (CLD-V2400)
supports.  There's not a real structure to this document.

There's another level of player that's higher than this
that also supports a command that lets you skip around up
to +- 100 frames without visual glitching, but my player
does not support that, so i'm not going to bother including
that information here.  (That feature is used by arcade
LaserDisc games -- Dragon's Lair, etc -- to have seamless
skipping between scenes.)

NOTE: Most of the info here is CAV-centric (standard play).
Some of these (SF/SR/MF/MR) do not work with CLV
(extended play) discs!

---

# General communications

	Connection is 4800 baud 8N1, RS-232.

	Commands are sent as ASCII text, with a carriage return
	to signify the end of the command -
```
		<CR> = 0x0D = [ctrl]-[m]
```

	Responses are sent back similarly.  Some commands return 
```
		"R"<CR>  ("R\r") 	as an OK value
		"Exx"<CR>			as an error, where xx is a number
```

	although some, where you're querying some aspect of the player, respond:
```
		(integer)<CR>		as a response for frame number query "?F"
		"Pxx"<CR>			as a response for player mode
				etc.
```
---

# Player modes
```
	[P00 - DOOR OPEN] -> [DOOR CLOSING] -> [P01 - PARK]
	- triggerd by 'CO' command

	[P01 - PARK] -> [DOOR OPENING] -> [P00 - DOOR OPEN]
	- triggerd by 'OP' command


	[P01 - PARK] -> [P02 - SPIN UP] ->[RANDOM ACCESS]
	- triggerd by 'SA' command

	[RANDOM ACCESS] -> [P03 - SPIN DOWN] -> [P01 - PARK]
	- triggerd by 'RJ' command
```

```
	send	state change		response	does this.

	OP		PARK -> DOOROPEN 	R		open tray
	CO		DOOROPEN -> PARK	R		close tray
	RJ		RAM -> PARK			R		stop/reject
	SA		PARK -> PAUSE 		R		start/pause
			PARK -> PARK 		E11		no disc to play!
```
	Note: Current state can be found via "?P" query command.
	      It returns "Pxx" as listed above. See command info
	      below.

---

# Random access play modes
```
	P04	[PLAY]
	P05 [STILL]
	P06 [PAUSE]
	P07 [SEARCH]
	P08 [SCAN]
	P09 [MULTI SPEED]
	P?? [SKIP CHAPTER]
```

	Note: Current state can be found via "?P" query command.
	      It returns "Pxx" as listed above. See command info
	      below.
---

#Real use:

```
- Tray open		P00
- Tray closing	P01
- Tray opening	P03
- Press play with tray open - P01, then once it starts spinning, P02, then P04 when playing
- press stop 	P01 immediately
- tray empty, in machine, press play,  E11


```

---

# Some useful commands....
```

PL		PARK / SPINUP / PAUSE	-> PLAY (or other r.a. mode -> PLAY)
FR32400PL		play from frame 32400
TM2028PL		play from time 20m 28sec

PA		Toggle pause/play mode
		- pause is NOT stillframe.  It squelches video and audio.
ST		Stilframe
		- squelches audio

SF		Step forward one frame
SR		Step backwards one frame

NF		Scan forwards ~500f - sloppy, imprecise
NR		Scan backwards ~500f - sloppy, imprecise
		- squelch video and audio

MF		Multispeed forward
MR		Multispeed reverse
		FR34500MF		Multispeed forward until 34500 and stillframe
		FR34500MF34500SM*?F		??
		- player can play at various playback speeds. 
		- audio is squelched

180SP	Multispeed set at 3x speed
120SP	2x speed
60SP	1x speed (normal)
30SP	1/2 speed
15SP	1/4 speed
7SP		1/8 speed
4SP		1/16 speed
2SP		1 frame per second

FR4500SE	R	Search to frame 4500 and still (pause on CLV)
CH5SE		R	Search to chapter 5 and still
TM5634SE	R	?CSeach to 0h 56m 34s and still
		- audio and video are squelched

FR23427SMPL		SM - set stop marker play, stop at 23427
		- NOTE: Player sends 'R' IMMEDIATELY, NOT when the location is reached.
		- poll with '?F' query to see when it is reached!

CL		R		Clear input buffer, stop markers, paused/stilled video
LO		use for number for seeking to Lead-Out
		LOSE		R		seek to lead-out
		?F			49399	get frame number at lead-out
```

---

# Status/Query commands
```
sent	resp.

?F		2231	get current frame number

?C		3		get current chapter number

?T		03213	get current time (0h 32m 13s)
			CAV returns E04

?P				get current player mode
		P00		DOOR OPEN		- tray is out
		P01		PARK			- tray is in, machine idle
		P02		SET UP 			- disc is spinning up
		P03		DISC UNLOADING	- tray is opening
		P04		PLAY
		P05		STILL
		P06		PAUSE
		P07		SEARCH
		P08		SCAN
		P09		MULTISPEED

?D		C1 C2 C3 C4 C5		disc status (0,1,X if unknown)
		C1: 0:not loaded, 1:loaded
		C2: 0:CAV, 1:CLV
		C3: 0:12" 1:8"
		C4: 0:side 1, 1:side 2
		C5: 0:no chapters, 1:has chapters

		Mind's Eye CAV disc:	10001

?X		P1518XX  - V2400

		Mine returns:			P151801
```

---

# Audio and video control

## Audio:
```
	0AD		analog audio off
	3AD		analog audio on
	4AD		digital audio off
	7AD		digital audio on
```

## Video:

	switching path:
```
		(disc video) -> (squelch) -> (VD) ---> output
		(OSD Generator) -> (squelch) -> (DS) ---^
```

```
0VD		turn off video from disc (pre-squelch)
1VD		turn on video from disc

0KL		enable front panel and remote
1KL		disable front panel and remote 

0DS		turn off OSD (On-screen display)/character generation
1DS		turn on OSD generation

CS				clear User OSD
4PR		R		Print the next line to line 4 of OSD
hello	R


xRA		R		set display options (register A)
		0x00	all off
		0x01	Frame or time number 
		0x02	chapter/track number
		0x04	User OSD text (if not set, data is cleared

Text is 0..9 for line, 0..19 chars per line

Special lines of the onscreen display (OSD)
	0 display of chapter, frame, time, track
	1 remote input press info
```

## Squelch (RB):
```
xRB		R		Squelch set
0RB		R		Normal (video, audio squelch enabled)
64RB	R		Audio squelch disabled (plays audio during pause, seek, etc)
128RB	R		Video squelch disabled (shows video during pause, seek, etc)
192RB	R		Audio & Video squelch disabled
```

## Misc, Squelch control (RC)
```
xRC		R		set register c.
		add values:
		1		side repeat
		2		load start
		4		power on
		8		(not used)
		16		background: 	0 = blue	1 = black
		32		Serial TX EOL	0 = CR		1 = CR+LF
		64		Baud Rate		0 = 4800	1 = 1200
		128		Test mode
			defaults seem to be all 0s
```

## Register Query (get current state)
```
$A		0xxx0xxx	current value of A register
$B		xx000000	current value of B register
$C		xxxxxxxx	current value of C register
```

---

# User input
```
#I		FF		Get most recent pressed button code
				FF = no key, 07 for [7]
		- works for all buttons


?N		(wait until user hits button)
		7		(user pressed '7')
		- only works for numbers!

CL				clear/break the ?N "waiting" to regain control
		- does not clear "last pressed" for #I

```

Remote Key Codes: (CU-LD007)
	FF		No press since last query
	00		0
	..		(numbers map to the expected values)
	09		9

	0C		Auto Digital/Analog			"D/A CX" on CU-CLD067
	0E		CX
	0F		TV/LVP

	10		Scan >>
	11		Scan <<
	13		Chapter / Frame Time
	16		Eject []/^
	17		Play
	18		Pause
	1E		Analog Audio Monitor		"Audio" on CU-CLD067

	40		Program
	42		Search / Memory
	43		Display
	44		Repeat - B, Chapter / One Side
	45		Clear
	46		Multi Speed -
	47		Multi Speed +
	48		Repeat - A

	50		Still / Step <||
	52		Chapter Skip >>|
	53		Chapter Skip |<<
	54		Still / Step ||>
	55		Multi Speed <
	58		Multi Speed >

Additional buttons on CU-CLD067
	1C		Power
	37		D-Level Ctrl
	5A		Hilite/Intro

If bar code reader is plugged in (UC-V109BC tested) then IR 
remote receiver on unit is nonfunctional.  Buttons on BCR send
the same codes as the above. (17, 18, 10, 11, 50, 52, 53, 54)


---

# More Useful commands:
```
0RA		all OSD text off
1RA		just frame number
4RA		Just user text
5RA		User text + frame number
xPR		print next line to osd line x

CS 		clear screen

1KL		lock keys
		- front panel and remote do not control playback
		- the following two commands do still work
?N		wait for key press
#I		immediate get current key pressed
CL		clear input/regain

0RC		blue squelch
16RC	black squelch
0VD		disable video from disc (pre-squelch, pre OSD)
1VD		enable video from disc (pre-squelch, pre OSD)
0DS		disable OSD
1DS		enable OSD

0RB 	normal squelch
192RB	disable all sqelches

0AD		audio off
3AD		analog audio track
7AD		digital audio on

4SP		1/4 speed
MR		multi-reverse
xxSM	set stop marker

?F		get frame number
```

```
FR3500SE
3000SM
180SPMR

255RB			disable squelches
3AD				analog audio
FR1111SE		seek to frame 1111		
FR575SM			set stop point at frame 575
180SPMR			play at 3x speed, backwards
```
