EESchema Schematic File Version 4
LIBS:SerialWiring-cache
EELAYER 26 0
EELAYER END
$Descr USLetter 11000 8500
encoding utf-8
Sheet 1 1
Title "Serial Wiring"
Date "2020-08-21"
Rev "1.00"
Comp ""
Comment1 "Compiled by Scott Lawrence"
Comment2 "yorgle@gmail.com"
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Connector:DB15_Male_MountingHoles J?
U 1 1 5F408E75
P 1600 1850
F 0 "J?" H 1754 1761 50  0000 L CNN
F 1 "DB15 Male" H 1754 1852 50  0000 L CNN
F 2 "" H 1600 1850 50  0001 C CNN
F 3 " ~" H 1600 1850 50  0001 C CNN
	1    1600 1850
	-1   0    0    1   
$EndComp
$Comp
L Connector:DB9_Female_MountingHoles J?
U 1 1 5F408F6E
P 3050 1550
F 0 "J?" H 3229 1553 50  0000 L CNN
F 1 "DE9 Female" H 3229 1462 50  0000 L CNN
F 2 "" H 3050 1550 50  0001 C CNN
F 3 " ~" H 3050 1550 50  0001 C CNN
	1    3050 1550
	1    0    0    -1  
$EndComp
Text Notes 875  2500 0    50   ~ 0
Pioneer LDP\nFemale on LDP\n1 GND\n2 TX\n3 RX\n4 DTR\n5-15 n/c
Text Notes 3400 2575 0    50   ~ 0
9-Pin PC Serial\nMale on PC\n1 CD\n2 RX\n3 TX\n4 DTR\n5 GND\n6 DSR\n7 RTS\n8 CTS\n9 RING
Text Notes 1750 725  0    50   ~ 0
Pioneer LDP to PC Serial cable
Wire Wire Line
	2100 850  2100 1150
Wire Wire Line
	2100 1150 1900 1150
Wire Wire Line
	1600 950  1600 850 
Wire Wire Line
	1600 850  2100 850 
$Comp
L power:GND #PWR?
U 1 1 5F409495
P 3050 2300
F 0 "#PWR?" H 3050 2050 50  0001 C CNN
F 1 "GND" H 3055 2127 50  0000 C CNN
F 2 "" H 3050 2300 50  0001 C CNN
F 3 "" H 3050 2300 50  0001 C CNN
	1    3050 2300
	1    0    0    -1  
$EndComp
Wire Wire Line
	3050 2150 3050 2225
Wire Wire Line
	2750 1950 2675 1950
Wire Wire Line
	2675 1950 2675 2225
Wire Wire Line
	2675 2225 3050 2225
Connection ~ 3050 2225
Wire Wire Line
	3050 2225 3050 2300
Wire Wire Line
	2675 1950 2100 1950
Wire Wire Line
	2100 1950 2100 1150
Connection ~ 2675 1950
Connection ~ 2100 1150
Wire Wire Line
	1900 1350 2750 1350
Wire Wire Line
	1900 1550 2750 1550
Wire Wire Line
	1900 1750 2550 1750
Wire Wire Line
	2550 1750 2550 1650
Wire Wire Line
	2550 1150 2750 1150
Wire Wire Line
	2750 1250 2550 1250
Connection ~ 2550 1250
Wire Wire Line
	2550 1250 2550 1150
Wire Wire Line
	2750 1750 2550 1750
Connection ~ 2550 1750
Wire Wire Line
	2750 1650 2550 1650
Connection ~ 2550 1650
Wire Wire Line
	2550 1650 2550 1250
NoConn ~ 1900 1250
NoConn ~ 1900 1450
NoConn ~ 1900 1650
NoConn ~ 1900 1850
NoConn ~ 1900 1950
NoConn ~ 1900 2050
NoConn ~ 1900 2150
NoConn ~ 1900 2250
NoConn ~ 1900 2350
NoConn ~ 1900 2450
NoConn ~ 1900 2550
NoConn ~ 2750 1850
NoConn ~ 2750 1450
$Comp
L Connector:DB9_Male_MountingHoles J?
U 1 1 5F40C763
P 8050 3700
F 0 "J?" H 7970 4392 50  0000 C CNN
F 1 "DE9 Male" H 7970 4301 50  0000 C CNN
F 2 "" H 8050 3700 50  0001 C CNN
F 3 " ~" H 8050 3700 50  0001 C CNN
	1    8050 3700
	-1   0    0    -1  
