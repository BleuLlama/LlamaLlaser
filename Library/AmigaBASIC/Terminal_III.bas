' Terminal III
'
'  Originally printed in the book
'  Advanced Amiga BASIC
'  by Tom R. Halfhill and Charles Brannon
'  on page 285
'  https://archive.org/details/COMPUTEs_Advanced_AmigaBASIC_1986_COMPUTE_Publications/mode/2up
'
'  Features: XON/XOFF support, Character Translation

OPEN "com1:300,N,8,1" AS #1
duplex=0 '=1 for half, 0 for full

' ----- Character Translation
DIM th%(255),tr%(255)
FOR i=0 TO 255:th%(i)=i:tr%(i)=i:NEXT
'  set up your translations here:
'  TH% translates from host
'  TR% translates from remote
th%(8)=126:tr%(126)=8    ' translate Atari backspace
th%(13)=155:tr%(155)=13  ' translate Atari carriage return
' ----- END Character Translation

WHILE -1 'forever...
  key$=INKEY$:IF key$>"" THEN
    IF duplex THEN PRINT key$;
	' and translate
    PRINT #1,CHR$(th%(ASC(key$)));
  END IF
  IF LOC(1) THEN
    char$=INPUT$(1,1)
	' and translate
    IF char$>"" THEN PRINT CHR$(tr%(ASC(char$)));
    ' ----- beginning of XON/XOFF addition
    IF char$=CHR$(19) THEN
      WaitForXon:
      IF INPUT$(1,1)<>CHR$(17) THEN WaitForXon
    END IF
    ' ----- end of XON/XOFF addition
  END IF
WEND

