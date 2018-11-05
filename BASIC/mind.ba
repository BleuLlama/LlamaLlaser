10 REM Minds Eye interactive game thing
11 REM This is a demo of the BASIC interface game
15 REM by Scott Lawrence - yorgle@gmail.com
16 VERS = "0.01 2018-Nov-04"

20 DEBUG = 1 : REM enable debug output
21 TMOUT = 1000 : REM ticks to wait for a response
22 RXOK = 0 : REM received a string
23 RX$ = "" : TX$ = ""
23 SCENE = 
24 RESTORE

30 GOSUB 100 : REM Initialize serial
40 GOTO 1000 : REM Game.

100 REM Serial BIOS thru line 140
101 REM Hopefully, this is all that will need to chage for portinf

110 REM Initialize serial port
111 OPEN "COM:78N1DIN" FOR OUTPUT AS #1
112 OPEN "COM:78N1DIN" FOR INPUT AS #2
113 ON COM GOSUB 120
114 COM ON
119 RETURN

120 REM RX a line serial data to R$
121 LINE INPUT #2, RX$ : REM TANDY -read until <CR>
122 RXOK=1
123 IF DEBUG THEN PRINT "RX: "; RX$ 
129 RETURN

130 REM TX a line and wait for response
131 IF DEBUG THEN PRINT "TX: "; TX$
132 RXOK=0
133 PRINT #1, TX$
134 I = 0
135 IF RXOK GOTO 139
136 I = I + 1 
137 IF I < TMOUT GOTO 135
139 RETURN

150 REM Laserdisc Commands  PLay, STill, SEek, FRame mode, 

151 TX$="PL":GOTO 130 : REM Play
152 TX$="PA":GOTO 130 : REM Pause
153 TX$="ST":GOTO 130 : REM Stop
154 TX$="SE":GOTO 130 : REM Seek
155 TX$="FR":GOTO 130 : REM Frame mode
156 TX$="RJ":GOTO 130 : REM Reject, Park
157 TX$="OP":GOTO 130 : REM Open tray
158 TX$="CO":GOTO 130 : REM Close tray
159 TX$="SA":GOTO 130 : REM Start spinup

160 TX$="0RA":GOTO 130 : REM turn off OSD overlay
161 TX$="1RA":GOTO 130 : REM turn on OSD - FRAME
162 TX$="4RA":GOTO 130 : REM turn on OSD - User text
163 TX$="5RA":GOTO 130 : REM turn on OSD - User text + frame number
164 TX$="CS":GOTO 130 : REM Clear OSD Screen

170 TX$="0KL":GOTO 130 : REM unlock keys
171 TX$="1KL":GOTO 130 : REM lock keys
172 TX$="?N":GOTO 130 : REM wait for key press
173 TX$="#I":GOTO 130 : REM get current key code
174 TX$="CL":GOTO 130 : REM clear key lookup

180 TX$="0RC":GOTO 130 : REM Blue squelch screen
181 TX$="16RC":GOTO 130 : REM Black squelch screen
182 TX$="0VD":GOTO 130 : REM disable video from disc
183 TX$="1VD":GOTO 130 : REM enable video from disc
184 TX$="0DS":GOTO 130 : REM disable OSD 
185 TX$="1DS":GOTO 130 : REM disable OSD 

200 REM DATA Format:

200 DATA 200,

900 REM Setup new room 
910 RETURN

1000 ROOM = 200
1010 gosub 900
 
400 rem done.

1000 END
