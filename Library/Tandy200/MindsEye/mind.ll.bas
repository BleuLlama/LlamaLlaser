
@LINE 10
	REM Minds Eye interactive game thing
	REM This is a demo of the BASIC interface game
	REM by Scott Lawrence - yorgle@gmail.co
	VER$ = "0.01 2018-Nov-05"

@LINE 20
@ALLOCATE DEBUG = 1 // enable debug output
@ALLOCATE TM = 1000 // timeout ticks for serial response
@ALLOCTE TM // why the hell am i doing this
	DEBUG = 1 : REM enable debug output
	TM = 1000 : REM ticks to wait for a response
	RK = 0 : REM received a string (rxok)
	RX$ = "" : TX$ = ""
	SC = 1 : REM starting scene#

@LINE 50
	GOSUB SerialInitialize : REM Initialize serial
	GOTO GameInit : REM Game engine start

@----------------------------------------------------------
@LINE 100
SerialHeader:
	REM Serial BIOS thru line 140
	REM Hopefully, this is all that will need to chage for porting

@LINE 110
SerialInitialize:
	REM Initialize serial port
	@{COMPUTER=TANDY
		OPEN "COM:78N1DIN" FOR OUTPUT AS #1
		OPEN "COM:78N1DIN" FOR INPUT AS #2
		ON COM GOSUB S
		COM ON
	@}COMPUTER
	RETURN

@LINE 120
SerialReadLine:
	REM RX a line serial data to R$
	LINE INPUT #2, RX$ : REM TANDY -read until <CR>
	RK=1
	IF DEBUG THEN PRINT "RX: "; RX$ 
	RETURN

@LINE 130
SerialSendAndWait:
	REM TX a line and wait for response
	IF DEBUG THEN PRINT "TX: "; TX$
	RK=0
	PRINT #1, TX$
	I = 0
_SSAW_WAIT:
	IF RK GOTO _SSAWRET
	I = I + 1 
	IF I < TM GOTO _SSAW_WAIT
_SSAW_RET:
	RETURN


@LINE 200
GameInit:
	REM New Game
	PRINT "Starting... "; SC
	GOSUB GameStart
	PRINT "Shell loop here."
	END

GameStart:
	REM New Game
	RESTORE
	READ AA
	IF AA > 0 THEN GOTO Game_DoAction : REM >0 then the number is an AutoAction
	PRINT "uh... i dunno"
	RETURN

@LINE 300
Game_DoAction:
	REM Do Action
	RESTORE AA
_GA_DAX:
	READ AI$
_GA_TILDE:
	IF AI$ = "~END" THEN RETURN
	IF AI$ = "~LD" THEN GOTO Game_Action_LDSequence
	IF AI$ = "~SCE" THEN GOTO Game_Action_NewScene
	IF AI$ = "~ACT" THEN GOTO Game_Action_DoAction
	PRINT "ERR: U/K Act: "; AI$
	RETURN

@LINE 400
	REM LD Playback Sequence
Game_Action_LDSequence:
	READ AI$
	IF LEFT$( AI$, 1 ) = "~" THEN GOTO _GA_TILDE
	PRINT "PLAY SEQ "; AI$;
	TX$ = AI$ : GOSUB 130 : REM Send sequence, wait for response
	GOTO Game_Action_LDSequence

Game_Action_NewScene:
	REM GO to new scene Wrapper
	READ AI$
	SCENE = VAL( AI$ )
	GOTO _GA_DAX

@LINE 600
	REM Do Action Wrapper
Game_Action_DoAction:
	READ AI$
	AA = VAL( AI$ )
	GOTO _GA_DAX : REM Do Action


@LINE 1000:
GameData:

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
