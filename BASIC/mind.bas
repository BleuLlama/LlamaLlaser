10 REM Minds Eye interactive game thing
11 REM This is a demo of the BASIC interface game
15 REM by Scott Lawrence - yorgle@gmail.co
19 VER$ = "0.01 2018-Nov-05"

20 DEBUG = 1 : REM enable debug output
21 TM = 1000 : REM ticks to wait for a response
22 RK = 0 : REM received a string (rxok)
23 RX$ = "" : TX$ = ""
24 SC = 1 : REM starting scene#

50 GOSUB 100 : REM Initialize serial
60 GOTO 200 : REM Game engine start

100 REM Serial BIOS thru line 140
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
132 RK=0
133 PRINT #1, TX$
134 I = 0
135 IF RK GOTO 139
136 I = I + 1 
137 IF I < TM GOTO 135
139 RETURN



200 REM New Game
1010 PRINT "Starting... "; SC
1020 GOSUB 250
1030 PRINT "Shell loop here."
1040 END

250 REM New Game
260 RESTORE SC
270 READ AA
280 IF AA > 0 THEN GOTO 300 : REM >0 then the number is an AutoAction
290 PRINT "uh... i dunno"
299 RETURN

300 REM Do Action
310 RESTORE AA
320 READ AI$
330 IF AI$ = "~END" THEN RETURN
340 IF AI$ = "~LD" THEN GOTO 400
350 IF AI$ = "~SCE" THEN GOTO 500
360 IF AI$ = "~ACT" THEN GOTO 600
370 PRINT "ERR: U/K Act: "; AI$
380 RETURN

400 REM LD Playback Sequence
410 READ AI$
420 IF LEFT$( AI$, 1 ) = "~" THEN GOTO 330
430 PRINT "PLAY SEQ "; AI$;
440 TX$ = AI$ : GOSUB 130 : REM Send sequence, wait for response
450 GOTO 410

500 REM GO to new scene Wrapper
510 READ AI$
520 SCENE = VAL( AI$ )
530 GOTO 250

600 REM Do Action Wrapper
610 READ AI$
620 AA = VAL( AI$ )
630 GOTO 310 : REM Do Action



1100 DATA 205, "A grassy field","A wide clearing stretching","in every direction"
1101 DATA 202,203,-1
1102 DATA "N","Go North","A wide path to the north","G",210
1103 DATA "S","Go South","A house is to the south","G",220
1105 DATA "~LD", "FR2000SE", "FR2020PL", "~END" : REM -2 starts autorun LD command sequence (play once)
1106 DATA "~LD", "FR1234SE", "~SCE", 220 : REM -6 indicates "chain to this scene
1107 DATA "~LD", "FR1234SE", "~ACT", 205 : REM -9 indicates "chain to this action
1110 DATA -1, "Dirt path", "A dusty path",-1,211
1111 DATA "S","Go South","Go to the grassy field","G",200
1120 DATA -1 "Country House porch", "A quaint cottage in", "the countryside",-1,,221,222,-1
1121 DATA "N","Go North", "Go to the grassy field","G",200
1122 DATA "G","Get Screwdriver","An ordinary screwdriver","P",300
1199 REM ITEMS
1200 DATA "A Screwdriver","An ordinary screwdriver",100
