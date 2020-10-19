'  Simple example code to send and receive serial responses
'  AmigaBASIC to Serial Port/Pioneer L3 LaserDisc Player
' 
'  2020-10-17 yorgle@gmail.com
'
'  Note: if the LDP doesn't respond, this hangs because AmigaBASIC


'''''''''''''''''''''''''''''''''''''''''
' connect to the serial port, for read-write
REM OPEN "R",#1,"SER:4800,N,8,1"
OPEN "com1:4800,N,8,1" AS #1


'''''''''''''''''''''''''''''''''''''''''
' FRame LeadOut SEek. (end of disc side)
PRINT #1, "FRLOSE";CHR$(13)
GOSUB PrintResponse


'''''''''''''''''''''''''''''''''''''''''
' current Frame number request
PRINT #1, "?F";CHR$(13)

' read the response. should be like "45231<CR>"
GOSUB PrintResponse


'''''''''''''''''''''''''''''''''''''''''
' FRame 00000 SEek
PRINT #1, "FR00000SE";CHR$(13)

' read the response. should be "R<CR>"
GOSUB PrintResponse


'''''''''''''''''''''''''''''''''''''''''
' close the serial port
CLOSE 1
END


'''''''''''''''''''''''''''''''''''''''''
' Subroutines

' Get and print the response

PrintResponse:
  ' read the response. should be "R<CR>"
  r$ = ""
  c$ = ""
  WHILE c$ <> CHR$(13)
    IF LOC(1) THEN     ' character available?
      c$ = INPUT$(1,1)
      IF c$>"" THEN
        r$ = r$ + c$   ' append it
      END IF
    END IF
  WEND
  PRINT "RX: "; r$
  RETURN
