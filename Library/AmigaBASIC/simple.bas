ldEchoRx = 1
ldEchoTx = 1


CALL LDConnect

CALL LDSendReadLn( "192RB", response$ )
CALL LDSendReadLn( "1DS", response$ )

FOR b = 0 TO 20
CALL LDSendReadLn( "FRLOSE", response$ )
CALL LDSendReadLn( "?F", response$ )
CALL LDSendReadLn( "FR0SE", response$ )

NEXT b

CALL LDDisconnect
END

SUB LDSeek( f ) STATIC
  CALL LDSendReadLn( "FR" + STR$(f) + "SE", response$ )
  END SUB
  

SUB LDConnect STATIC
  PRINT "Opening LD INPUT"
  OPEN "COM1:4800,N,8,1" AS #1
  END SUB

SUB LDDisconnect STATIC
  PRINT "Closing LD"
  CLOSE 1
END SUB
  
SUB LDSendReadLn( theCommand$, theResponse$ ) STATIC
  CALL LDSend( theCommand$ )
  CALL LDReadLn( theResponse$ )
END SUB

SUB LDSend( theCommand$ ) STATIC
SHARED ldEchoTx
  IF( ldEchoTx = 1 ) THEN
    PRINT "TX: ";theCommand$;"<CR>"
  END IF
  PRINT#1,theCommand$;CHR$(13)
END SUB

SUB LDReadLn( theResponse$ ) STATIC
SHARED ldEchoRx
  theResponse$ = ""
  ch$ ="X"
  WHILE NOT ch$ = CHR$(13)
    ch$=INPUT$(1,1)
    PRINT "GOT: ";ASC(ch$)
    IF LOC(1) THEN
      IF NOT ch$ = CHR$(13) THEN
        PRINT "GOT ";ch$
        theResponse$ =theResponse$ + ch$
      END IF
    END IF
  WEND
  
  IF( ldEchoRx = 1 ) THEN
    PRINT "RX: ";theResponse$
  END IF
END SUB
