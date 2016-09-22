EESchema Schematic File Version 2  date 8/8/2010 21:16:55
LIBS:power,device,transistors,conn,linear,regul,74xx,cmos4000,adc-dac,memory,xilinx,special,microcontrollers,dsp,microchip,analog_switches,motorola,texas,intel,audio,interface,digital-audio,philips,display,cypress,siliconi,opto,atmel,contrib,valves,.\girador.cache
EELAYER 24  0
EELAYER END
$Descr A4 11700 8267
Sheet 1 1
Title "noname.sch"
Date "8 aug 2010"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text Notes 8200 3350 0    60   ~ 0
Girador
Wire Notes Line
	10250 1700 6700 1700
Wire Notes Line
	10250 1700 10250 3600
Wire Notes Line
	10250 3600 6700 3600
Wire Notes Line
	6700 3600 6700 1700
Wire Wire Line
	9450 2350 7700 2350
Connection ~ 6300 3050
Wire Wire Line
	5900 3050 6300 3050
Connection ~ 5000 2350
Wire Wire Line
	5000 2550 5000 2350
Wire Wire Line
	5000 3050 5000 2950
Wire Wire Line
	6300 2750 6300 3200
Wire Wire Line
	2100 5750 2100 5000
Wire Wire Line
	1150 4700 1150 5750
Wire Wire Line
	2100 4600 2100 3700
Wire Wire Line
	2100 3700 2350 3700
Wire Wire Line
	3200 4200 3200 4700
Wire Wire Line
	3200 4700 3100 4700
Wire Wire Line
	2700 4200 2500 4200
Wire Wire Line
	4500 5300 4500 3700
Wire Wire Line
	3600 5300 3600 3700
Wire Wire Line
	3600 3700 3250 3700
Wire Wire Line
	4500 3700 5700 3700
Wire Wire Line
	2700 4700 2500 4700
Wire Wire Line
	3100 4200 3400 4200
Wire Wire Line
	3400 4200 3400 3700
Connection ~ 3400 3700
Connection ~ 3200 4200
Wire Wire Line
	2350 4450 2100 4450
Connection ~ 2100 4450
Wire Wire Line
	6300 4200 6300 5750
Wire Wire Line
	6300 5750 1150 5750
Connection ~ 2100 5750
Wire Wire Line
	6300 2350 1150 2350
Wire Wire Line
	1150 2350 1150 4100
Wire Wire Line
	5500 3050 4650 3050
Wire Wire Line
	4650 3050 4650 3000
Connection ~ 5000 3050
Wire Wire Line
	4650 2500 4650 2350
Connection ~ 4650 2350
Wire Wire Line
	7100 2350 7300 2350
Wire Wire Line
	9450 2750 7100 2750
Text Notes 8400 2550 0    60   ~ 0
Para o girador--->
$Comp
L C C?
U 1 1 4C5F4870
P 8000 2550
F 0 "C?" H 8050 2650 50  0000 L CNN
F 1 "C" H 8050 2450 50  0000 L CNN
	1    8000 2550
	1    0    0    -1  
$EndComp
$Comp
L DIODE D?
U 1 1 4C5F4869
P 7500 2350
F 0 "D?" H 7500 2450 40  0000 C CNN
F 1 "DIODE" H 7500 2250 40  0000 C CNN
	1    7500 2350
	1    0    0    -1  
$EndComp
$Comp
L R R?
U 1 1 4C5F4822
P 4650 2750
F 0 "R?" V 4730 2750 50  0000 C CNN
F 1 "R" V 4650 2750 50  0000 C CNN
	1    4650 2750
	1    0    0    -1  
$EndComp
$Comp
L C C?
U 1 1 4C5F4818
P 5000 2750
F 0 "C?" H 5050 2850 50  0000 L CNN
F 1 "C" H 5050 2650 50  0000 L CNN
	1    5000 2750
	1    0    0    -1  
