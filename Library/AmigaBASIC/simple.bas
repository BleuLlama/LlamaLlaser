'  Simple example code to send and receive serial responses
'  AmigaBASIC to Serial Port/Pioneer L3 LaserDisc Player
' 
'  2020-10-17 yorgle@gmail.com
'
'  Note: if the LDP doesn't respond, this hangs because AmigaBASIC


'''''''''''''''''''''''''''''''''''''''''
' connect to the serial port, for read-write
OPEN "SER:4800,N,8,1" FOR INPUT AS 1
OPEN "SER:4800,N,8,1" FOR OUTPUT AS 2


'''''''''''''''''''''''''''''''''''''''''
' FRame LeadOut SEek. (end of disc side)
PRINT #2, "FRLOSE";CHR$(13)
GOSUB PrintResponse


'''''''''''''''''''''''''''''''''''''''''
' current Frame number request
PRINT #2, "?F";CHR$(13)

' read the response. should be like "45231<CR>"
GOSUB PrintResponse


'''''''''''''''''''''''''''''''''''''''''
' FRame 00000 SEek
PRINT #2, "FR00000SE";CHR$(13)

' read the response. should be "R<CR>"
GOSUB PrintResponse


'''''''''''''''''''''''''''''''''''''''''
' close the serial port
CLOSE 1,2
END


'''''''''''''''''''''''''''''''''''''''''
' Subroutines

' Get and print the response

PrintResponse:
  ' read the response. should be "R<CR>"
  r$ = ""
  c$ = ""
  WHILE c$ <> CHR$(13)
    c$ = INPUT$(1,1)      ' ERROR: FIELD overflow
    r$ = r$ + c$
  WEND
  PRINT "RX: "; r$
  RETURN
