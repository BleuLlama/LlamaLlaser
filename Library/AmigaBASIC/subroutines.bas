 ' Demo AmigaBASIC program to talk with an LD Player
'   yorgle@gmail.com
'
'  v1.0 - 2020-10 - Initial version
'
'  Note: does not check response values.


'----------------------------------------------'
' Varoius settings

' print everything we send
ldEchoRx = 1

' print everything we receive
ldEchoTx = 1


'----------------------------------------------'
' The main program thing.

' connect to the LDP
CALL LDConnect()

' send some things
CALL LDSendReadLn( "FRLOSE", response$ )
CALL LDSendReadLn( "FR00000SE", response$ )

FOR a=1 TO 20
  PRINT "Seek to frame "; a
  CALL LDSeek( a )
NEXT a


' and end it.
CALL LDDisconnect()
END


'----------------------------------------------'
' command-based functions

'LDSeek
'  Seek to a specific frame of the LDP
'
SUB LDSeek( frameno, response$ )
  CALL LDSendReadLn( "FR" + frameno + "SE", response$ )
END SUB


'----------------------------------------------'
' connect/disconnect

'LDConnect
'  Connect file #1 to the serial port.
'
SUB LDConnect()
  ' connect to the serial port as a file
  OPEN "SER:4800,N,8,1" FOR INPUT AS 2
  OPEN "SER:4800,N,8,1" FOR OUTPUT AS 2
END SUB


'LDDisconnect
'  Disconnect and close down the LDP
'
SUB LDDisconnect()
  ' disconnect the serial port file
  CLOSE 1,2
END SUB


'----------------------------------------------'
' Lower level functions

'LDSendReadLn
'  Helper function to send a command and wait for a response.
'    theCommand$ gets the command string to send (NO <CR>)
'    theResponse$ gets the response from the LDP (Without <CR>)
'
SUB LDSendReadLn( theCommand$, theResponse$ )
  ' Send the command and then read a response
  CALL LDSend( theCommand$ )
  CALL LDReadLn( theResponse$ )
END SUB


'LDSend
'  Send a command to the LDP
'    theCommand$ gets the command string to send (NO <CR>)
'
SUB LDSend( theCommand$ )
  IF ldEchoTx = 1 THEN
    PRINT "TX: ";theCommand$
  END IF 
  PRINT #2, theCommand$;CHR$(13)
END SUB


'LDReadLn
'  Read a <CR> terminated string from the LDP
'    theResponse$ gets the response from the LDP (Without <CR>)
'
SUB LDReadLn( theResponse$ )
  theResponse$ = ""
  ch$ = ""
  WHILE NOT ch$ = CHR$(13)
    ch$ = INPUT$(1,1)  '  fails here.
    'CR ends a string.
    IF NOT ch$ == CHR$(13) THEN
      theResponse$ = theResponse$ + $ch
    END IF
  WEND

  IF ldEchoRx = 1 THEN
    PRINT "RX: ";theResponse$
  END IF
END SUB