$EndComp
$Comp
L Connector:DIN-5_180degree J?
U 1 1 5F40C9EE
P 9450 3500
F 0 "J?" V 9404 3270 50  0000 R CNN
F 1 "5-Din-180 Male" V 9495 3270 50  0000 R CNN
F 2 "" H 9450 3500 50  0001 C CNN
F 3 "http://www.mouser.com/ds/2/18/40_c091_abd_e-75918.pdf" H 9450 3500 50  0001 C CNN
	1    9450 3500
	0    -1   1    0   
$EndComp
Text Notes 5700 2500 0    50   ~ 0
5-Pin DIN Apple //c\nFemale on Apple //c\n1 DTR\n2 GND\n3 DSR\n4 TX from //c\n5 RX to //c
$Comp
L power:GND #PWR?
U 1 1 5F40CCDA
P 8050 4450
F 0 "#PWR?" H 8050 4200 50  0001 C CNN
F 1 "GND" H 8055 4277 50  0000 C CNN
F 2 "" H 8050 4450 50  0001 C CNN
F 3 "" H 8050 4450 50  0001 C CNN
	1    8050 4450
	1    0    0    -1  
$EndComp
Wire Wire Line
	8050 4300 8050 4400
Wire Wire Line
	9150 3500 8950 3500
Wire Wire Line
	8950 3500 8950 4400
Wire Wire Line
	8950 4400 8050 4400
Connection ~ 8050 4400
Wire Wire Line
	8050 4400 8050 4450
Wire Wire Line
	8350 3300 8950 3300
Wire Wire Line
	8950 3300 8950 3500
Connection ~ 8950 3500
Wire Wire Line
	9450 3200 9450 3000
Wire Wire Line
	8850 3700 8350 3700
Wire Wire Line
	8350 3900 9350 3900
Wire Wire Line
	9350 3900 9350 3800
Text Notes 8300 2875 0    50   ~ 0
Apple //c as PC Serial adapter\n(all appropriate connections)
$Comp
L Connector:DB9_Male_MountingHoles J?
U 1 1 5F417F06
P 8050 1650
F 0 "J?" H 7970 2342 50  0000 C CNN
F 1 "DE9 Male" H 7970 2251 50  0000 C CNN
F 2 "" H 8050 1650 50  0001 C CNN
F 3 " ~" H 8050 1650 50  0001 C CNN
	1    8050 1650
	-1   0    0    -1  
$EndComp
$Comp
L Connector:DIN-5_180degree J?
U 1 1 5F417F0C
P 9450 1450
F 0 "J?" V 9825 1075 50  0000 R CNN
F 1 "5-Din-180 Male" V 9925 1100 50  0000 R CNN
F 2 "" H 9450 1450 50  0001 C CNN
F 3 "http://www.mouser.com/ds/2/18/40_c091_abd_e-75918.pdf" H 9450 1450 50  0001 C CNN
	1    9450 1450
	0    -1   1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F417F13
P 8050 2400
F 0 "#PWR?" H 8050 2150 50  0001 C CNN
F 1 "GND" H 8055 2227 50  0000 C CNN
F 2 "" H 8050 2400 50  0001 C CNN
F 3 "" H 8050 2400 50  0001 C CNN
	1    8050 2400
	1    0    0    -1  
$EndComp
Wire Wire Line
	8050 2250 8050 2350
Wire Wire Line
	9150 1450 8950 1450
Wire Wire Line
	8950 1450 8950 2350
Wire Wire Line
	8950 2350 8050 2350
Connection ~ 8050 2350
Wire Wire Line
	8050 2350 8050 2400
Wire Wire Line
	8350 1250 8950 1250
Wire Wire Line
	8950 1250 8950 1450
Connection ~ 8950 1450
Wire Wire Line
	8850 1650 8350 1650
Wire Wire Line
	8350 1850 9350 1850
Wire Wire Line
	9350 1850 9350 1750