$EndComp
$Comp
L DIODE D?
U 1 1 4C5F4810
P 5700 3050
F 0 "D?" H 5700 3150 40  0000 C CNN
F 1 "DIODE" H 5700 2950 40  0000 C CNN
	1    5700 3050
	-1   0    0    1   
$EndComp
$Comp
L TRANSFO T?
U 1 1 4C5F4702
P 6700 2550
F 0 "T?" H 6700 2800 70  0000 C CNN
F 1 "." H 6700 2250 70  0000 C CNN
	1    6700 2550
	1    0    0    -1  
$EndComp
$Comp
L C C?
U 1 1 4C5F45D0
P 2100 4800
F 0 "C?" H 2150 4900 50  0000 L CNN
F 1 "C" H 2150 4700 50  0000 L CNN
	1    2100 4800
	1    0    0    -1  
$EndComp
$Comp
L DIODE D?
U 1 1 4C5F4583
P 2900 4200
F 0 "D?" H 2900 4300 40  0000 C CNN
F 1 "DIODE" H 2900 4100 40  0000 C CNN
	1    2900 4200
	1    0    0    -1  
$EndComp
$Comp
L DIODE D?
U 1 1 4C5F457D
P 2900 4700
F 0 "D?" H 2900 4800 40  0000 C CNN
F 1 "DIODE" H 2900 4600 40  0000 C CNN
	1    2900 4700
	-1   0    0    1   
$EndComp
$Comp
L POT RV?
U 1 1 4C5F4558
P 2500 4450
F 0 "RV?" H 2500 4450 50  0000 C CNN
F 1 "10K" V 2500 4300 50  0000 C CNN
	1    2500 4450
	0    -1   -1   0   
$EndComp
$Comp
L 74HC14 U?
U 1 1 4C5F44D8
P 4050 5300
F 0 "U?" H 4200 5400 40  0000 C CNN
F 1 "74HC14" H 4250 5200 40  0000 C CNN
	1    4050 5300
	1    0    0    -1  
$EndComp
$Comp
L 74HC14 U?
U 1 1 4C5F44C9
P 4050 4900
F 0 "U?" H 4200 5000 40  0000 C CNN
F 1 "74HC14" H 4250 4800 40  0000 C CNN
	1    4050 4900
	1    0    0    -1  
$EndComp
$Comp
L 74HC14 U?
U 1 1 4C5F44C5
P 4050 4500
F 0 "U?" H 4200 4600 40  0000 C CNN
F 1 "74HC14" H 4250 4400 40  0000 C CNN
	1    4050 4500
	1    0    0    -1  
$EndComp
$Comp
L 74HC14 U?
U 1 1 4C5F44C0
P 4050 4100
F 0 "U?" H 4200 4200 40  0000 C CNN
F 1 "74HC14" H 4250 4000 40  0000 C CNN
	1    4050 4100
	1    0    0    -1  
$EndComp
$Comp
L 74HC14 U?
U 1 1 4C5F44B9
P 4050 3700
F 0 "U?" H 4200 3800 40  0000 C CNN
F 1 "74HC14" H 4250 3600 40  0000 C CNN
	1    4050 3700
	1    0    0    -1  
$EndComp
$Comp
L 74HC14 U?
U 1 1 4C5F44A9
P 2800 3700
F 0 "U?" H 2950 3800 40  0000 C CNN
F 1 "74HC14" H 3000 3600 40  0000 C CNN
	1    2800 3700
	1    0    0    -1  
$EndComp
$Comp
L MOS U?
U 1 1 4C5F447B
P 5900 3700
F 0 "U?" H 6200 3650 60  0000 C CNN
F 1 "MOS" H 6250 3800 60  0000 C CNN
	1    5900 3700
	1    0    0    -1  
$EndComp
$Comp
L BATTERY BT?
U 1 1 4C5F4220
P 1150 4400
F 0 "BT?" H 1150 4600 50  0000 C CNN
F 1 "BATTERY" H 1150 4210 50  0000 C CNN
	1    1150 4400
	0    1    1    0   
$EndComp
$EndSCHEMATC
