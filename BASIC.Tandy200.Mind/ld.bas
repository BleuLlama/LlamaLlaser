10 REM Adventures Into The Mind's Eye
15 REM by Scott Lawrence - yorgle@gmail.com
19 VER$ = "0.05 2018-Nov-15"
20 DEBUG = 1 : REM enable debug output
21 TM = 1000 : REM ticks to wait for a response
22 RK = 0 : REM received a string (rxok)23 RX$ = "" : TX$ = ""
24 SC = 1 : REM starting scene#
25 DISC = 1 : REM disc is present
50 GOSUB 100 : REM Initialize serial
60 GOTO 200 : REM Game engine start
100 REM ---- Serial BIOS thru line 149
101 REM Hopefully, this is all that will need to chage for porting
110 REM Initialize serial port
111 OPEN "COM:78N1DII" FOR OUTPUT AS #1
112 OPEN "COM:78N1DII" FOR INPUT AS #2
113 ON COM GOSUB 120
114 COM ON
119 RETURN
120 REM RX a line serial data to R$
121 LINE INPUT #2, RX$ : REM TANDY -read until <CR>
122 RK=1
123 IF DEBUG THEN PRINT "RX: "; RX$ 
129 RETURN
130 REM TX a line and wait for response
131 IF DEBUG THEN PRINT "TX: "; TX$
132 RK=0 : IF DISC = 0 THEN RETURN
133 PRINT #1,TX$
134 I = 0
135 IF RK GOTO 139
136 I = I + 1 
137 IF I < TM GOTO 135 : REM check for timeout
138 PRINT "Timed out."
139 TM=TM/2 : REM each timeout is shorter.
140 IF TM > 50 THEN RETURN
141 TM = 0 : DISC = 0
142 PRINT "Bad disc COM. Disabling."
143 RETURN
200 REM ---- Main Game loop 
210 GOSUB 1010 : REM setup init list
220 GOSUB 500 : REM dump to LD
230 GOTO 999
499 REM ---- Event Program Runner
500 READ TX$
501 IF TX$="~END" THEN RETURN
505 IF NOT TX$="~WAIT" THEN GOTO 510
506 READ W
507 PRINT "Delay " ; W
508 FOR A=0 TO (W*267) : NEXT A
509 GOTO 500
510 IF NOT TX$ = "~ENTER" THEN GOTO 515
511 PRINT "Press [ENTER] ";:INPUT A$
512 GOTO 500
515 IF NOT TX$="~PRINT" THEN GOTO 520
516 READ TX$ : PRINT TX$
517 GOTO 500
520 IF NOT TX$ = "~FR" THEN 530
521 READ FR$
522 TX$="?F":GOSUB 130
523 IF DISC = 0 THEN GOTO 500 : REM No connection
524 IF RX$=FR$ THEN GOTO 500
525 GOTO 522
530 PRINT "LD Send ";TX$ : GOSUB 130
599 GOTO 500
999 PRINT "DONE!"
1000 GOTO 1000 : REM LOOP 4 EVA
1010 GOTO 1200 : REM TEMP DEBUG the 1200 scene
1098 REM ---- Program/Game data
1100 RESTORE 1101:RETURN : REM Intro Sequence
1101 DATA "CS","16RC", "0RB", "1DS", "5RA"
1105 DATA "5PR","Starting up..."
1110 DATA "pl","FR1570SE", "CS", "FR1600PL"
1115 DATA "1PR", "  Adventures into"
1120 REM          01234567890123456789
1125 DATA "6PR", "A textual thinger by"
1130 DATA "7PR", "   Scott Lawrence"
1135 DATA "8PR", " Interlock Rochester"
1140 DATA "9PR", "Roch MakerFaire 2018"
1145 DATA "~WAIT", 3, "FR1660PL"
1150 DATA "6PR","", "7PR",""
1155 DATA "8PR", "Press enter to start"
1160 DATA "9PR",""
1165 DATA "~ENTER"
1170 DATA "CS"
1175 DATA "FR1700PL"
1180 DATA "~END"
1200 RESTORE 1200:RETURN : REM Castle Zoomer
1205 DATA "FR35667se", "240sp", "fr35283sm","MR"
1210 DATA "~FR", "35283", "~PRINT", "OK"
1215 DATA "~END"