Text Notes 8300 825  0    50   ~ 0
Apple //c as PC Serial adapter\n(disable all handshaking)
Wire Wire Line
	8350 1550 8500 1550
Wire Wire Line
	8500 1550 8500 1750
Wire Wire Line
	8500 1750 8350 1750
Wire Wire Line
	9450 1150 9450 1050
Wire Wire Line
	9450 1050 9750 1050
Wire Wire Line
	9750 1050 9750 1850
Wire Wire Line
	9750 1850 9450 1850
Wire Wire Line
	9450 1850 9450 1750
NoConn ~ 8350 1350
Wire Wire Line
	8350 2050 8600 2050
Wire Wire Line
	8600 2050 8600 1950
Wire Wire Line
	8600 1450 8350 1450
Wire Wire Line
	8350 1950 8600 1950
Connection ~ 8600 1950
Wire Wire Line
	8600 1950 8600 1450
Wire Wire Line
	9450 4000 9450 3800
Wire Wire Line
	8350 4000 8500 4000
Wire Wire Line
	8750 3500 8350 3500
Wire Wire Line
	8750 3000 8750 3500
Wire Wire Line
	9450 3000 8750 3000
NoConn ~ 8350 3400
Wire Wire Line
	8350 3800 8500 3800
Wire Wire Line
	8500 3800 8500 3600
Wire Wire Line
	8500 3600 8350 3600
Wire Wire Line
	8350 4100 8500 4100
Wire Wire Line
	8500 4100 8500 4000
Connection ~ 8500 4000
Wire Wire Line
	8500 4000 9450 4000
$Comp
L Connector:DB9_Male_MountingHoles J?
U 1 1 5F4269C9
P 4650 1650
F 0 "J?" H 4570 2342 50  0000 C CNN
F 1 "DE9 Male" H 4570 2251 50  0000 C CNN
F 2 "" H 4650 1650 50  0001 C CNN
F 3 " ~" H 4650 1650 50  0001 C CNN
	1    4650 1650
	-1   0    0    -1  
$EndComp
$Comp
L Connector:DIN-5_180degree J?
U 1 1 5F4269CF
P 6050 1450
F 0 "J?" V 6350 925 50  0000 R CNN
F 1 "5-Din-180 Male" V 6450 950 50  0000 R CNN
F 2 "" H 6050 1450 50  0001 C CNN
F 3 "http://www.mouser.com/ds/2/18/40_c091_abd_e-75918.pdf" H 6050 1450 50  0001 C CNN
	1    6050 1450
	0    -1   1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F4269D6
P 4650 2400
F 0 "#PWR?" H 4650 2150 50  0001 C CNN
F 1 "GND" H 4655 2227 50  0000 C CNN
F 2 "" H 4650 2400 50  0001 C CNN
F 3 "" H 4650 2400 50  0001 C CNN
	1    4650 2400
	1    0    0    -1  
$EndComp
Wire Wire Line
	4650 2250 4650 2350
Wire Wire Line
	5750 1450 5550 1450
Wire Wire Line
	5550 1450 5550 2350
Wire Wire Line
	5550 2350 4650 2350
Connection ~ 4650 2350
Wire Wire Line
	4650 2350 4650 2400
Wire Wire Line
	4950 1250 5550 1250
Wire Wire Line
	5550 1250 5550 1450
Connection ~ 5550 1450
Wire Wire Line
	5450 1650 4950 1650
Wire Wire Line
	4950 1850 5950 1850
Wire Wire Line
	5950 1850 5950 1750
Text Notes 5075 925  0    50   ~ 0
Apple //c as PC Serial adapter\n(minimal, tested)
NoConn ~ 4950 1350
Wire Wire Line
	6050 1150 6050 1050
Wire Wire Line
	6050 1050 6350 1050
Wire Wire Line
	6350 1050 6350 1850
Wire Wire Line
	6350 1850 6050 1850
Wire Wire Line
	6050 1850 6050 1750
Wire Wire Line
	5950 1150 5950 1050
Wire Wire Line
	5950 1050 5450 1050
Wire Wire Line
	5450 1050 5450 1650
Wire Wire Line
	9350 3200 9350 3100
Wire Wire Line
	9350 3100 8850 3100
Wire Wire Line
	8850 3100 8850 3700
