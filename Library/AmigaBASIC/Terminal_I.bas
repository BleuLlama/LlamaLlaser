' Terminal I
'
'  Originally printed in the book
'  Advanced Amiga BASIC
'  by Tom R. Halfhill and Charles Brannon
'  on pages 283-284
'  https://archive.org/details/COMPUTEs_Advanced_AmigaBASIC_1986_COMPUTE_Publications/mode/2up
'
'  This is the skeleton version of the program.

OPEN "com1:4800,N,8,1" AS #1
duplex=0 '=1 for half, 0 for full

WHILE -1 'forever...
  key$=INKEY$
  IF key$>"" THEN
    IF duplex THEN PRINT key$;
    PRINT #1,key$;
  END IF
  
  IF LOC(1) THEN
    char$=INPUT$(1,1)
    IF char$>"" THEN PRINT char$;
  END IF
WEND

