' Llaser.bas
'
'  Demo AmigaBASIC program to talk with an LD Player
'   yorgle@gmail.com
'
'  v2.0 - 2020-10-18 - Initial version
'
'  Note: does not check response values for errors (Exx rather than R)


'----------------------------------------------'

' The actual run loop.

' open the connection
CALL LDOpen

' print out help usage thingy.
PRINT "'exit'  to quit"
PRINT "'init'  for LD init calls"
PRINT "'steps' for sequential step frame demo"
PRINT "'init'  for sequential seek frame demo"
PRINT "'init'  for LD init calls"
PRINT ""

cmd$ = ""
WHILE cmd$ <> "exit"
  INPUT "LDCmd? ", cmd$

  IF cmd$ = "init" THEN
    CALL LDInitCalls

  ELSEIF cmd$ = "steps" THEN
    CALL LDStepDemo

  ELSEIF cmd$ = "seeks" THEN 
    CALL LDSeekDemo

  ELSEIF cmd$ = "exit" THEN
    PRINT "Closing connection..."

  ELSE
    CALL LDCmd( cmd$ )
    CALL LDGetResponse( resp$ )

  END IF
WEND

' close the connection.
CALL LDClose
END


'----------------------------------------

' LDInitCalls
'  A nice set of demo calls to do on startup
'
SUB LDInitCalls STATIC
  CALL LDCmdResp( "1DS", r$ )    ' turn on OSD
  CALL LDCmdResp( "192RB", r$ )  ' turn off all squelches
  CALL LDCmdSeek( "LO", r$ )     ' seek to end of disc
  CALL LDCmdResp( "?F", r$ )     ' get frame count
  PRINT "Disc has "; r$ ; " frames."
  CALL LDCmdSeek( "0", r$ )      ' go to beginning of disc
  CALL LDCmdResp( "PL", r$ )     ' play
END SUB

' LDStepDemo
'  Step forward through 10 frames (much quicker)
'
SUB LDStepDemo STATIC
  CALL LDCmdSeek( STR$(3000), resp$ )
  FOR A = 1 TO 10
    CALL LDCmdResp( "SF", resp$ )
  NEXT A
END SUB

' LDSeekDemo
'  Re-seek on 10 frames (much slower)
'
SUB LDSeekDemo STATIC
  FOR A = 1 TO 10
    CALL LDCmdSeek( STR$(3000 + a), resp$)
  NEXT A
END SUB


'----------------------------------------
' higher level functions

' LDCmdSeek
'  Seek to the specified frame number (string)
'  LDP response string will be in resp$
'
SUB LDCmdSeek( frameno$, resp$ ) STATIC
  CALL LDCmdResp( "FR" + frameno$ + "SE", resp$ )
END SUB


'----------------------------------------
' interface functions

' LDCmdResp
'  Send the command string (cmd$)
'  LDP response string will be in resp$
'
SUB LDCmdResp( cmd$, resp$ ) STATIC
  CALL LDCmd( cmd$ )
  CALL LDGetResponse( resp$ )
END SUB


' LDCmd
'  Send the command string (cmd$)
'  <CR> is not to be included in the command
'
SUB LDCmd( cmd$ ) STATIC
  PRINT "TX: ";cmd$
  PRINT #1, cmd$;STR$(13)
END SUB


' LDGetResponse
'  Sit in a tight loop, blocking, to read for the 
'  next line of text responded by the LDP,
'  returned in response$
'  <CR> is not included in the response
SUB LDGetResponse( response$ ) STATIC
  response$ = ""
  acc$ = ""

  WHILE response$ = ""
  IF LOC(1) THEN
    char$=INPUT$(1,1)
      
    IF char$>"" THEN 
      IF ASC( char$ ) = 13 THEN
        'end of the response line
        response$ = acc$
        acc$ = ""
      ELSE
        'append to response
        acc$ = acc$+char$
      END IF
    END IF
    
    IF response$>"" THEN
      PRINT "RX: ";response$
    END IF
  END IF
  WEND
END SUB


'----------------------------------------
' Connection stuff

' LDOpen
'  open the serial (com port) connection on file 1
'
SUB LDOpen STATIC
  OPEN "COM1:4800,n,8,1" AS #1
END SUB

' LDClose
'   close the serial port connection on file 1
'
SUB LDClose STATIC
  CLOSE 1
END SUB
