5 PRINT "a"
10 GOSUB 100
15 PRINT "B"
20 GOSUB 300
25 PRINT "C"
30 PRINT "done."
99 END
100 REM Serial Setup
120 OPEN "COM:78N1DII" FOR OUTPUT AS #1
130 OPEN "COM:78N1DIO" FOR INPUT AS #2
140 ON COM GOSUB 200
150 COM ON
160 RETURN
200 REM got serial
210 LINE INPUT #2, R$
215 REM R$ = INPUT #2
220 PRINT "Got ", R$
230 RETURN
300 PRINT "300 - 255RB"
310 PRINT #1, "LOSE"
320 PRINT #1, "FR0SE"
330 RETURN