Wire Wire Line
	9350 1150 9350 1050
Wire Wire Line
	9350 1050 8850 1050
Wire Wire Line
	8850 1050 8850 1650
Wire Wire Line
	4950 1750 5100 1750
Wire Wire Line
	5100 1750 5100 1550
Wire Wire Line
	5100 1550 4950 1550
Wire Wire Line
	4950 1450 5200 1450
Wire Wire Line
	5200 1450 5200 1950
Wire Wire Line
	5200 2050 4950 2050
Wire Wire Line
	4950 1950 5200 1950
Connection ~ 5200 1950
Wire Wire Line
	5200 1950 5200 2050
Text Notes 5350 2725 0    50   Italic 0
(This is the layout of the pins looking into \nthe  connection side of the male plug)
$Comp
L Connector:DB25_Male_MountingHoles J?
U 1 1 5F447EA1
P 3675 5100
F 0 "J?" H 3855 5011 50  0000 L CNN
F 1 "DB25 Male" H 3855 5102 50  0000 L CNN
F 2 "" H 3675 5100 50  0001 C CNN
F 3 " ~" H 3675 5100 50  0001 C CNN
	1    3675 5100
	1    0    0    1   
$EndComp
$Comp
L Connector:DB9_Male_MountingHoles J?
U 1 1 5F45A617
P 1700 4900
F 0 "J?" H 1620 5592 50  0000 C CNN
F 1 "DE9 Male" H 1620 5501 50  0000 C CNN
F 2 "" H 1700 4900 50  0001 C CNN
F 3 " ~" H 1700 4900 50  0001 C CNN
	1    1700 4900
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F45A741
P 2750 5700
F 0 "#PWR?" H 2750 5450 50  0001 C CNN
F 1 "GND" H 2755 5527 50  0000 C CNN
F 2 "" H 2750 5700 50  0001 C CNN
F 3 "" H 2750 5700 50  0001 C CNN
	1    2750 5700
	1    0    0    -1  
$EndComp
Text Notes 1025 3850 0    50   ~ 0
Tandy 102, Amiga 500 as PC adapter
Wire Wire Line
	2000 5100 2600 5100
Wire Wire Line
	2600 5100 2600 4300
Wire Wire Line
	2600 4300 3375 4300
Wire Wire Line
	3375 4100 2450 4100
Wire Wire Line
	2450 4100 2450 4900
Wire Wire Line
	2450 4900 2000 4900
Wire Wire Line
	2750 4700 3375 4700
Wire Wire Line
	2750 3600 3675 3600
Wire Wire Line
	3675 3600 3675 3700
Wire Wire Line
	2750 3600 2750 4500
Connection ~ 2750 4700
Wire Wire Line
	2750 5600 1700 5600
Wire Wire Line
	1700 5600 1700 5500
Wire Wire Line
	2750 5600 2750 5700
Connection ~ 2750 5600
NoConn ~ 3375 3900
NoConn ~ 3375 4000
NoConn ~ 3375 4200
NoConn ~ 3375 4400
NoConn ~ 3375 4500
NoConn ~ 3375 4600
NoConn ~ 3375 4800
NoConn ~ 3375 4900
NoConn ~ 3375 5000
NoConn ~ 3375 5100
NoConn ~ 3375 5200
NoConn ~ 3375 5300
NoConn ~ 3375 5400
NoConn ~ 3375 5500
NoConn ~ 3375 5600
NoConn ~ 3375 5700
NoConn ~ 3375 5800
NoConn ~ 3375 5900
NoConn ~ 3375 6000
NoConn ~ 3375 6100
NoConn ~ 3375 6200
NoConn ~ 3375 6300
NoConn ~ 2000 5300
NoConn ~ 2000 5200
NoConn ~ 2000 4800
NoConn ~ 2000 4600
NoConn ~ 2000 4700
Text Notes 3950 5375 0    50   ~ 0
Use Gender changer to attach \nthis to Amiga 1000
Wire Wire Line
	2000 4500 2750 4500
Wire Wire Line
	2750 4700 2750 5600
Connection ~ 2750 4500
Wire Wire Line
	2750 4500 2750 4700
NoConn ~ 2000 5000
$EndSCHEMATC
