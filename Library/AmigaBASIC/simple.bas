'  Simple example code to send and receive serial responses
'  AmigaBASIC to Serial Port/Pioneer L3 LaserDisc Player
' 
'  2020-10-17 yorgle@gmail.com
'

' connect to the serial port, for read-write
OPEN "SER:4800,N,8,1" AS #1

' FRame LeadOut SEek. (end of disc side)
PRINT #1, "FRLOSE"+CHR$(13)

' read the response. should be "R<CR>"
r$ = ""
c$ = ""
WHILE NOT c$ = CHR$(13)
  c$ = INPUT$(1,1)      ' ERROR: FIELD overflow
  r$ = r$ + c$
WEND
print "FRLOSE, RX: "; r$


' current Frame number request
PRINT #1, "?F";CHR$(13)

' read the response. should be like "45231<CR>"
r$ = ""
c$ = ""
WHILE NOT c$ = CHR$(13)
  c$ = INPUT$(1,1)
  r$ = r$ + c$
WEND
print "?F, RX: "; r$


' FRame 00000 SEek
PRINT #1, "FR00000SE"+CHR$(13)

' read the response. should be "R<CR>"
r$ = ""
c$ = ""
WHILE NOT c$ = CHR$(13)
  c$ = INPUT$(1,1)
  r$ = r$ + c$
WEND
print "FR00000SE, RX: "; r$
