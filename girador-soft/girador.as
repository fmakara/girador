opt subtitle "HI-TECH Software Omniscient Code Generator (Lite mode) build 10920"

opt pagewidth 120

	opt lm

	processor	16F877A
clrc	macro
	bcf	3,0
	endm
clrz	macro
	bcf	3,2
	endm
setc	macro
	bsf	3,0
	endm
setz	macro
	bsf	3,2
	endm
skipc	macro
	btfss	3,0
	endm
skipz	macro
	btfss	3,2
	endm
skipnc	macro
	btfsc	3,0
	endm
skipnz	macro
	btfsc	3,2
	endm
indf	equ	0
indf0	equ	0
pc	equ	2
pcl	equ	2
status	equ	3
fsr	equ	4
fsr0	equ	4
c	equ	1
z	equ	0
pclath	equ	10
# 2 "C:\Users\Felipe\Desktop\GIRADOR+IR\girador-soft\girador.c"
	psect config,class=CONFIG,delta=2 ;#
# 2 "C:\Users\Felipe\Desktop\GIRADOR+IR\girador-soft\girador.c"
	dw 0x3F32 ;#
	FNCALL	_main,___awmod
	FNCALL	_main,_desenhar_relogio_analogico
	FNCALL	_main,_desenhar_relogio_digital
	FNCALL	_main,_tentar_mostrar_expoeletrica
	FNCALL	_main,_verificar_botoes
	FNCALL	_tentar_mostrar_expoeletrica,___awmod
	FNCALL	_tentar_mostrar_expoeletrica,_mostrar_caractere
	FNCALL	_desenhar_relogio_digital,_desenhar_numero
	FNCALL	_desenhar_relogio_digital,_linha
	FNCALL	_mostrar_caractere,_ponto
	FNCALL	_desenhar_numero,_ponto
	FNCALL	_linha,___wmul
	FNCALL	_linha,___awdiv
	FNCALL	_linha,_ponto
	FNCALL	_desenhar_relogio_analogico,___wmul
	FNCALL	_desenhar_relogio_analogico,___awmod
	FNCALL	_desenhar_relogio_analogico,___bmul
	FNCALL	_ponto,___wmul
	FNCALL	_ponto,___awdiv
	FNROOT	_main
	FNCALL	intlevel1,_interrupcoes
	global	intlevel1
	FNROOT	intlevel1
	global	_hh
	global	_mh
	global	_mudar
	global	_sh
	global	_ultima
	global	_telaHL
	global	_telaL
	global	_LAST_SENSOR
	global	_SENSOR
	global	_delay
	global	_frame
	global	_parte
	global	_telaHF
	global	_hl
	global	_ml
	global	_sl
	global	_CALIBRACAO
psect	nvCOMMON,class=COMMON,space=1
global __pnvCOMMON
__pnvCOMMON:
_CALIBRACAO:
       ds      1

	global	_INTCON
_INTCON	set	11
	global	_PORTA
_PORTA	set	5
	global	_PORTD
_PORTD	set	8
	global	_PORTE
_PORTE	set	9
	global	_T1CON
_T1CON	set	16
	global	_TMR0
_TMR0	set	1
	global	_TMR1H
_TMR1H	set	15
	global	_TMR1L
_TMR1L	set	14
	global	_CARRY
_CARRY	set	24
	global	_GIE
_GIE	set	95
	global	_INTF
_INTF	set	89
	global	_RC3
_RC3	set	59
	global	_RC4
_RC4	set	60
	global	_TMR0IE
_TMR0IE	set	93
	global	_TMR0IF
_TMR0IF	set	90
	global	_TMR1IF
_TMR1IF	set	96
	global	_OPTION_REG
_OPTION_REG	set	129
	global	_PIE1
_PIE1	set	140
	global	_TRISA
_TRISA	set	133
	global	_TRISC
_TRISC	set	135
	global	_TRISD
_TRISD	set	136
	global	_TRISE
_TRISE	set	137
	global	_INTEDG
_INTEDG	set	1038
	global	_EEADR
_EEADR	set	269
	global	_EEDATA
_EEDATA	set	268
	global	_EECON1
_EECON1	set	396
	global	_EECON2
_EECON2	set	397
	global	_RD
_RD	set	3168
	global	_WR
_WR	set	3169
	global	_WREN
_WREN	set	3170
	file	"girador.as"
	line	#
psect cinit,class=CODE,delta=2
global start_initialization
start_initialization:

psect	bssCOMMON,class=COMMON,space=1
global __pbssCOMMON
__pbssCOMMON:
_LAST_SENSOR:
       ds      1

_SENSOR:
       ds      1

_delay:
       ds      1

_frame:
       ds      1

_parte:
       ds      1

psect	bssBANK0,class=BANK0,space=1
global __pbssBANK0
__pbssBANK0:
_hh:
       ds      1

_mh:
       ds      1

_mudar:
       ds      1

_sh:
       ds      1

_ultima:
       ds      1

_hl:
       ds      1

_ml:
       ds      1

_sl:
       ds      1

psect	bssBANK1,class=BANK1,space=1
global __pbssBANK1
__pbssBANK1:
_telaHF:
       ds      60

psect	bssBANK3,class=BANK3,space=1
global __pbssBANK3
__pbssBANK3:
_telaL:
       ds      60

psect	bssBANK2,class=BANK2,space=1
global __pbssBANK2
__pbssBANK2:
_telaHL:
       ds      60

psect clrtext,class=CODE,delta=2
global clear_ram
;	Called with FSR containing the base address, and
;	W with the last address+1
clear_ram:
	clrwdt			;clear the watchdog before getting into this loop
clrloop:
	clrf	indf		;clear RAM location pointed to by FSR
	incf	fsr,f		;increment pointer
	xorwf	fsr,w		;XOR with final address
	btfsc	status,2	;have we reached the end yet?
	retlw	0		;all done for this memory range, return
	xorwf	fsr,w		;XOR again to restore value
	goto	clrloop		;do the next byte

; Clear objects allocated to COMMON
psect cinit,class=CODE,delta=2
	clrf	((__pbssCOMMON)+0)&07Fh
	clrf	((__pbssCOMMON)+1)&07Fh
	clrf	((__pbssCOMMON)+2)&07Fh
	clrf	((__pbssCOMMON)+3)&07Fh
	clrf	((__pbssCOMMON)+4)&07Fh
; Clear objects allocated to BANK0
psect cinit,class=CODE,delta=2
	bcf	status, 7	;select IRP bank0
	movlw	low(__pbssBANK0)
	movwf	fsr
	movlw	low((__pbssBANK0)+08h)
	fcall	clear_ram
; Clear objects allocated to BANK1
psect cinit,class=CODE,delta=2
	movlw	low(__pbssBANK1)
	movwf	fsr
	movlw	low((__pbssBANK1)+03Ch)
	fcall	clear_ram
; Clear objects allocated to BANK3
psect cinit,class=CODE,delta=2
	bsf	status, 7	;select IRP bank2
	movlw	low(__pbssBANK3)
	movwf	fsr
	movlw	low((__pbssBANK3)+03Ch)
	fcall	clear_ram
; Clear objects allocated to BANK2
psect cinit,class=CODE,delta=2
	movlw	low(__pbssBANK2)
	movwf	fsr
	movlw	low((__pbssBANK2)+03Ch)
	fcall	clear_ram
psect cinit,class=CODE,delta=2
global end_of_initialization

;End of C runtime variable initialization code

end_of_initialization:
clrf status
ljmp _main	;jump to C main() function
psect	cstackCOMMON,class=COMMON,space=1
global __pcstackCOMMON
__pcstackCOMMON:
	global	?_desenhar_relogio_digital
?_desenhar_relogio_digital:	; 0 bytes @ 0x0
	global	?_desenhar_relogio_analogico
?_desenhar_relogio_analogico:	; 0 bytes @ 0x0
	global	?_tentar_mostrar_expoeletrica
?_tentar_mostrar_expoeletrica:	; 0 bytes @ 0x0
	global	?_verificar_botoes
?_verificar_botoes:	; 0 bytes @ 0x0
	global	?_main
?_main:	; 0 bytes @ 0x0
	global	?_interrupcoes
?_interrupcoes:	; 0 bytes @ 0x0
	global	??_interrupcoes
??_interrupcoes:	; 0 bytes @ 0x0
	ds	7
	global	interrupcoes@buf
interrupcoes@buf:	; 1 bytes @ 0x7
	ds	1
psect	cstackBANK0,class=BANK0,space=1
global __pcstackBANK0
__pcstackBANK0:
	global	??_verificar_botoes
??_verificar_botoes:	; 0 bytes @ 0x0
	global	?___wmul
?___wmul:	; 2 bytes @ 0x0
	global	___wmul@multiplier
___wmul@multiplier:	; 2 bytes @ 0x0
	ds	2
	global	___wmul@multiplicand
___wmul@multiplicand:	; 2 bytes @ 0x2
	ds	2
	global	??___wmul
??___wmul:	; 0 bytes @ 0x4
	global	___wmul@product
___wmul@product:	; 2 bytes @ 0x4
	ds	2
	global	?___awdiv
?___awdiv:	; 2 bytes @ 0x6
	global	?___awmod
?___awmod:	; 2 bytes @ 0x6
	global	___awdiv@divisor
___awdiv@divisor:	; 2 bytes @ 0x6
	global	___awmod@divisor
___awmod@divisor:	; 2 bytes @ 0x6
	ds	2
	global	___awdiv@dividend
___awdiv@dividend:	; 2 bytes @ 0x8
	global	___awmod@dividend
___awmod@dividend:	; 2 bytes @ 0x8
	ds	2
	global	??___awdiv
??___awdiv:	; 0 bytes @ 0xA
	global	??___awmod
??___awmod:	; 0 bytes @ 0xA
	ds	1
	global	___awdiv@counter
___awdiv@counter:	; 1 bytes @ 0xB
	global	___awmod@counter
___awmod@counter:	; 1 bytes @ 0xB
	ds	1
	global	___awdiv@sign
___awdiv@sign:	; 1 bytes @ 0xC
	global	___awmod@sign
___awmod@sign:	; 1 bytes @ 0xC
	ds	1
	global	?___bmul
?___bmul:	; 1 bytes @ 0xD
	global	___bmul@multiplicand
___bmul@multiplicand:	; 1 bytes @ 0xD
	global	___awdiv@quotient
___awdiv@quotient:	; 2 bytes @ 0xD
	ds	1
	global	??___bmul
??___bmul:	; 0 bytes @ 0xE
	ds	1
	global	?_ponto
?_ponto:	; 0 bytes @ 0xF
	global	ponto@y
ponto@y:	; 1 bytes @ 0xF
	global	___bmul@product
___bmul@product:	; 1 bytes @ 0xF
	ds	1
	global	ponto@aceso
ponto@aceso:	; 1 bytes @ 0x10
	global	___bmul@multiplier
___bmul@multiplier:	; 1 bytes @ 0x10
	ds	1
	global	??_ponto
??_ponto:	; 0 bytes @ 0x11
	global	??_desenhar_relogio_analogico
??_desenhar_relogio_analogico:	; 0 bytes @ 0x11
	ds	4
	global	desenhar_relogio_analogico@hora
desenhar_relogio_analogico@hora:	; 1 bytes @ 0x15
	ds	1
	global	desenhar_relogio_analogico@minuto
desenhar_relogio_analogico@minuto:	; 1 bytes @ 0x16
	ds	1
	global	desenhar_relogio_analogico@segundo
desenhar_relogio_analogico@segundo:	; 1 bytes @ 0x17
	ds	1
	global	desenhar_relogio_analogico@a
desenhar_relogio_analogico@a:	; 1 bytes @ 0x18
	ds	3
	global	ponto@up
ponto@up:	; 1 bytes @ 0x1B
	ds	1
	global	ponto@parity
ponto@parity:	; 1 bytes @ 0x1C
	ds	1
	global	ponto@bits
ponto@bits:	; 1 bytes @ 0x1D
	ds	1
	global	ponto@x
ponto@x:	; 1 bytes @ 0x1E
	ds	1
	global	ponto@ang
ponto@ang:	; 1 bytes @ 0x1F
	ds	1
	global	ponto@raiz
ponto@raiz:	; 2 bytes @ 0x20
	ds	2
	global	?_linha
?_linha:	; 0 bytes @ 0x22
	global	?_desenhar_numero
?_desenhar_numero:	; 0 bytes @ 0x22
	global	?_mostrar_caractere
?_mostrar_caractere:	; 0 bytes @ 0x22
	global	linha@y1
linha@y1:	; 1 bytes @ 0x22
	global	desenhar_numero@x
desenhar_numero@x:	; 1 bytes @ 0x22
	global	mostrar_caractere@letra
mostrar_caractere@letra:	; 1 bytes @ 0x22
	ds	1
	global	??_mostrar_caractere
??_mostrar_caractere:	; 0 bytes @ 0x23
	global	linha@x3
linha@x3:	; 1 bytes @ 0x23
	global	desenhar_numero@y
desenhar_numero@y:	; 1 bytes @ 0x23
	ds	1
	global	??_desenhar_numero
??_desenhar_numero:	; 0 bytes @ 0x24
	global	linha@y3
linha@y3:	; 1 bytes @ 0x24
	global	mostrar_caractere@posx
mostrar_caractere@posx:	; 1 bytes @ 0x24
	ds	1
	global	??_tentar_mostrar_expoeletrica
??_tentar_mostrar_expoeletrica:	; 0 bytes @ 0x25
	global	linha@def
linha@def:	; 1 bytes @ 0x25
	global	desenhar_numero@num
desenhar_numero@num:	; 1 bytes @ 0x25
	ds	1
	global	linha@clear
linha@clear:	; 1 bytes @ 0x26
	ds	1
	global	??_linha
??_linha:	; 0 bytes @ 0x27
	global	tentar_mostrar_expoeletrica@k
tentar_mostrar_expoeletrica@k:	; 1 bytes @ 0x27
	ds	9
	global	linha@x1
linha@x1:	; 1 bytes @ 0x30
	ds	1
	global	linha@x
linha@x:	; 1 bytes @ 0x31
	ds	1
	global	linha@y
linha@y:	; 1 bytes @ 0x32
	ds	1
	global	linha@n
linha@n:	; 1 bytes @ 0x33
	ds	1
	global	??_desenhar_relogio_digital
??_desenhar_relogio_digital:	; 0 bytes @ 0x34
	ds	3
	global	desenhar_relogio_digital@buffer
desenhar_relogio_digital@buffer:	; 1 bytes @ 0x37
	ds	1
	global	??_main
??_main:	; 0 bytes @ 0x38
	ds	2
;;Data sizes: Strings 0, constant 0, data 0, bss 193, persistent 1 stack 0
;;Auto spaces:   Size  Autos    Used
;; COMMON          14      8      14
;; BANK0           80     58      66
;; BANK1           80      0      60
;; BANK3           96      0      60
;; BANK2           96      0      60

;;
;; Pointer list with targets:

;; ?___awmod	int  size(1) Largest target is 0
;;
;; ?___awdiv	int  size(1) Largest target is 0
;;
;; ?___wmul	unsigned int  size(1) Largest target is 0
;;


;;
;; Critical Paths under _main in COMMON
;;
;;   None.
;;
;; Critical Paths under _interrupcoes in COMMON
;;
;;   None.
;;
;; Critical Paths under _main in BANK0
;;
;;   _main->_desenhar_relogio_digital
;;   _tentar_mostrar_expoeletrica->_mostrar_caractere
;;   _desenhar_relogio_digital->_linha
;;   _mostrar_caractere->_ponto
;;   _desenhar_numero->_ponto
;;   _linha->_ponto
;;   _desenhar_relogio_analogico->___bmul
;;   _ponto->___awdiv
;;   ___awmod->___wmul
;;   ___awdiv->___wmul
;;   ___bmul->___awmod
;;
;; Critical Paths under _interrupcoes in BANK0
;;
;;   None.
;;
;; Critical Paths under _main in BANK1
;;
;;   None.
;;
;; Critical Paths under _interrupcoes in BANK1
;;
;;   None.
;;
;; Critical Paths under _main in BANK3
;;
;;   None.
;;
;; Critical Paths under _interrupcoes in BANK3
;;
;;   None.
;;
;; Critical Paths under _main in BANK2
;;
;;   None.
;;
;; Critical Paths under _interrupcoes in BANK2
;;
;;   None.

;;
;;Main: autosize = 0, tempsize = 2, incstack = 0, save=0
;;

;;
;;Call Graph Tables:
;;
;; ---------------------------------------------------------------------------------
;; (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;; ---------------------------------------------------------------------------------
;; (0) _main                                                 2     2      0   18962
;;                                             56 BANK0      2     2      0
;;                            ___awmod
;;         _desenhar_relogio_analogico
;;           _desenhar_relogio_digital
;;        _tentar_mostrar_expoeletrica
;;                   _verificar_botoes
;; ---------------------------------------------------------------------------------
;; (1) _tentar_mostrar_expoeletrica                          3     3      0    5266
;;                                             37 BANK0      3     3      0
;;                            ___awmod
;;                  _mostrar_caractere
;; ---------------------------------------------------------------------------------
;; (1) _desenhar_relogio_digital                             4     4      0   12426
;;                                             52 BANK0      4     4      0
;;                    _desenhar_numero
;;                              _linha
;; ---------------------------------------------------------------------------------
;; (2) _mostrar_caractere                                    3     2      1    4615
;;                                             34 BANK0      3     2      1
;;                              _ponto
;; ---------------------------------------------------------------------------------
;; (2) _desenhar_numero                                      4     2      2    9103
;;                                             34 BANK0      4     2      2
;;                              _ponto
;; ---------------------------------------------------------------------------------
;; (2) _linha                                               18    13      5    3211
;;                                             34 BANK0     18    13      5
;;                             ___wmul
;;                            ___awdiv
;;                              _ponto
;; ---------------------------------------------------------------------------------
;; (1) _verificar_botoes                                     2     2      0       0
;;                                              0 BANK0      2     2      0
;; ---------------------------------------------------------------------------------
;; (1) _desenhar_relogio_analogico                           8     8      0     974
;;                                             17 BANK0      8     8      0
;;                             ___wmul
;;                            ___awmod
;;                             ___bmul
;; ---------------------------------------------------------------------------------
;; (3) _ponto                                               19    17      2    2393
;;                                             15 BANK0     19    17      2
;;                             ___wmul
;;                            ___awdiv
;; ---------------------------------------------------------------------------------
;; (2) ___awmod                                              7     3      4     296
;;                                              6 BANK0      7     3      4
;;                             ___wmul (ARG)
;; ---------------------------------------------------------------------------------
;; (4) ___awdiv                                              9     5      4     300
;;                                              6 BANK0      9     5      4
;;                             ___wmul (ARG)
;; ---------------------------------------------------------------------------------
;; (4) ___wmul                                               6     2      4      92
;;                                              0 BANK0      6     2      4
;; ---------------------------------------------------------------------------------
;; (2) ___bmul                                               4     3      1      92
;;                                             13 BANK0      4     3      1
;;                            ___awmod (ARG)
;;                             ___wmul (ARG)
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 4
;; ---------------------------------------------------------------------------------
;; (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;; ---------------------------------------------------------------------------------
;; (5) _interrupcoes                                         8     8      0     112
;;                                              0 COMMON     8     8      0
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 5
;; ---------------------------------------------------------------------------------

;; Call Graph Graphs:

;; _main (ROOT)
;;   ___awmod
;;     ___wmul (ARG)
;;   _desenhar_relogio_analogico
;;     ___wmul
;;     ___awmod
;;       ___wmul (ARG)
;;     ___bmul
;;       ___awmod (ARG)
;;         ___wmul (ARG)
;;       ___wmul (ARG)
;;   _desenhar_relogio_digital
;;     _desenhar_numero
;;       _ponto
;;         ___wmul
;;         ___awdiv
;;           ___wmul (ARG)
;;     _linha
;;       ___wmul
;;       ___awdiv
;;         ___wmul (ARG)
;;       _ponto
;;         ___wmul
;;         ___awdiv
;;           ___wmul (ARG)
;;   _tentar_mostrar_expoeletrica
;;     ___awmod
;;       ___wmul (ARG)
;;     _mostrar_caractere
;;       _ponto
;;         ___wmul
;;         ___awdiv
;;           ___wmul (ARG)
;;   _verificar_botoes
;;
;; _interrupcoes (ROOT)
;;

;; Address spaces:

;;Name               Size   Autos  Total    Cost      Usage
;;BITCOMMON            E      0       0       0        0.0%
;;EEDATA             100      0       0       0        0.0%
;;NULL                 0      0       0       0        0.0%
;;CODE                 0      0       0       0        0.0%
;;COMMON               E      8       E       1      100.0%
;;BITSFR0              0      0       0       1        0.0%
;;SFR0                 0      0       0       1        0.0%
;;BITSFR1              0      0       0       2        0.0%
;;SFR1                 0      0       0       2        0.0%
;;STACK                0      0       4       2        0.0%
;;ABS                  0      0     104       3        0.0%
;;BITBANK0            50      0       0       4        0.0%
;;BITSFR3              0      0       0       4        0.0%
;;SFR3                 0      0       0       4        0.0%
;;BANK0               50     3A      42       5       82.5%
;;BITSFR2              0      0       0       5        0.0%
;;SFR2                 0      0       0       5        0.0%
;;BITBANK1            50      0       0       6        0.0%
;;BANK1               50      0      3C       7       75.0%
;;BITBANK3            60      0       0       8        0.0%
;;BANK3               60      0      3C       9       62.5%
;;BITBANK2            60      0       0      10        0.0%
;;BANK2               60      0      3C      11       62.5%
;;DATA                 0      0     108      12        0.0%

	global	_main
psect	maintext,global,class=CODE,delta=2
global __pmaintext
__pmaintext:

;; *************** function _main *****************
;; Defined at:
;;		line 696 in file "C:\Users\Felipe\Desktop\GIRADOR+IR\girador-soft\girador.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, btemp+1, pclath, cstack
;; Tracked objects:
;;		On entry : 17F/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       2       0       0       0
;;      Totals:         0       2       0       0       0
;;Total ram usage:        2 bytes
;; Hardware stack levels required when called:    5
;; This function calls:
;;		___awmod
;;		_desenhar_relogio_analogico
;;		_desenhar_relogio_digital
;;		_tentar_mostrar_expoeletrica
;;		_verificar_botoes
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	maintext
	file	"C:\Users\Felipe\Desktop\GIRADOR+IR\girador-soft\girador.c"
	line	696
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:	
	opt	stack 3
; Regs used in _main: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
	line	697
	
l4804:	
;girador.c: 697: TRISA = 0;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	clrf	(133)^080h	;volatile
	line	698
;girador.c: 698: TRISE = 0;
	clrf	(137)^080h	;volatile
	line	699
;girador.c: 699: TRISD = 0;
	clrf	(136)^080h	;volatile
	line	700
	
l4806:	
;girador.c: 700: TRISC = 0b11101111;
	movlw	(0EFh)
	movwf	(135)^080h	;volatile
	line	701
	
l4808:	
;girador.c: 701: PORTD = 0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(8)	;volatile
	line	702
	
l4810:	
;girador.c: 702: PORTA = 0;
	clrf	(5)	;volatile
	line	703
	
l4812:	
;girador.c: 703: PORTE = 0;
	clrf	(9)	;volatile
	line	705
	
l4814:	
;girador.c: 705: mudar = 0;
	clrf	(_mudar)
	line	707
	
l4816:	
;girador.c: 707: sl=0;
	clrf	(_sl)
	line	708
	
l4818:	
;girador.c: 708: sh=0;
	clrf	(_sh)
	line	709
	
l4820:	
;girador.c: 709: ml=0;
	clrf	(_ml)
	line	710
	
l4822:	
;girador.c: 710: mh=0;
	clrf	(_mh)
	line	711
	
l4824:	
;girador.c: 711: hl=0;
	clrf	(_hl)
	line	712
	
l4826:	
;girador.c: 712: hh=0;
	clrf	(_hh)
	line	715
;girador.c: 715: OPTION_REG = 0b10000011;
	movlw	(083h)
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	(129)^080h	;volatile
	line	717
;girador.c: 717: INTCON = 0b11010000;
	movlw	(0D0h)
	movwf	(11)	;volatile
	line	718
;girador.c: 718: PIE1 = 0b00000001;
	movlw	(01h)
	movwf	(140)^080h	;volatile
	line	721
;girador.c: 721: TMR1H = 0b10000000;
	movlw	(080h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(15)	;volatile
	line	722
;girador.c: 722: T1CON = 0b00001111;
	movlw	(0Fh)
	movwf	(16)	;volatile
	line	724
	
l4828:	
;girador.c: 724: telaHF[15] = 1;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	clrf	0+(_telaHF)^080h+0Fh
	bsf	status,0
	rlf	0+(_telaHF)^080h+0Fh,f
	line	725
	
l4830:	
;girador.c: 725: telaHF[30] = 1;
	clrf	0+(_telaHF)^080h+01Eh
	bsf	status,0
	rlf	0+(_telaHF)^080h+01Eh,f
	line	726
	
l4832:	
;girador.c: 726: telaHF[45] = 1;
	clrf	0+(_telaHF)^080h+02Dh
	bsf	status,0
	rlf	0+(_telaHF)^080h+02Dh,f
	line	727
	
l4834:	
;girador.c: 727: telaHL[0] = 1;
	bcf	status, 5	;RP0=0, select bank2
	bsf	status, 6	;RP1=1, select bank2
	clrf	(_telaHL)^0100h
	bsf	status,0
	rlf	(_telaHL)^0100h,f
	line	728
	
l4836:	
;girador.c: 728: telaHL[15] = 1;
	clrf	0+(_telaHL)^0100h+0Fh
	bsf	status,0
	rlf	0+(_telaHL)^0100h+0Fh,f
	line	729
	
l4838:	
;girador.c: 729: telaHL[30] = 1;
	clrf	0+(_telaHL)^0100h+01Eh
	bsf	status,0
	rlf	0+(_telaHL)^0100h+01Eh,f
	line	730
	
l4840:	
;girador.c: 730: telaHL[45] = 1;
	clrf	0+(_telaHL)^0100h+02Dh
	bsf	status,0
	rlf	0+(_telaHL)^0100h+02Dh,f
	line	731
	
l4842:	
;girador.c: 731: telaHL[59] = 3;
	movlw	(03h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	bcf	status, 5	;RP0=0, select bank2
	bsf	status, 6	;RP1=1, select bank2
	movwf	0+(_telaHL)^0100h+03Bh
	line	732
	
l4844:	
;girador.c: 732: CALIBRACAO = 72;
	movlw	(048h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	movwf	(_CALIBRACAO)
	goto	l4846
	line	733
;girador.c: 733: while(1){
	
l929:	
	line	734
	
l4846:	
;girador.c: 734: if(mudar){
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(_mudar),w
	skipz
	goto	u5180
	goto	l930
u5180:
	line	735
	
l4848:	
;girador.c: 735: if (sh%3==0)desenhar_relogio_analogico();
	movlw	low(03h)
	movwf	(?___awmod)
	movlw	high(03h)
	movwf	((?___awmod))+1
	movf	(_sh),w
	movwf	(??_main+0)+0
	clrf	(??_main+0)+0+1
	movf	0+(??_main+0)+0,w
	movwf	0+(?___awmod)+02h
	movf	1+(??_main+0)+0,w
	movwf	1+(?___awmod)+02h
	fcall	___awmod
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	((1+(?___awmod))),w
	iorwf	((0+(?___awmod))),w
	skipz
	goto	u5191
	goto	u5190
u5191:
	goto	l4852
u5190:
	
l4850:	
	fcall	_desenhar_relogio_analogico
	goto	l4856
	line	736
	
l931:	
	
l4852:	
;girador.c: 736: else if(sh%3==1)desenhar_relogio_digital();
	movlw	low(03h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(?___awmod)
	movlw	high(03h)
	movwf	((?___awmod))+1
	movf	(_sh),w
	movwf	(??_main+0)+0
	clrf	(??_main+0)+0+1
	movf	0+(??_main+0)+0,w
	movwf	0+(?___awmod)+02h
	movf	1+(??_main+0)+0,w
	movwf	1+(?___awmod)+02h
	fcall	___awmod
	movlw	01h
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	xorwf	(0+(?___awmod)),w
	iorwf	(1+(?___awmod)),w
	skipz
	goto	u5201
	goto	u5200
u5201:
	goto	l4856
u5200:
	
l4854:	
	fcall	_desenhar_relogio_digital
	goto	l4856
	
l933:	
	goto	l4856
	line	737
	
l932:	
	
l4856:	
;girador.c: 737: mudar = 0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(_mudar)
	line	738
	
l930:	
	line	739
;girador.c: 738: }
;girador.c: 739: tentar_mostrar_expoeletrica();
	fcall	_tentar_mostrar_expoeletrica
	line	740
	
l4858:	
;girador.c: 740: verificar_botoes();
	fcall	_verificar_botoes
	goto	l4846
	line	741
	
l934:	
	line	733
	goto	l4846
	
l935:	
	line	742
	
l936:	
	global	start
	ljmp	start
	opt stack 0
GLOBAL	__end_of_main
	__end_of_main:
;; =============== function _main ends ============

	signat	_main,88
	global	_tentar_mostrar_expoeletrica
psect	text367,local,class=CODE,delta=2
global __ptext367
__ptext367:

;; *************** function _tentar_mostrar_expoeletrica *****************
;; Defined at:
;;		line 621 in file "C:\Users\Felipe\Desktop\GIRADOR+IR\girador-soft\girador.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  k               1   39[BANK0 ] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, btemp+1, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       1       0       0       0
;;      Temps:          0       2       0       0       0
;;      Totals:         0       3       0       0       0
;;Total ram usage:        3 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    4
;; This function calls:
;;		___awmod
;;		_mostrar_caractere
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text367
	file	"C:\Users\Felipe\Desktop\GIRADOR+IR\girador-soft\girador.c"
	line	621
	global	__size_of_tentar_mostrar_expoeletrica
	__size_of_tentar_mostrar_expoeletrica	equ	__end_of_tentar_mostrar_expoeletrica-_tentar_mostrar_expoeletrica
	
_tentar_mostrar_expoeletrica:	
	opt	stack 3
; Regs used in _tentar_mostrar_expoeletrica: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
	line	623
	
l4762:	
;girador.c: 622: char k;
;girador.c: 623: if(sh%3==2){
	movlw	low(03h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(?___awmod)
	movlw	high(03h)
	movwf	((?___awmod))+1
	movf	(_sh),w
	movwf	(??_tentar_mostrar_expoeletrica+0)+0
	clrf	(??_tentar_mostrar_expoeletrica+0)+0+1
	movf	0+(??_tentar_mostrar_expoeletrica+0)+0,w
	movwf	0+(?___awmod)+02h
	movf	1+(??_tentar_mostrar_expoeletrica+0)+0,w
	movwf	1+(?___awmod)+02h
	fcall	___awmod
	movlw	02h
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	xorwf	(0+(?___awmod)),w
	iorwf	(1+(?___awmod)),w
	skipz
	goto	u5111
	goto	u5110
u5111:
	goto	l905
u5110:
	line	624
	
l4764:	
;girador.c: 624: if(ultima!=(TMR1H&0b01111111)>>4){
	movf	(15),w
	movwf	(??_tentar_mostrar_expoeletrica+0)+0
	movlw	04h
u5125:
	clrc
	rrf	(??_tentar_mostrar_expoeletrica+0)+0,f
	addlw	-1
	skipz
	goto	u5125
	movf	0+(??_tentar_mostrar_expoeletrica+0)+0,w
	andlw	07h
	xorwf	(_ultima),w
	skipnz
	goto	u5131
	goto	u5130
u5131:
	goto	l905
u5130:
	line	625
	
l4766:	
;girador.c: 625: ultima = (TMR1H&0b01111111)>>4;
	movf	(15),w
	movwf	(??_tentar_mostrar_expoeletrica+0)+0
	movlw	04h
u5145:
	clrc
	rrf	(??_tentar_mostrar_expoeletrica+0)+0,f
	addlw	-1
	skipz
	goto	u5145
	movf	0+(??_tentar_mostrar_expoeletrica+0)+0,w
	andlw	07h
	movwf	(??_tentar_mostrar_expoeletrica+1)+0
	movf	(??_tentar_mostrar_expoeletrica+1)+0,w
	movwf	(_ultima)
	line	627
	
l4768:	
;girador.c: 627: for(k=0;k<60;k++){
	clrf	(tentar_mostrar_expoeletrica@k)
	
l4770:	
	movlw	(03Ch)
	subwf	(tentar_mostrar_expoeletrica@k),w
	skipc
	goto	u5151
	goto	u5150
u5151:
	goto	l4774
u5150:
	goto	l4780
	
l4772:	
	goto	l4780
	
l903:	
	line	628
	
l4774:	
;girador.c: 628: telaL[k]=telaHL[k]=telaHF[k]=0;
	movf	(tentar_mostrar_expoeletrica@k),w
	addlw	_telaHF&0ffh
	movwf	fsr0
	movlw	(0)
	bcf	status, 7	;select IRP bank1
	movwf	indf
	movwf	(??_tentar_mostrar_expoeletrica+0)+0
	movf	(tentar_mostrar_expoeletrica@k),w
	addlw	_telaHL&0ffh
	movwf	fsr0
	movf	(??_tentar_mostrar_expoeletrica+0)+0,w
	bsf	status, 7	;select IRP bank2
	movwf	indf
	movf	(indf),w
	movwf	(??_tentar_mostrar_expoeletrica+1)+0
	movf	(tentar_mostrar_expoeletrica@k),w
	addlw	_telaL&0ffh
	movwf	fsr0
	movf	(??_tentar_mostrar_expoeletrica+1)+0,w
	movwf	indf
	line	627
	
l4776:	
	movlw	(01h)
	movwf	(??_tentar_mostrar_expoeletrica+0)+0
	movf	(??_tentar_mostrar_expoeletrica+0)+0,w
	addwf	(tentar_mostrar_expoeletrica@k),f
	
l4778:	
	movlw	(03Ch)
	subwf	(tentar_mostrar_expoeletrica@k),w
	skipc
	goto	u5161
	goto	u5160
u5161:
	goto	l4774
u5160:
	goto	l4780
	
l904:	
	line	630
	
l4780:	
;girador.c: 629: }
;girador.c: 630: k = sl<<3|ultima;
	movf	(_sl),w
	movwf	(??_tentar_mostrar_expoeletrica+0)+0
	movlw	(03h)-1
u5175:
	clrc
	rlf	(??_tentar_mostrar_expoeletrica+0)+0,f
	addlw	-1
	skipz
	goto	u5175
	clrc
	rlf	(??_tentar_mostrar_expoeletrica+0)+0,w
	iorwf	(_ultima),w
	movwf	(??_tentar_mostrar_expoeletrica+1)+0
	movf	(??_tentar_mostrar_expoeletrica+1)+0,w
	movwf	(tentar_mostrar_expoeletrica@k)
	line	632
	
l4782:	
;girador.c: 632: mostrar_caractere(-k,'p');
	movlw	(070h)
	movwf	(??_tentar_mostrar_expoeletrica+0)+0
	movf	(??_tentar_mostrar_expoeletrica+0)+0,w
	movwf	(?_mostrar_caractere)
	decf	(tentar_mostrar_expoeletrica@k),w
	xorlw	0ffh
	fcall	_mostrar_caractere
	line	633
	
l4784:	
;girador.c: 633: mostrar_caractere(5-k,'e');
	movlw	(065h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_tentar_mostrar_expoeletrica+0)+0
	movf	(??_tentar_mostrar_expoeletrica+0)+0,w
	movwf	(?_mostrar_caractere)
	decf	(tentar_mostrar_expoeletrica@k),w
	xorlw	0ffh
	addlw	05h
	fcall	_mostrar_caractere
	line	634
	
l4786:	
;girador.c: 634: mostrar_caractere(10-k,'t');
	movlw	(074h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_tentar_mostrar_expoeletrica+0)+0
	movf	(??_tentar_mostrar_expoeletrica+0)+0,w
	movwf	(?_mostrar_caractere)
	decf	(tentar_mostrar_expoeletrica@k),w
	xorlw	0ffh
	addlw	0Ah
	fcall	_mostrar_caractere
	line	635
	
l4788:	
;girador.c: 635: mostrar_caractere(28-k,'e');
	movlw	(065h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_tentar_mostrar_expoeletrica+0)+0
	movf	(??_tentar_mostrar_expoeletrica+0)+0,w
	movwf	(?_mostrar_caractere)
	decf	(tentar_mostrar_expoeletrica@k),w
	xorlw	0ffh
	addlw	01Ch
	fcall	_mostrar_caractere
	line	636
	
l4790:	
;girador.c: 636: mostrar_caractere(33-k,'l');
	movlw	(06Ch)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_tentar_mostrar_expoeletrica+0)+0
	movf	(??_tentar_mostrar_expoeletrica+0)+0,w
	movwf	(?_mostrar_caractere)
	decf	(tentar_mostrar_expoeletrica@k),w
	xorlw	0ffh
	addlw	021h
	fcall	_mostrar_caractere
	line	637
	
l4792:	
;girador.c: 637: mostrar_caractere(38-k,'e');
	movlw	(065h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_tentar_mostrar_expoeletrica+0)+0
	movf	(??_tentar_mostrar_expoeletrica+0)+0,w
	movwf	(?_mostrar_caractere)
	decf	(tentar_mostrar_expoeletrica@k),w
	xorlw	0ffh
	addlw	026h
	fcall	_mostrar_caractere
	line	638
	
l4794:	
;girador.c: 638: mostrar_caractere(43-k,'t');
	movlw	(074h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_tentar_mostrar_expoeletrica+0)+0
	movf	(??_tentar_mostrar_expoeletrica+0)+0,w
	movwf	(?_mostrar_caractere)
	decf	(tentar_mostrar_expoeletrica@k),w
	xorlw	0ffh
	addlw	02Bh
	fcall	_mostrar_caractere
	line	639
	
l4796:	
;girador.c: 639: mostrar_caractere(49-k,'r');
	movlw	(072h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_tentar_mostrar_expoeletrica+0)+0
	movf	(??_tentar_mostrar_expoeletrica+0)+0,w
	movwf	(?_mostrar_caractere)
	decf	(tentar_mostrar_expoeletrica@k),w
	xorlw	0ffh
	addlw	031h
	fcall	_mostrar_caractere
	line	640
	
l4798:	
;girador.c: 640: mostrar_caractere(54-k,'i');
	movlw	(069h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_tentar_mostrar_expoeletrica+0)+0
	movf	(??_tentar_mostrar_expoeletrica+0)+0,w
	movwf	(?_mostrar_caractere)
	decf	(tentar_mostrar_expoeletrica@k),w
	xorlw	0ffh
	addlw	036h
	fcall	_mostrar_caractere
	line	641
	
l4800:	
;girador.c: 641: mostrar_caractere(59-k,'c');
	movlw	(063h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_tentar_mostrar_expoeletrica+0)+0
	movf	(??_tentar_mostrar_expoeletrica+0)+0,w
	movwf	(?_mostrar_caractere)
	decf	(tentar_mostrar_expoeletrica@k),w
	xorlw	0ffh
	addlw	03Bh
	fcall	_mostrar_caractere
	line	642
	
l4802:	
;girador.c: 642: mostrar_caractere(64-k,'a');
	movlw	(061h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_tentar_mostrar_expoeletrica+0)+0
	movf	(??_tentar_mostrar_expoeletrica+0)+0,w
	movwf	(?_mostrar_caractere)
	decf	(tentar_mostrar_expoeletrica@k),w
	xorlw	0ffh
	addlw	040h
	fcall	_mostrar_caractere
	goto	l905
	line	643
	
l902:	
	goto	l905
	line	644
	
l901:	
	line	645
	
l905:	
	return
	opt stack 0
GLOBAL	__end_of_tentar_mostrar_expoeletrica
	__end_of_tentar_mostrar_expoeletrica:
;; =============== function _tentar_mostrar_expoeletrica ends ============

	signat	_tentar_mostrar_expoeletrica,88
	global	_desenhar_relogio_digital
psect	text368,local,class=CODE,delta=2
global __ptext368
__ptext368:

;; *************** function _desenhar_relogio_digital *****************
;; Defined at:
;;		line 340 in file "C:\Users\Felipe\Desktop\GIRADOR+IR\girador-soft\girador.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  buffer          1   55[BANK0 ] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, btemp+1, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       1       0       0       0
;;      Temps:          0       3       0       0       0
;;      Totals:         0       4       0       0       0
;;Total ram usage:        4 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    4
;; This function calls:
;;		_desenhar_numero
;;		_linha
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text368
	file	"C:\Users\Felipe\Desktop\GIRADOR+IR\girador-soft\girador.c"
	line	340
	global	__size_of_desenhar_relogio_digital
	__size_of_desenhar_relogio_digital	equ	__end_of_desenhar_relogio_digital-_desenhar_relogio_digital
	
_desenhar_relogio_digital:	
	opt	stack 3
; Regs used in _desenhar_relogio_digital: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
	line	341
	
l4736:	
;girador.c: 341: for(char buffer=0;buffer<60;buffer++){
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(desenhar_relogio_digital@buffer)
	
l4738:	
	movlw	(03Ch)
	subwf	(desenhar_relogio_digital@buffer),w
	skipc
	goto	u5081
	goto	u5080
u5081:
	goto	l4742
u5080:
	goto	l4748
	
l4740:	
	goto	l4748
	
l869:	
	line	342
	
l4742:	
;girador.c: 342: telaHF[buffer]=telaHL[buffer]=telaL[buffer]=0;
	movf	(desenhar_relogio_digital@buffer),w
	addlw	_telaL&0ffh
	movwf	fsr0
	movlw	(0)
	bsf	status, 7	;select IRP bank3
	movwf	indf
	movwf	(??_desenhar_relogio_digital+0)+0
	movf	(desenhar_relogio_digital@buffer),w
	addlw	_telaHL&0ffh
	movwf	fsr0
	movf	(??_desenhar_relogio_digital+0)+0,w
	movwf	indf
	movf	(indf),w
	movwf	(??_desenhar_relogio_digital+1)+0
	movf	(desenhar_relogio_digital@buffer),w
	addlw	_telaHF&0ffh
	movwf	fsr0
	movf	(??_desenhar_relogio_digital+1)+0,w
	bcf	status, 7	;select IRP bank1
	movwf	indf
	line	341
	
l4744:	
	movlw	(01h)
	movwf	(??_desenhar_relogio_digital+0)+0
	movf	(??_desenhar_relogio_digital+0)+0,w
	addwf	(desenhar_relogio_digital@buffer),f
	
l4746:	
	movlw	(03Ch)
	subwf	(desenhar_relogio_digital@buffer),w
	skipc
	goto	u5091
	goto	u5090
u5091:
	goto	l4742
u5090:
	goto	l4748
	
l870:	
	line	344
	
l4748:	
;girador.c: 343: }
;girador.c: 344: desenhar_numero(sl,1,-1);
	clrf	(?_desenhar_numero)
	bsf	status,0
	rlf	(?_desenhar_numero),f
	movlw	(0FFh)
	movwf	(??_desenhar_relogio_digital+0)+0
	movf	(??_desenhar_relogio_digital+0)+0,w
	movwf	0+(?_desenhar_numero)+01h
	movf	(_sl),w
	fcall	_desenhar_numero
	line	345
;girador.c: 345: desenhar_numero(sh,-6,-1);
	movlw	(0FAh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_desenhar_relogio_digital+0)+0
	movf	(??_desenhar_relogio_digital+0)+0,w
	movwf	(?_desenhar_numero)
	movlw	(0FFh)
	movwf	(??_desenhar_relogio_digital+1)+0
	movf	(??_desenhar_relogio_digital+1)+0,w
	movwf	0+(?_desenhar_numero)+01h
	movf	(_sh),w
	fcall	_desenhar_numero
	line	346
;girador.c: 346: desenhar_numero(ml,7,8);
	movlw	(07h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_desenhar_relogio_digital+0)+0
	movf	(??_desenhar_relogio_digital+0)+0,w
	movwf	(?_desenhar_numero)
	movlw	(08h)
	movwf	(??_desenhar_relogio_digital+1)+0
	movf	(??_desenhar_relogio_digital+1)+0,w
	movwf	0+(?_desenhar_numero)+01h
	movf	(_ml),w
	fcall	_desenhar_numero
	line	347
;girador.c: 347: desenhar_numero(mh,1,8);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(?_desenhar_numero)
	bsf	status,0
	rlf	(?_desenhar_numero),f
	movlw	(08h)
	movwf	(??_desenhar_relogio_digital+0)+0
	movf	(??_desenhar_relogio_digital+0)+0,w
	movwf	0+(?_desenhar_numero)+01h
	movf	(_mh),w
	fcall	_desenhar_numero
	line	348
;girador.c: 348: desenhar_numero(hl,-6,8);
	movlw	(0FAh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_desenhar_relogio_digital+0)+0
	movf	(??_desenhar_relogio_digital+0)+0,w
	movwf	(?_desenhar_numero)
	movlw	(08h)
	movwf	(??_desenhar_relogio_digital+1)+0
	movf	(??_desenhar_relogio_digital+1)+0,w
	movwf	0+(?_desenhar_numero)+01h
	movf	(_hl),w
	fcall	_desenhar_numero
	line	349
;girador.c: 349: desenhar_numero(hh,-12,8);
	movlw	(0F4h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_desenhar_relogio_digital+0)+0
	movf	(??_desenhar_relogio_digital+0)+0,w
	movwf	(?_desenhar_numero)
	movlw	(08h)
	movwf	(??_desenhar_relogio_digital+1)+0
	movf	(??_desenhar_relogio_digital+1)+0,w
	movwf	0+(?_desenhar_numero)+01h
	movf	(_hh),w
	fcall	_desenhar_numero
	line	350
	
l4750:	
;girador.c: 350: if(sl%2==0){
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	btfsc	(_sl),(0)&7
	goto	u5101
	goto	u5100
u5101:
	goto	l4754
u5100:
	line	351
	
l4752:	
;girador.c: 351: telaL[15] = 0b00010001;
	movlw	(011h)
	movwf	(??_desenhar_relogio_digital+0)+0
	movf	(??_desenhar_relogio_digital+0)+0,w
	bsf	status, 5	;RP0=1, select bank3
	bsf	status, 6	;RP1=1, select bank3
	movwf	0+(_telaL)^0180h+0Fh
	goto	l4754
	line	352
	
l871:	
	line	353
	
l4754:	
;girador.c: 352: }
;girador.c: 353: linha(-14,10,29,0,29,1);
	movlw	(0Ah)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_desenhar_relogio_digital+0)+0
	movf	(??_desenhar_relogio_digital+0)+0,w
	movwf	(?_linha)
	movlw	(01Dh)
	movwf	(??_desenhar_relogio_digital+1)+0
	movf	(??_desenhar_relogio_digital+1)+0,w
	movwf	0+(?_linha)+01h
	clrf	0+(?_linha)+02h
	movlw	(01Dh)
	movwf	(??_desenhar_relogio_digital+2)+0
	movf	(??_desenhar_relogio_digital+2)+0,w
	movwf	0+(?_linha)+03h
	clrf	0+(?_linha)+04h
	bsf	status,0
	rlf	0+(?_linha)+04h,f
	movlw	(0F2h)
	fcall	_linha
	line	354
	
l4756:	
;girador.c: 354: linha(-14,-10,29,0,29,1);
	movlw	(0F6h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_desenhar_relogio_digital+0)+0
	movf	(??_desenhar_relogio_digital+0)+0,w
	movwf	(?_linha)
	movlw	(01Dh)
	movwf	(??_desenhar_relogio_digital+1)+0
	movf	(??_desenhar_relogio_digital+1)+0,w
	movwf	0+(?_linha)+01h
	clrf	0+(?_linha)+02h
	movlw	(01Dh)
	movwf	(??_desenhar_relogio_digital+2)+0
	movf	(??_desenhar_relogio_digital+2)+0,w
	movwf	0+(?_linha)+03h
	clrf	0+(?_linha)+04h
	bsf	status,0
	rlf	0+(?_linha)+04h,f
	movlw	(0F2h)
	fcall	_linha
	line	355
	
l4758:	
;girador.c: 355: linha(14,-10,0,21,21,1);
	movlw	(0F6h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_desenhar_relogio_digital+0)+0
	movf	(??_desenhar_relogio_digital+0)+0,w
	movwf	(?_linha)
	clrf	0+(?_linha)+01h
	movlw	(015h)
	movwf	(??_desenhar_relogio_digital+1)+0
	movf	(??_desenhar_relogio_digital+1)+0,w
	movwf	0+(?_linha)+02h
	movlw	(015h)
	movwf	(??_desenhar_relogio_digital+2)+0
	movf	(??_desenhar_relogio_digital+2)+0,w
	movwf	0+(?_linha)+03h
	clrf	0+(?_linha)+04h
	bsf	status,0
	rlf	0+(?_linha)+04h,f
	movlw	(0Eh)
	fcall	_linha
	line	356
	
l4760:	
;girador.c: 356: linha(-14,-10,0,21,21,1);
	movlw	(0F6h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_desenhar_relogio_digital+0)+0
	movf	(??_desenhar_relogio_digital+0)+0,w
	movwf	(?_linha)
	clrf	0+(?_linha)+01h
	movlw	(015h)
	movwf	(??_desenhar_relogio_digital+1)+0
	movf	(??_desenhar_relogio_digital+1)+0,w
	movwf	0+(?_linha)+02h
	movlw	(015h)
	movwf	(??_desenhar_relogio_digital+2)+0
	movf	(??_desenhar_relogio_digital+2)+0,w
	movwf	0+(?_linha)+03h
	clrf	0+(?_linha)+04h
	bsf	status,0
	rlf	0+(?_linha)+04h,f
	movlw	(0F2h)
	fcall	_linha
	line	357
	
l872:	
	return
	opt stack 0
GLOBAL	__end_of_desenhar_relogio_digital
	__end_of_desenhar_relogio_digital:
;; =============== function _desenhar_relogio_digital ends ============

	signat	_desenhar_relogio_digital,88
	global	_mostrar_caractere
psect	text369,local,class=CODE,delta=2
global __ptext369
__ptext369:

;; *************** function _mostrar_caractere *****************
;; Defined at:
;;		line 499 in file "C:\Users\Felipe\Desktop\GIRADOR+IR\girador-soft\girador.c"
;; Parameters:    Size  Location     Type
;;  posx            1    wreg     unsigned char 
;;  letra           1   34[BANK0 ] unsigned char 
;; Auto vars:     Size  Location     Type
;;  posx            1   36[BANK0 ] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, btemp+1, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       1       0       0       0
;;      Locals:         0       1       0       0       0
;;      Temps:          0       1       0       0       0
;;      Totals:         0       3       0       0       0
;;Total ram usage:        3 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		_ponto
;; This function is called by:
;;		_tentar_mostrar_expoeletrica
;; This function uses a non-reentrant model
;;
psect	text369
	file	"C:\Users\Felipe\Desktop\GIRADOR+IR\girador-soft\girador.c"
	line	499
	global	__size_of_mostrar_caractere
	__size_of_mostrar_caractere	equ	__end_of_mostrar_caractere-_mostrar_caractere
	
_mostrar_caractere:	
	opt	stack 3
; Regs used in _mostrar_caractere: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
;mostrar_caractere@posx stored from wreg
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(mostrar_caractere@posx)
	line	500
	
l4714:	
;girador.c: 500: switch(letra){
	goto	l4734
	line	501
;girador.c: 501: case 'p':
	
l889:	
	line	502
	
l4716:	
;girador.c: 502: ponto(posx,3,1);
	movlw	(03h)
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	503
;girador.c: 503: ponto(posx,2,1);
	movlw	(02h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	504
;girador.c: 504: ponto(posx,1,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(?_ponto)
	bsf	status,0
	rlf	(?_ponto),f
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	505
;girador.c: 505: ponto(posx,0,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	506
;girador.c: 506: ponto(posx,-1,1);
	movlw	(0FFh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	507
;girador.c: 507: ponto(posx,-2,1);
	movlw	(0FEh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	508
;girador.c: 508: ponto(posx,-3,1);
	movlw	(0FDh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	509
;girador.c: 509: ponto(posx+1,3,1);
	movlw	(03h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	01h
	fcall	_ponto
	line	510
;girador.c: 510: ponto(posx+1,0,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	01h
	fcall	_ponto
	line	511
;girador.c: 511: ponto(posx+2,3,1);
	movlw	(03h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	02h
	fcall	_ponto
	line	512
;girador.c: 512: ponto(posx+2,0,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	02h
	fcall	_ponto
	line	513
;girador.c: 513: ponto(posx+3,3,1);
	movlw	(03h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	03h
	fcall	_ponto
	line	514
;girador.c: 514: ponto(posx+3,2,1);
	movlw	(02h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	03h
	fcall	_ponto
	line	515
;girador.c: 515: ponto(posx+3,1,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(?_ponto)
	bsf	status,0
	rlf	(?_ponto),f
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	03h
	fcall	_ponto
	line	516
;girador.c: 516: ponto(posx+3,0,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	03h
	fcall	_ponto
	line	517
;girador.c: 517: break;
	goto	l898
	line	518
;girador.c: 518: case 'e':
	
l891:	
	line	519
	
l4718:	
;girador.c: 519: ponto(posx,3,1);
	movlw	(03h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	520
;girador.c: 520: ponto(posx,2,1);
	movlw	(02h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	521
;girador.c: 521: ponto(posx,1,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(?_ponto)
	bsf	status,0
	rlf	(?_ponto),f
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	522
;girador.c: 522: ponto(posx,0,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	523
;girador.c: 523: ponto(posx,-1,1);
	movlw	(0FFh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	524
;girador.c: 524: ponto(posx,-2,1);
	movlw	(0FEh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	525
;girador.c: 525: ponto(posx,-3,1);
	movlw	(0FDh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	526
;girador.c: 526: ponto(posx+1,3,1);
	movlw	(03h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	01h
	fcall	_ponto
	line	527
;girador.c: 527: ponto(posx+1,0,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	01h
	fcall	_ponto
	line	528
;girador.c: 528: ponto(posx+1,-3,1);
	movlw	(0FDh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	01h
	fcall	_ponto
	line	529
;girador.c: 529: ponto(posx+2,3,1);
	movlw	(03h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	02h
	fcall	_ponto
	line	530
;girador.c: 530: ponto(posx+2,0,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	02h
	fcall	_ponto
	line	531
;girador.c: 531: ponto(posx+2,-3,1);
	movlw	(0FDh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	02h
	fcall	_ponto
	line	532
;girador.c: 532: ponto(posx+3,3,1);
	movlw	(03h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	03h
	fcall	_ponto
	line	533
;girador.c: 533: ponto(posx+3,0,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	03h
	fcall	_ponto
	line	534
;girador.c: 534: ponto(posx+3,-3,1);
	movlw	(0FDh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	03h
	fcall	_ponto
	line	535
;girador.c: 535: break;
	goto	l898
	line	536
;girador.c: 536: case 't':
	
l892:	
	line	537
	
l4720:	
;girador.c: 537: ponto(posx,3,1);
	movlw	(03h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	538
;girador.c: 538: ponto(posx+1,3,1);
	movlw	(03h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	01h
	fcall	_ponto
	line	539
;girador.c: 539: ponto(posx+2,3,1);
	movlw	(03h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	02h
	fcall	_ponto
	line	540
;girador.c: 540: ponto(posx+2,2,1);
	movlw	(02h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	02h
	fcall	_ponto
	line	541
;girador.c: 541: ponto(posx+2,1,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(?_ponto)
	bsf	status,0
	rlf	(?_ponto),f
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	02h
	fcall	_ponto
	line	542
;girador.c: 542: ponto(posx+2,0,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	02h
	fcall	_ponto
	line	543
;girador.c: 543: ponto(posx+2,-1,1);
	movlw	(0FFh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	02h
	fcall	_ponto
	line	544
;girador.c: 544: ponto(posx+2,-2,1);
	movlw	(0FEh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	02h
	fcall	_ponto
	line	545
;girador.c: 545: ponto(posx+2,-3,1);
	movlw	(0FDh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	02h
	fcall	_ponto
	line	546
;girador.c: 546: ponto(posx+3,3,1);
	movlw	(03h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	03h
	fcall	_ponto
	line	547
;girador.c: 547: ponto(posx+4,3,1);
	movlw	(03h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	04h
	fcall	_ponto
	line	548
;girador.c: 548: break;
	goto	l898
	line	549
;girador.c: 549: case 'l':
	
l893:	
	line	550
	
l4722:	
;girador.c: 550: ponto(posx,3,1);
	movlw	(03h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	551
;girador.c: 551: ponto(posx,2,1);
	movlw	(02h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	552
;girador.c: 552: ponto(posx,1,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(?_ponto)
	bsf	status,0
	rlf	(?_ponto),f
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	553
;girador.c: 553: ponto(posx,0,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	554
;girador.c: 554: ponto(posx,-1,1);
	movlw	(0FFh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	555
;girador.c: 555: ponto(posx,-2,1);
	movlw	(0FEh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	556
;girador.c: 556: ponto(posx,-3,1);
	movlw	(0FDh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	557
;girador.c: 557: ponto(posx+1,-3,1);
	movlw	(0FDh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	01h
	fcall	_ponto
	line	558
;girador.c: 558: ponto(posx+2,-3,1);
	movlw	(0FDh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	02h
	fcall	_ponto
	line	559
;girador.c: 559: ponto(posx+3,-3,1);
	movlw	(0FDh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	03h
	fcall	_ponto
	line	560
;girador.c: 560: break;
	goto	l898
	line	561
;girador.c: 561: case 'a':
	
l894:	
	line	562
	
l4724:	
;girador.c: 562: ponto(posx,-3,1);
	movlw	(0FDh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	563
;girador.c: 563: ponto(posx,-2,1);
	movlw	(0FEh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	564
;girador.c: 564: ponto(posx+1,-1,1);
	movlw	(0FFh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	01h
	fcall	_ponto
	line	565
;girador.c: 565: ponto(posx+1,0,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	01h
	fcall	_ponto
	line	566
;girador.c: 566: ponto(posx+1,1,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(?_ponto)
	bsf	status,0
	rlf	(?_ponto),f
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	01h
	fcall	_ponto
	line	567
;girador.c: 567: ponto(posx+2,2,1);
	movlw	(02h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	02h
	fcall	_ponto
	line	568
;girador.c: 568: ponto(posx+2,3,1);
	movlw	(03h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	02h
	fcall	_ponto
	line	569
;girador.c: 569: ponto(posx+4,-3,1);
	movlw	(0FDh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	04h
	fcall	_ponto
	line	570
;girador.c: 570: ponto(posx+4,-2,1);
	movlw	(0FEh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	04h
	fcall	_ponto
	line	571
;girador.c: 571: ponto(posx+3,-1,1);
	movlw	(0FFh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	03h
	fcall	_ponto
	line	572
;girador.c: 572: ponto(posx+3,0,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	03h
	fcall	_ponto
	line	573
;girador.c: 573: ponto(posx+3,1,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(?_ponto)
	bsf	status,0
	rlf	(?_ponto),f
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	03h
	fcall	_ponto
	line	574
;girador.c: 574: ponto(posx+2,2,1);
	movlw	(02h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	02h
	fcall	_ponto
	line	575
;girador.c: 575: ponto(posx+2,3,1);
	movlw	(03h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	02h
	fcall	_ponto
	line	576
;girador.c: 576: ponto(posx+2,0,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	02h
	fcall	_ponto
	line	577
;girador.c: 577: break;
	goto	l898
	line	578
;girador.c: 578: case 'c':
	
l895:	
	line	579
	
l4726:	
;girador.c: 579: ponto(posx,-2,1);
	movlw	(0FEh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	580
;girador.c: 580: ponto(posx,-1,1);
	movlw	(0FFh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	581
;girador.c: 581: ponto(posx,-0,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	582
;girador.c: 582: ponto(posx,1,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(?_ponto)
	bsf	status,0
	rlf	(?_ponto),f
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	583
;girador.c: 583: ponto(posx,2,1);
	movlw	(02h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	584
;girador.c: 584: ponto(posx+1,3,1);
	movlw	(03h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	01h
	fcall	_ponto
	line	585
;girador.c: 585: ponto(posx+1,-3,1);
	movlw	(0FDh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	01h
	fcall	_ponto
	line	586
;girador.c: 586: ponto(posx+2,3,1);
	movlw	(03h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	02h
	fcall	_ponto
	line	587
;girador.c: 587: ponto(posx+2,-3,1);
	movlw	(0FDh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	02h
	fcall	_ponto
	line	588
;girador.c: 588: ponto(posx+3,3,1);
	movlw	(03h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	03h
	fcall	_ponto
	line	589
;girador.c: 589: ponto(posx+4,-3,1);
	movlw	(0FDh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	04h
	fcall	_ponto
	line	590
;girador.c: 590: break;
	goto	l898
	line	591
;girador.c: 591: case 'i':
	
l896:	
	line	592
	
l4728:	
;girador.c: 592: ponto(posx+2,-3,1);
	movlw	(0FDh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	02h
	fcall	_ponto
	line	593
;girador.c: 593: ponto(posx+2,-2,1);
	movlw	(0FEh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	02h
	fcall	_ponto
	line	594
;girador.c: 594: ponto(posx+2,-1,1);
	movlw	(0FFh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	02h
	fcall	_ponto
	line	595
;girador.c: 595: ponto(posx+2,-0,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	02h
	fcall	_ponto
	line	596
;girador.c: 596: ponto(posx+2,1,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(?_ponto)
	bsf	status,0
	rlf	(?_ponto),f
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	02h
	fcall	_ponto
	line	597
;girador.c: 597: ponto(posx+2,3,1);
	movlw	(03h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	02h
	fcall	_ponto
	line	598
;girador.c: 598: break;
	goto	l898
	line	599
;girador.c: 599: case 'r':
	
l897:	
	line	600
	
l4730:	
;girador.c: 600: ponto(posx,-3,1);
	movlw	(0FDh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	601
;girador.c: 601: ponto(posx,-2,1);
	movlw	(0FEh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	602
;girador.c: 602: ponto(posx,-1,1);
	movlw	(0FFh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	603
;girador.c: 603: ponto(posx,-0,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	604
;girador.c: 604: ponto(posx,1,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(?_ponto)
	bsf	status,0
	rlf	(?_ponto),f
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	605
;girador.c: 605: ponto(posx,2,1);
	movlw	(02h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	606
;girador.c: 606: ponto(posx,3,1);
	movlw	(03h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	fcall	_ponto
	line	607
;girador.c: 607: ponto(posx+1,3,1);
	movlw	(03h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	01h
	fcall	_ponto
	line	608
;girador.c: 608: ponto(posx+1,0,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	01h
	fcall	_ponto
	line	609
;girador.c: 609: ponto(posx+1,-1,1);
	movlw	(0FFh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	01h
	fcall	_ponto
	line	610
;girador.c: 610: ponto(posx+2,3,1);
	movlw	(03h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	02h
	fcall	_ponto
	line	611
;girador.c: 611: ponto(posx+2,0,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	02h
	fcall	_ponto
	line	612
;girador.c: 612: ponto(posx+2,-2,1);
	movlw	(0FEh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	02h
	fcall	_ponto
	line	613
;girador.c: 613: ponto(posx+3,2,1);
	movlw	(02h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	03h
	fcall	_ponto
	line	614
;girador.c: 614: ponto(posx+3,1,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(?_ponto)
	bsf	status,0
	rlf	(?_ponto),f
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	03h
	fcall	_ponto
	line	615
;girador.c: 615: ponto(posx+3,-3,1);
	movlw	(0FDh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_mostrar_caractere+0)+0
	movf	(??_mostrar_caractere+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(mostrar_caractere@posx),w
	addlw	03h
	fcall	_ponto
	line	616
;girador.c: 616: break;
	goto	l898
	line	618
	
l4732:	
;girador.c: 618: }
	goto	l898
	line	500
	
l888:	
	
l4734:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(mostrar_caractere@letra),w
	; Switch size 1, requested type "space"
; Number of cases is 8, Range of values is 97 to 116
; switch strategies available:
; Name         Instructions Cycles
; simple_byte           25    13 (average)
; direct_byte           71    11 (fixed)
; jumptable            263     9 (fixed)
;	Chosen strategy is simple_byte

	opt asmopt_off
	xorlw	97^0	; case 97
	skipnz
	goto	l4724
	xorlw	99^97	; case 99
	skipnz
	goto	l4726
	xorlw	101^99	; case 101
	skipnz
	goto	l4718
	xorlw	105^101	; case 105
	skipnz
	goto	l4728
	xorlw	108^105	; case 108
	skipnz
	goto	l4722
	xorlw	112^108	; case 112
	skipnz
	goto	l4716
	xorlw	114^112	; case 114
	skipnz
	goto	l4730
	xorlw	116^114	; case 116
	skipnz
	goto	l4720
	goto	l898
	opt asmopt_on

	line	618
	
l890:	
	line	619
	
l898:	
	return
	opt stack 0
GLOBAL	__end_of_mostrar_caractere
	__end_of_mostrar_caractere:
;; =============== function _mostrar_caractere ends ============

	signat	_mostrar_caractere,8312
	global	_desenhar_numero
psect	text370,local,class=CODE,delta=2
global __ptext370
__ptext370:

;; *************** function _desenhar_numero *****************
;; Defined at:
;;		line 128 in file "C:\Users\Felipe\Desktop\GIRADOR+IR\girador-soft\girador.c"
;; Parameters:    Size  Location     Type
;;  num             1    wreg     unsigned char 
;;  x               1   34[BANK0 ] unsigned char 
;;  y               1   35[BANK0 ] unsigned char 
;; Auto vars:     Size  Location     Type
;;  num             1   37[BANK0 ] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, btemp+1, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       2       0       0       0
;;      Locals:         0       1       0       0       0
;;      Temps:          0       1       0       0       0
;;      Totals:         0       4       0       0       0
;;Total ram usage:        4 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		_ponto
;; This function is called by:
;;		_desenhar_relogio_digital
;; This function uses a non-reentrant model
;;
psect	text370
	file	"C:\Users\Felipe\Desktop\GIRADOR+IR\girador-soft\girador.c"
	line	128
	global	__size_of_desenhar_numero
	__size_of_desenhar_numero	equ	__end_of_desenhar_numero-_desenhar_numero
	
_desenhar_numero:	
	opt	stack 3
; Regs used in _desenhar_numero: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
;desenhar_numero@num stored from wreg
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(desenhar_numero@num)
	line	166
	
l4690:	
;girador.c: 166: switch(num){
	goto	l4712
	line	167
;girador.c: 167: case 0:
	
l855:	
	line	168
	
l4692:	
;girador.c: 168: ponto(x,y-1,1);
	movf	(desenhar_numero@y),w
	addlw	0FFh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	fcall	_ponto
	line	169
;girador.c: 169: ponto(x,y-2,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FEh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	fcall	_ponto
	line	170
;girador.c: 170: ponto(x,y-3,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FDh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	fcall	_ponto
	line	171
;girador.c: 171: ponto(x,y-4,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FCh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	fcall	_ponto
	line	172
;girador.c: 172: ponto(x,y-5,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FBh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	fcall	_ponto
	line	173
;girador.c: 173: ponto(x+1,y,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	01h
	fcall	_ponto
	line	174
;girador.c: 174: ponto(x+1,y-6,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FAh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	01h
	fcall	_ponto
	line	175
;girador.c: 175: ponto(x+2,y,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	02h
	fcall	_ponto
	line	176
;girador.c: 176: ponto(x+2,y-6,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FAh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	02h
	fcall	_ponto
	line	177
;girador.c: 177: ponto(x+3,y,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	03h
	fcall	_ponto
	line	178
;girador.c: 178: ponto(x+3,y-6,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FAh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	03h
	fcall	_ponto
	line	179
;girador.c: 179: ponto(x+4,y-1,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FFh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	04h
	fcall	_ponto
	line	180
;girador.c: 180: ponto(x+4,y-2,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FEh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	04h
	fcall	_ponto
	line	181
;girador.c: 181: ponto(x+4,y-3,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FDh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	04h
	fcall	_ponto
	line	182
;girador.c: 182: ponto(x+4,y-4,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FCh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	04h
	fcall	_ponto
	line	183
;girador.c: 183: ponto(x+4,y-5,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FBh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	04h
	fcall	_ponto
	line	184
;girador.c: 184: break;
	goto	l866
	line	185
;girador.c: 185: case 1:
	
l857:	
	line	186
	
l4694:	
;girador.c: 186: ponto(x,y-2,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FEh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	fcall	_ponto
	line	187
;girador.c: 187: ponto(x,y-6,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FAh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	fcall	_ponto
	line	188
;girador.c: 188: ponto(x+1,y-1,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FFh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	01h
	fcall	_ponto
	line	189
;girador.c: 189: ponto(x+1,y-6,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FAh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	01h
	fcall	_ponto
	line	190
;girador.c: 190: ponto(x+2,y,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	02h
	fcall	_ponto
	line	191
;girador.c: 191: ponto(x+2,y-1,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FFh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	02h
	fcall	_ponto
	line	192
;girador.c: 192: ponto(x+2,y-2,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FEh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	02h
	fcall	_ponto
	line	193
;girador.c: 193: ponto(x+2,y-3,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FDh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	02h
	fcall	_ponto
	line	194
;girador.c: 194: ponto(x+2,y-4,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FCh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	02h
	fcall	_ponto
	line	195
;girador.c: 195: ponto(x+2,y-5,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FBh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	02h
	fcall	_ponto
	line	196
;girador.c: 196: ponto(x+2,y-6,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FAh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	02h
	fcall	_ponto
	line	197
;girador.c: 197: ponto(x+3,y-6,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FAh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	03h
	fcall	_ponto
	line	198
;girador.c: 198: ponto(x+4,y-6,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FAh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	04h
	fcall	_ponto
	line	199
;girador.c: 199: break;
	goto	l866
	line	200
;girador.c: 200: case 2:
	
l858:	
	line	201
	
l4696:	
;girador.c: 201: ponto(x,y-1,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FFh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	fcall	_ponto
	line	202
;girador.c: 202: ponto(x,y-6,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FAh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	fcall	_ponto
	line	203
;girador.c: 203: ponto(x+1,y,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	01h
	fcall	_ponto
	line	204
;girador.c: 204: ponto(x+1,y-5,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FBh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	01h
	fcall	_ponto
	line	205
;girador.c: 205: ponto(x+1,y-6,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FAh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	01h
	fcall	_ponto
	line	206
;girador.c: 206: ponto(x+2,y,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	02h
	fcall	_ponto
	line	207
;girador.c: 207: ponto(x+2,y-4,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FCh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	02h
	fcall	_ponto
	line	208
;girador.c: 208: ponto(x+2,y-6,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FAh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	02h
	fcall	_ponto
	line	209
;girador.c: 209: ponto(x+3,y,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	03h
	fcall	_ponto
	line	210
;girador.c: 210: ponto(x+3,y-3,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FDh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	03h
	fcall	_ponto
	line	211
;girador.c: 211: ponto(x+3,y-6,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FAh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	03h
	fcall	_ponto
	line	212
;girador.c: 212: ponto(x+4,y-1,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FFh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	04h
	fcall	_ponto
	line	213
;girador.c: 213: ponto(x+4,y-2,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FEh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	04h
	fcall	_ponto
	line	214
;girador.c: 214: ponto(x+4,y-6,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FAh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	04h
	fcall	_ponto
	line	215
;girador.c: 215: break;
	goto	l866
	line	216
;girador.c: 216: case 3:
	
l859:	
	line	217
	
l4698:	
;girador.c: 217: ponto(x,y-1,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FFh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	fcall	_ponto
	line	218
;girador.c: 218: ponto(x,y-5,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FBh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	fcall	_ponto
	line	219
;girador.c: 219: ponto(x+1,y,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	01h
	fcall	_ponto
	line	220
;girador.c: 220: ponto(x+1,y-6,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FAh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	01h
	fcall	_ponto
	line	221
;girador.c: 221: ponto(x+2,y,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	02h
	fcall	_ponto
	line	222
;girador.c: 222: ponto(x+2,y-3,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FDh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	02h
	fcall	_ponto
	line	223
;girador.c: 223: ponto(x+2,y-6,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FAh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	02h
	fcall	_ponto
	line	224
;girador.c: 224: ponto(x+3,y,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	03h
	fcall	_ponto
	line	225
;girador.c: 225: ponto(x+3,y-3,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FDh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	03h
	fcall	_ponto
	line	226
;girador.c: 226: ponto(x+3,y-6,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FAh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	03h
	fcall	_ponto
	line	227
;girador.c: 227: ponto(x+4,y-1,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FFh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	04h
	fcall	_ponto
	line	228
;girador.c: 228: ponto(x+4,y-2,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FEh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	04h
	fcall	_ponto
	line	229
;girador.c: 229: ponto(x+4,y-4,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FCh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	04h
	fcall	_ponto
	line	230
;girador.c: 230: ponto(x+4,y-5,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FBh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	04h
	fcall	_ponto
	line	231
;girador.c: 231: break;
	goto	l866
	line	232
;girador.c: 232: case 4:
	
l860:	
	line	233
	
l4700:	
;girador.c: 233: ponto(x,y-3,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FDh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	fcall	_ponto
	line	234
;girador.c: 234: ponto(x,y-4,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FCh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	fcall	_ponto
	line	235
;girador.c: 235: ponto(x+1,y-2,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FEh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	01h
	fcall	_ponto
	line	236
;girador.c: 236: ponto(x+1,y-4,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FCh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	01h
	fcall	_ponto
	line	237
;girador.c: 237: ponto(x+2,y-1,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FFh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	02h
	fcall	_ponto
	line	238
;girador.c: 238: ponto(x+2,y-4,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FCh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	02h
	fcall	_ponto
	line	239
;girador.c: 239: ponto(x+3,y,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	03h
	fcall	_ponto
	line	240
;girador.c: 240: ponto(x+3,y-1,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FFh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	03h
	fcall	_ponto
	line	241
;girador.c: 241: ponto(x+3,y-2,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FEh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	03h
	fcall	_ponto
	line	242
;girador.c: 242: ponto(x+3,y-3,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FDh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	03h
	fcall	_ponto
	line	243
;girador.c: 243: ponto(x+3,y-4,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FCh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	03h
	fcall	_ponto
	line	244
;girador.c: 244: ponto(x+3,y-5,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FBh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	03h
	fcall	_ponto
	line	245
;girador.c: 245: ponto(x+3,y-6,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FAh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	03h
	fcall	_ponto
	line	246
;girador.c: 246: ponto(x+4,y-4,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FCh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	04h
	fcall	_ponto
	line	247
;girador.c: 247: break;
	goto	l866
	line	248
;girador.c: 248: case 5:
	
l861:	
	line	249
	
l4702:	
;girador.c: 249: ponto(x,y,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	fcall	_ponto
	line	250
;girador.c: 250: ponto(x,y-1,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FFh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	fcall	_ponto
	line	251
;girador.c: 251: ponto(x,y-2,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FEh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	fcall	_ponto
	line	252
;girador.c: 252: ponto(x,y-3,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FDh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	fcall	_ponto
	line	253
;girador.c: 253: ponto(x,y-5,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FBh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	fcall	_ponto
	line	254
;girador.c: 254: ponto(x+1,y,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	01h
	fcall	_ponto
	line	255
;girador.c: 255: ponto(x+1,y-3,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FDh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	01h
	fcall	_ponto
	line	256
;girador.c: 256: ponto(x+1,y-6,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FAh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	01h
	fcall	_ponto
	line	257
;girador.c: 257: ponto(x+2,y,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	02h
	fcall	_ponto
	line	258
;girador.c: 258: ponto(x+2,y-3,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FDh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	02h
	fcall	_ponto
	line	259
;girador.c: 259: ponto(x+2,y-6,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FAh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	02h
	fcall	_ponto
	line	260
;girador.c: 260: ponto(x+3,y,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	03h
	fcall	_ponto
	line	261
;girador.c: 261: ponto(x+3,y-3,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FDh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	03h
	fcall	_ponto
	line	262
;girador.c: 262: ponto(x+3,y-6,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FAh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	03h
	fcall	_ponto
	line	263
;girador.c: 263: ponto(x+4,y,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	04h
	fcall	_ponto
	line	264
;girador.c: 264: ponto(x+4,y-4,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FCh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	04h
	fcall	_ponto
	line	265
;girador.c: 265: ponto(x+4,y-5,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FBh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	04h
	fcall	_ponto
	line	266
;girador.c: 266: break;
	goto	l866
	line	267
;girador.c: 267: case 6:
	
l862:	
	line	268
	
l4704:	
;girador.c: 268: ponto(x,y-1,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FFh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	fcall	_ponto
	line	269
;girador.c: 269: ponto(x,y-2,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FEh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	fcall	_ponto
	line	270
;girador.c: 270: ponto(x,y-3,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FDh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	fcall	_ponto
	line	271
;girador.c: 271: ponto(x,y-4,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FCh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	fcall	_ponto
	line	272
;girador.c: 272: ponto(x,y-5,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FBh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	fcall	_ponto
	line	273
;girador.c: 273: ponto(x+1,y,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	01h
	fcall	_ponto
	line	274
;girador.c: 274: ponto(x+1,y-3,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FDh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	01h
	fcall	_ponto
	line	275
;girador.c: 275: ponto(x+1,y-6,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FAh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	01h
	fcall	_ponto
	line	276
;girador.c: 276: ponto(x+2,y,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	02h
	fcall	_ponto
	line	277
;girador.c: 277: ponto(x+2,y-3,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FDh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	02h
	fcall	_ponto
	line	278
;girador.c: 278: ponto(x+2,y-6,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FAh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	02h
	fcall	_ponto
	line	279
;girador.c: 279: ponto(x+3,y,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	03h
	fcall	_ponto
	line	280
;girador.c: 280: ponto(x+3,y-3,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FDh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	03h
	fcall	_ponto
	line	281
;girador.c: 281: ponto(x+3,y-6,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FAh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	03h
	fcall	_ponto
	line	282
;girador.c: 282: ponto(x+4,y-1,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FFh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	04h
	fcall	_ponto
	line	283
;girador.c: 283: ponto(x+4,y-4,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FCh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	04h
	fcall	_ponto
	line	284
;girador.c: 284: ponto(x+4,y-5,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FBh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	04h
	fcall	_ponto
	line	285
;girador.c: 285: break;
	goto	l866
	line	286
;girador.c: 286: case 7:
	
l863:	
	line	287
	
l4706:	
;girador.c: 287: ponto(x,y,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	fcall	_ponto
	line	288
;girador.c: 288: ponto(x,y-1,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FFh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	fcall	_ponto
	line	289
;girador.c: 289: ponto(x+1,y,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	01h
	fcall	_ponto
	line	290
;girador.c: 290: ponto(x+2,y,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	02h
	fcall	_ponto
	line	291
;girador.c: 291: ponto(x+2,y-1,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FFh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	02h
	fcall	_ponto
	line	292
;girador.c: 292: ponto(x+2,y-5,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FBh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	02h
	fcall	_ponto
	line	293
;girador.c: 293: ponto(x+2,y-6,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FAh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	02h
	fcall	_ponto
	line	294
;girador.c: 294: ponto(x+3,y,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	03h
	fcall	_ponto
	line	295
;girador.c: 295: ponto(x+3,y-3,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FDh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	03h
	fcall	_ponto
	line	296
;girador.c: 296: ponto(x+3,y-4,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FCh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	03h
	fcall	_ponto
	line	297
;girador.c: 297: ponto(x+4,y,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	04h
	fcall	_ponto
	line	298
;girador.c: 298: ponto(x+4,y-1,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FFh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	04h
	fcall	_ponto
	line	299
;girador.c: 299: ponto(x+4,y-2,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FEh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	04h
	fcall	_ponto
	line	300
;girador.c: 300: break;
	goto	l866
	line	301
;girador.c: 301: case 8:
	
l864:	
	line	302
	
l4708:	
;girador.c: 302: ponto(x,y-1,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FFh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	fcall	_ponto
	line	303
;girador.c: 303: ponto(x,y-2,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FEh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	fcall	_ponto
	line	304
;girador.c: 304: ponto(x,y-4,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FCh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	fcall	_ponto
	line	305
;girador.c: 305: ponto(x,y-5,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FBh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	fcall	_ponto
	line	306
;girador.c: 306: ponto(x+1,y,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	01h
	fcall	_ponto
	line	307
;girador.c: 307: ponto(x+1,y-3,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FDh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	01h
	fcall	_ponto
	line	308
;girador.c: 308: ponto(x+1,y-6,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FAh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	01h
	fcall	_ponto
	line	309
;girador.c: 309: ponto(x+2,y,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	02h
	fcall	_ponto
	line	310
;girador.c: 310: ponto(x+2,y-3,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FDh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	02h
	fcall	_ponto
	line	311
;girador.c: 311: ponto(x+2,y-6,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FAh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	02h
	fcall	_ponto
	line	312
;girador.c: 312: ponto(x+3,y,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	03h
	fcall	_ponto
	line	313
;girador.c: 313: ponto(x+3,y-3,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FDh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	03h
	fcall	_ponto
	line	314
;girador.c: 314: ponto(x+3,y-6,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FAh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	03h
	fcall	_ponto
	line	315
;girador.c: 315: ponto(x+4,y-1,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FFh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	04h
	fcall	_ponto
	line	316
;girador.c: 316: ponto(x+4,y-2,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FEh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	04h
	fcall	_ponto
	line	317
;girador.c: 317: ponto(x+4,y-4,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FCh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	04h
	fcall	_ponto
	line	318
;girador.c: 318: ponto(x+4,y-5,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FBh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	04h
	fcall	_ponto
	line	319
;girador.c: 319: break;
	goto	l866
	line	320
;girador.c: 320: case 9:
	
l865:	
	line	321
	
l4710:	
;girador.c: 321: ponto(x,y-1,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FFh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	fcall	_ponto
	line	322
;girador.c: 322: ponto(x,y-2,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FEh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	fcall	_ponto
	line	323
;girador.c: 323: ponto(x,y-5,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FBh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	fcall	_ponto
	line	324
;girador.c: 324: ponto(x+1,y,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	01h
	fcall	_ponto
	line	325
;girador.c: 325: ponto(x+1,y-3,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FDh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	01h
	fcall	_ponto
	line	326
;girador.c: 326: ponto(x+1,y-6,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FAh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	01h
	fcall	_ponto
	line	327
;girador.c: 327: ponto(x+2,y,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	02h
	fcall	_ponto
	line	328
;girador.c: 328: ponto(x+2,y-3,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FDh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	02h
	fcall	_ponto
	line	329
;girador.c: 329: ponto(x+2,y-6,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FAh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	02h
	fcall	_ponto
	line	330
;girador.c: 330: ponto(x+3,y,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	03h
	fcall	_ponto
	line	331
;girador.c: 331: ponto(x+3,y-3,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FDh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	03h
	fcall	_ponto
	line	332
;girador.c: 332: ponto(x+3,y-6,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FAh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	03h
	fcall	_ponto
	line	333
;girador.c: 333: ponto(x+4,y-1,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FFh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	04h
	fcall	_ponto
	line	334
;girador.c: 334: ponto(x+4,y-2,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FEh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	04h
	fcall	_ponto
	line	335
;girador.c: 335: ponto(x+4,y-3,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FDh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	04h
	fcall	_ponto
	line	336
;girador.c: 336: ponto(x+4,y-4,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FCh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	04h
	fcall	_ponto
	line	337
;girador.c: 337: ponto(x+4,y-5,1);
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@y),w
	addlw	0FBh
	movwf	(??_desenhar_numero+0)+0
	movf	(??_desenhar_numero+0)+0,w
	movwf	(?_ponto)
	clrf	0+(?_ponto)+01h
	bsf	status,0
	rlf	0+(?_ponto)+01h,f
	movf	(desenhar_numero@x),w
	addlw	04h
	fcall	_ponto
	line	338
;girador.c: 338: }
	goto	l866
	line	166
	
l854:	
	
l4712:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(desenhar_numero@num),w
	; Switch size 1, requested type "space"
; Number of cases is 10, Range of values is 0 to 9
; switch strategies available:
; Name         Instructions Cycles
; simple_byte           31    16 (average)
; direct_byte           38     8 (fixed)
; jumptable            260     6 (fixed)
; rangetable            14     6 (fixed)
; spacedrange           26     9 (fixed)
; locatedrange          10     3 (fixed)
;	Chosen strategy is simple_byte

	opt asmopt_off
	xorlw	0^0	; case 0
	skipnz
	goto	l4692
	xorlw	1^0	; case 1
	skipnz
	goto	l4694
	xorlw	2^1	; case 2
	skipnz
	goto	l4696
	xorlw	3^2	; case 3
	skipnz
	goto	l4698
	xorlw	4^3	; case 4
	skipnz
	goto	l4700
	xorlw	5^4	; case 5
	skipnz
	goto	l4702
	xorlw	6^5	; case 6
	skipnz
	goto	l4704
	xorlw	7^6	; case 7
	skipnz
	goto	l4706
	xorlw	8^7	; case 8
	skipnz
	goto	l4708
	xorlw	9^8	; case 9
	skipnz
	goto	l4710
	goto	l866
	opt asmopt_on

	line	338
	
l856:	
	line	339
	
l866:	
	return
	opt stack 0
GLOBAL	__end_of_desenhar_numero
	__end_of_desenhar_numero:
;; =============== function _desenhar_numero ends ============

	signat	_desenhar_numero,12408
	global	_linha
psect	text371,local,class=CODE,delta=2
global __ptext371
__ptext371:

;; *************** function _linha *****************
;; Defined at:
;;		line 118 in file "C:\Users\Felipe\Desktop\GIRADOR+IR\girador-soft\girador.c"
;; Parameters:    Size  Location     Type
;;  x1              1    wreg     unsigned char 
;;  y1              1   34[BANK0 ] unsigned char 
;;  x3              1   35[BANK0 ] unsigned char 
;;  y3              1   36[BANK0 ] unsigned char 
;;  def             1   37[BANK0 ] unsigned char 
;;  clear           1   38[BANK0 ] unsigned char 
;; Auto vars:     Size  Location     Type
;;  x1              1   48[BANK0 ] unsigned char 
;;  n               1   51[BANK0 ] unsigned char 
;;  y               1   50[BANK0 ] unsigned char 
;;  x               1   49[BANK0 ] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, btemp+1, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       5       0       0       0
;;      Locals:         0       4       0       0       0
;;      Temps:          0       9       0       0       0
;;      Totals:         0      18       0       0       0
;;Total ram usage:       18 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		___wmul
;;		___awdiv
;;		_ponto
;; This function is called by:
;;		_desenhar_relogio_digital
;; This function uses a non-reentrant model
;;
psect	text371
	file	"C:\Users\Felipe\Desktop\GIRADOR+IR\girador-soft\girador.c"
	line	118
	global	__size_of_linha
	__size_of_linha	equ	__end_of_linha-_linha
	
_linha:	
	opt	stack 3
; Regs used in _linha: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
;linha@x1 stored from wreg
	line	120
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(linha@x1)
	
l4670:	
;girador.c: 119: char n,x,y;
;girador.c: 120: if(x3>0b10000000){x3=-x3;x1-=x3;}
	movlw	(081h)
	subwf	(linha@x3),w
	skipc
	goto	u5051
	goto	u5050
u5051:
	goto	l846
u5050:
	
l4672:	
	comf	(linha@x3),f
	incf	(linha@x3),f
	
l4674:	
	movf	(linha@x3),w
	subwf	(linha@x1),f
	
l846:	
	line	121
;girador.c: 121: if(y3>0b10000000){y3=-y3;y1-=y3;}
	movlw	(081h)
	subwf	(linha@y3),w
	skipc
	goto	u5061
	goto	u5060
u5061:
	goto	l4680
u5060:
	
l4676:	
	comf	(linha@y3),f
	incf	(linha@y3),f
	
l4678:	
	movf	(linha@y3),w
	subwf	(linha@y1),f
	goto	l4680
	
l847:	
	line	122
	
l4680:	
;girador.c: 122: for(n=0;n<=def;n++){
	clrf	(linha@n)
	goto	l4688
	
l849:	
	line	123
	
l4682:	
;girador.c: 123: x = x1+(n*x3)/def;
	movf	(linha@def),w
	movwf	(??_linha+0)+0
	clrf	(??_linha+0)+0+1
	movf	0+(??_linha+0)+0,w
	movwf	(?___awdiv)
	movf	1+(??_linha+0)+0,w
	movwf	(?___awdiv+1)
	movf	(linha@n),w
	movwf	(??_linha+2)+0
	clrf	(??_linha+2)+0+1
	movf	0+(??_linha+2)+0,w
	movwf	(?___wmul)
	movf	1+(??_linha+2)+0,w
	movwf	(?___wmul+1)
	movf	(linha@x3),w
	movwf	(??_linha+4)+0
	clrf	(??_linha+4)+0+1
	movf	0+(??_linha+4)+0,w
	movwf	0+(?___wmul)+02h
	movf	1+(??_linha+4)+0,w
	movwf	1+(?___wmul)+02h
	fcall	___wmul
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(1+(?___wmul)),w
	clrf	1+(?___awdiv)+02h
	addwf	1+(?___awdiv)+02h
	movf	(0+(?___wmul)),w
	clrf	0+(?___awdiv)+02h
	addwf	0+(?___awdiv)+02h

	fcall	___awdiv
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(0+?___awdiv),w
	movwf	(??_linha+6)+0
	movf	(1+?___awdiv),w
	movwf	((??_linha+6)+0+1)
	movf	(linha@x1),w
	addwf	0+(??_linha+6)+0,w
	movwf	(??_linha+8)+0
	movf	(??_linha+8)+0,w
	movwf	(linha@x)
	line	124
;girador.c: 124: y = y1+(n*y3)/def;
	movf	(linha@def),w
	movwf	(??_linha+0)+0
	clrf	(??_linha+0)+0+1
	movf	0+(??_linha+0)+0,w
	movwf	(?___awdiv)
	movf	1+(??_linha+0)+0,w
	movwf	(?___awdiv+1)
	movf	(linha@n),w
	movwf	(??_linha+2)+0
	clrf	(??_linha+2)+0+1
	movf	0+(??_linha+2)+0,w
	movwf	(?___wmul)
	movf	1+(??_linha+2)+0,w
	movwf	(?___wmul+1)
	movf	(linha@y3),w
	movwf	(??_linha+4)+0
	clrf	(??_linha+4)+0+1
	movf	0+(??_linha+4)+0,w
	movwf	0+(?___wmul)+02h
	movf	1+(??_linha+4)+0,w
	movwf	1+(?___wmul)+02h
	fcall	___wmul
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(1+(?___wmul)),w
	clrf	1+(?___awdiv)+02h
	addwf	1+(?___awdiv)+02h
	movf	(0+(?___wmul)),w
	clrf	0+(?___awdiv)+02h
	addwf	0+(?___awdiv)+02h

	fcall	___awdiv
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(0+?___awdiv),w
	movwf	(??_linha+6)+0
	movf	(1+?___awdiv),w
	movwf	((??_linha+6)+0+1)
	movf	(linha@y1),w
	addwf	0+(??_linha+6)+0,w
	movwf	(??_linha+8)+0
	movf	(??_linha+8)+0,w
	movwf	(linha@y)
	line	125
	
l4684:	
;girador.c: 125: ponto(x,y,clear);
	movf	(linha@y),w
	movwf	(??_linha+0)+0
	movf	(??_linha+0)+0,w
	movwf	(?_ponto)
	movf	(linha@clear),w
	movwf	(??_linha+1)+0
	movf	(??_linha+1)+0,w
	movwf	0+(?_ponto)+01h
	movf	(linha@x),w
	fcall	_ponto
	line	122
	
l4686:	
	movlw	(01h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_linha+0)+0
	movf	(??_linha+0)+0,w
	addwf	(linha@n),f
	goto	l4688
	
l848:	
	
l4688:	
	movf	(linha@n),w
	subwf	(linha@def),w
	skipnc
	goto	u5071
	goto	u5070
u5071:
	goto	l4682
u5070:
	goto	l851
	
l850:	
	line	127
	
l851:	
	return
	opt stack 0
GLOBAL	__end_of_linha
	__end_of_linha:
;; =============== function _linha ends ============

	signat	_linha,24696
	global	_verificar_botoes
psect	text372,local,class=CODE,delta=2
global __ptext372
__ptext372:

;; *************** function _verificar_botoes *****************
;; Defined at:
;;		line 646 in file "C:\Users\Felipe\Desktop\GIRADOR+IR\girador-soft\girador.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       2       0       0       0
;;      Totals:         0       2       0       0       0
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text372
	file	"C:\Users\Felipe\Desktop\GIRADOR+IR\girador-soft\girador.c"
	line	646
	global	__size_of_verificar_botoes
	__size_of_verificar_botoes	equ	__end_of_verificar_botoes-_verificar_botoes
	
_verificar_botoes:	
	opt	stack 6
; Regs used in _verificar_botoes: [wreg+status,2+status,0]
	line	647
	
l4590:	
;girador.c: 647: if(SENSOR!=0){
	movf	(_SENSOR),w
	skipz
	goto	u4880
	goto	l926
u4880:
	line	648
	
l4592:	
;girador.c: 648: if(SENSOR&1){
	btfss	(_SENSOR),(0)&7
	goto	u4891
	goto	u4890
u4891:
	goto	l4598
u4890:
	line	649
	
l4594:	
;girador.c: 649: CALIBRACAO++;
	movlw	(01h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_verificar_botoes+0)+0
	movf	(??_verificar_botoes+0)+0,w
	addwf	(_CALIBRACAO),f
	line	650
	
l4596:	
;girador.c: 650: telaL[37]=0b11110000;
	movlw	(0F0h)
	movwf	(??_verificar_botoes+0)+0
	movf	(??_verificar_botoes+0)+0,w
	bsf	status, 5	;RP0=1, select bank3
	bsf	status, 6	;RP1=1, select bank3
	movwf	0+(_telaL)^0180h+025h
	goto	l4598
	line	651
	
l909:	
	line	652
	
l4598:	
;girador.c: 651: }
;girador.c: 652: if(SENSOR&2){
	btfss	(_SENSOR),(1)&7
	goto	u4901
	goto	u4900
u4901:
	goto	l4604
u4900:
	line	653
	
l4600:	
;girador.c: 653: CALIBRACAO--;
	movlw	low(01h)
	subwf	(_CALIBRACAO),f
	line	654
	
l4602:	
;girador.c: 654: telaL[44]=0b11110000;
	movlw	(0F0h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_verificar_botoes+0)+0
	movf	(??_verificar_botoes+0)+0,w
	bsf	status, 5	;RP0=1, select bank3
	bsf	status, 6	;RP1=1, select bank3
	movwf	0+(_telaL)^0180h+02Ch
	goto	l4604
	line	655
	
l910:	
	line	656
	
l4604:	
;girador.c: 655: }
;girador.c: 656: if(SENSOR&4){
	btfss	(_SENSOR),(2)&7
	goto	u4911
	goto	u4910
u4911:
	goto	l4614
u4910:
	line	657
	
l4606:	
;girador.c: 657: sl++;
	movlw	(01h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_verificar_botoes+0)+0
	movf	(??_verificar_botoes+0)+0,w
	addwf	(_sl),f
	line	658
	
l4608:	
;girador.c: 658: if(sl==10)sl=0;
	movf	(_sl),w
	xorlw	0Ah
	skipz
	goto	u4921
	goto	u4920
u4921:
	goto	l4612
u4920:
	
l4610:	
	clrf	(_sl)
	goto	l4612
	
l912:	
	line	659
	
l4612:	
;girador.c: 659: telaL[52]=0b11110000;
	movlw	(0F0h)
	movwf	(??_verificar_botoes+0)+0
	movf	(??_verificar_botoes+0)+0,w
	bsf	status, 5	;RP0=1, select bank3
	bsf	status, 6	;RP1=1, select bank3
	movwf	0+(_telaL)^0180h+034h
	goto	l4614
	line	660
	
l911:	
	line	661
	
l4614:	
;girador.c: 660: }
;girador.c: 661: if(SENSOR&8){
	btfss	(_SENSOR),(3)&7
	goto	u4931
	goto	u4930
u4931:
	goto	l4624
u4930:
	line	662
	
l4616:	
;girador.c: 662: sh++;
	movlw	(01h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_verificar_botoes+0)+0
	movf	(??_verificar_botoes+0)+0,w
	addwf	(_sh),f
	line	663
	
l4618:	
;girador.c: 663: if(sh==6)sh=0;
	movf	(_sh),w
	xorlw	06h
	skipz
	goto	u4941
	goto	u4940
u4941:
	goto	l4622
u4940:
	
l4620:	
	clrf	(_sh)
	goto	l4622
	
l914:	
	line	664
	
l4622:	
;girador.c: 664: telaL[59]=0b11110000;
	movlw	(0F0h)
	movwf	(??_verificar_botoes+0)+0
	movf	(??_verificar_botoes+0)+0,w
	bsf	status, 5	;RP0=1, select bank3
	bsf	status, 6	;RP1=1, select bank3
	movwf	0+(_telaL)^0180h+03Bh
	goto	l4624
	line	665
	
l913:	
	line	666
	
l4624:	
;girador.c: 665: }
;girador.c: 666: if(SENSOR&16){
	btfss	(_SENSOR),(4)&7
	goto	u4951
	goto	u4950
u4951:
	goto	l4634
u4950:
	line	667
	
l4626:	
;girador.c: 667: ml++;
	movlw	(01h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_verificar_botoes+0)+0
	movf	(??_verificar_botoes+0)+0,w
	addwf	(_ml),f
	line	668
	
l4628:	
;girador.c: 668: if(ml==10)ml=0;
	movf	(_ml),w
	xorlw	0Ah
	skipz
	goto	u4961
	goto	u4960
u4961:
	goto	l4632
u4960:
	
l4630:	
	clrf	(_ml)
	goto	l4632
	
l916:	
	line	669
	
l4632:	
;girador.c: 669: telaL[6]=0b11110000;
	movlw	(0F0h)
	movwf	(??_verificar_botoes+0)+0
	movf	(??_verificar_botoes+0)+0,w
	bsf	status, 5	;RP0=1, select bank3
	bsf	status, 6	;RP1=1, select bank3
	movwf	0+(_telaL)^0180h+06h
	goto	l4634
	line	670
	
l915:	
	line	671
	
l4634:	
;girador.c: 670: }
;girador.c: 671: if(SENSOR&32){
	btfss	(_SENSOR),(5)&7
	goto	u4971
	goto	u4970
u4971:
	goto	l4644
u4970:
	line	672
	
l4636:	
;girador.c: 672: mh++;
	movlw	(01h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_verificar_botoes+0)+0
	movf	(??_verificar_botoes+0)+0,w
	addwf	(_mh),f
	line	673
	
l4638:	
;girador.c: 673: if(mh==6)mh=0;
	movf	(_mh),w
	xorlw	06h
	skipz
	goto	u4981
	goto	u4980
u4981:
	goto	l4642
u4980:
	
l4640:	
	clrf	(_mh)
	goto	l4642
	
l918:	
	line	674
	
l4642:	
;girador.c: 674: telaL[14]=0b11110000;
	movlw	(0F0h)
	movwf	(??_verificar_botoes+0)+0
	movf	(??_verificar_botoes+0)+0,w
	bsf	status, 5	;RP0=1, select bank3
	bsf	status, 6	;RP1=1, select bank3
	movwf	0+(_telaL)^0180h+0Eh
	goto	l4644
	line	675
	
l917:	
	line	676
	
l4644:	
;girador.c: 675: }
;girador.c: 676: if(SENSOR&64){
	btfss	(_SENSOR),(6)&7
	goto	u4991
	goto	u4990
u4991:
	goto	l4662
u4990:
	line	677
	
l4646:	
;girador.c: 677: hl++;
	movlw	(01h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_verificar_botoes+0)+0
	movf	(??_verificar_botoes+0)+0,w
	addwf	(_hl),f
	line	678
	
l4648:	
;girador.c: 678: if(hl==10){
	movf	(_hl),w
	xorlw	0Ah
	skipz
	goto	u5001
	goto	u5000
u5001:
	goto	l4654
u5000:
	line	679
	
l4650:	
;girador.c: 679: hh++;
	movlw	(01h)
	movwf	(??_verificar_botoes+0)+0
	movf	(??_verificar_botoes+0)+0,w
	addwf	(_hh),f
	line	680
	
l4652:	
;girador.c: 680: hl=0;
	clrf	(_hl)
	goto	l4654
	line	681
	
l920:	
	line	682
	
l4654:	
;girador.c: 681: }
;girador.c: 682: if(hh==2 && hl==4){
	movf	(_hh),w
	xorlw	02h
	skipz
	goto	u5011
	goto	u5010
u5011:
	goto	l4660
u5010:
	
l4656:	
	movf	(_hl),w
	xorlw	04h
	skipz
	goto	u5021
	goto	u5020
u5021:
	goto	l4660
u5020:
	line	683
	
l4658:	
;girador.c: 683: hh=0;
	clrf	(_hh)
	line	684
;girador.c: 684: hl=0;
	clrf	(_hl)
	goto	l4660
	line	685
	
l921:	
	line	686
	
l4660:	
;girador.c: 685: }
;girador.c: 686: telaL[21]=0b11110000;
	movlw	(0F0h)
	movwf	(??_verificar_botoes+0)+0
	movf	(??_verificar_botoes+0)+0,w
	bsf	status, 5	;RP0=1, select bank3
	bsf	status, 6	;RP1=1, select bank3
	movwf	0+(_telaL)^0180h+015h
	goto	l4662
	line	687
	
l919:	
	line	688
	
l4662:	
;girador.c: 687: }
;girador.c: 688: if(SENSOR&128){
	btfss	(_SENSOR),(7)&7
	goto	u5031
	goto	u5030
u5031:
	goto	l922
u5030:
	line	689
	
l4664:	
;girador.c: 689: telaL[29]=0b11110000;
	movlw	(0F0h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_verificar_botoes+0)+0
	movf	(??_verificar_botoes+0)+0,w
	bsf	status, 5	;RP0=1, select bank3
	bsf	status, 6	;RP1=1, select bank3
	movwf	0+(_telaL)^0180h+01Dh
	line	690
	
l922:	
	line	691
;girador.c: 690: }
;girador.c: 691: _delay((unsigned long)((33)*(20000000/4000.0)));_delay((unsigned long)((33)*(20000000/4000.0)));_delay((unsigned long)((33)*(20000000/4000.0)));
	opt asmopt_off
movlw	215
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
movwf	((??_verificar_botoes+0)+0+1),f
	movlw	71
movwf	((??_verificar_botoes+0)+0),f
u5217:
	decfsz	((??_verificar_botoes+0)+0),f
	goto	u5217
	decfsz	((??_verificar_botoes+0)+0+1),f
	goto	u5217
	nop2
opt asmopt_on

	opt asmopt_off
movlw	215
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
movwf	((??_verificar_botoes+0)+0+1),f
	movlw	71
movwf	((??_verificar_botoes+0)+0),f
u5227:
	decfsz	((??_verificar_botoes+0)+0),f
	goto	u5227
	decfsz	((??_verificar_botoes+0)+0+1),f
	goto	u5227
	nop2
opt asmopt_on

	opt asmopt_off
movlw	215
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
movwf	((??_verificar_botoes+0)+0+1),f
	movlw	71
movwf	((??_verificar_botoes+0)+0),f
u5237:
	decfsz	((??_verificar_botoes+0)+0),f
	goto	u5237
	decfsz	((??_verificar_botoes+0)+0+1),f
	goto	u5237
	nop2
opt asmopt_on

	line	692
;girador.c: 692: while(SENSOR!=0);
	goto	l4666
	
l924:	
	goto	l4666
	
l923:	
	
l4666:	
	movf	(_SENSOR),f
	skipz
	goto	u5041
	goto	u5040
u5041:
	goto	l4666
u5040:
	goto	l4668
	
l925:	
	line	693
	
l4668:	
;girador.c: 693: _delay((unsigned long)((33)*(20000000/4000.0)));_delay((unsigned long)((33)*(20000000/4000.0)));_delay((unsigned long)((33)*(20000000/4000.0)));
	opt asmopt_off
movlw	215
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
movwf	((??_verificar_botoes+0)+0+1),f
	movlw	71
movwf	((??_verificar_botoes+0)+0),f
u5247:
	decfsz	((??_verificar_botoes+0)+0),f
	goto	u5247
	decfsz	((??_verificar_botoes+0)+0+1),f
	goto	u5247
	nop2
opt asmopt_on

	opt asmopt_off
movlw	215
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
movwf	((??_verificar_botoes+0)+0+1),f
	movlw	71
movwf	((??_verificar_botoes+0)+0),f
u5257:
	decfsz	((??_verificar_botoes+0)+0),f
	goto	u5257
	decfsz	((??_verificar_botoes+0)+0+1),f
	goto	u5257
	nop2
opt asmopt_on

	opt asmopt_off
movlw	215
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
movwf	((??_verificar_botoes+0)+0+1),f
	movlw	71
movwf	((??_verificar_botoes+0)+0),f
u5267:
	decfsz	((??_verificar_botoes+0)+0),f
	goto	u5267
	decfsz	((??_verificar_botoes+0)+0+1),f
	goto	u5267
	nop2
opt asmopt_on

	goto	l926
	line	694
	
l908:	
	line	695
	
l926:	
	return
	opt stack 0
GLOBAL	__end_of_verificar_botoes
	__end_of_verificar_botoes:
;; =============== function _verificar_botoes ends ============

	signat	_verificar_botoes,88
	global	_desenhar_relogio_analogico
psect	text373,local,class=CODE,delta=2
global __ptext373
__ptext373:

;; *************** function _desenhar_relogio_analogico *****************
;; Defined at:
;;		line 358 in file "C:\Users\Felipe\Desktop\GIRADOR+IR\girador-soft\girador.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  a               1   24[BANK0 ] unsigned char 
;;  segundo         1   23[BANK0 ] unsigned char 
;;  minuto          1   22[BANK0 ] unsigned char 
;;  hora            1   21[BANK0 ] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       4       0       0       0
;;      Temps:          0       4       0       0       0
;;      Totals:         0       8       0       0       0
;;Total ram usage:        8 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		___wmul
;;		___awmod
;;		___bmul
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text373
	file	"C:\Users\Felipe\Desktop\GIRADOR+IR\girador-soft\girador.c"
	line	358
	global	__size_of_desenhar_relogio_analogico
	__size_of_desenhar_relogio_analogico	equ	__end_of_desenhar_relogio_analogico-_desenhar_relogio_analogico
	
_desenhar_relogio_analogico:	
	opt	stack 5
; Regs used in _desenhar_relogio_analogico: [wreg-fsr0h+status,2+status,0+pclath+cstack]
	line	360
	
l4504:	
;girador.c: 359: char hora,minuto,segundo, a;
;girador.c: 360: hora = 15-(((hl+hh*10)%12)*5);
	movlw	(05h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_desenhar_relogio_analogico+0)+0
	movf	(??_desenhar_relogio_analogico+0)+0,w
	movwf	(?___bmul)
	movlw	low(0Ah)
	movwf	0+(?___wmul)+02h
	movlw	high(0Ah)
	movwf	(0+(?___wmul)+02h)+1
	movf	(_hh),w
	movwf	(??_desenhar_relogio_analogico+1)+0
	clrf	(??_desenhar_relogio_analogico+1)+0+1
	movf	0+(??_desenhar_relogio_analogico+1)+0,w
	movwf	(?___wmul)
	movf	1+(??_desenhar_relogio_analogico+1)+0,w
	movwf	(?___wmul+1)
	fcall	___wmul
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(_hl),w
	addwf	(0+(?___wmul)),w
	movwf	0+(?___awmod)+02h
	movf	(1+(?___wmul)),w
	skipnc
	incf	(1+(?___wmul)),w
	movwf	(0+(?___awmod)+02h)+1
	movlw	low(0Ch)
	movwf	(?___awmod)
	movlw	high(0Ch)
	movwf	((?___awmod))+1
	fcall	___awmod
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(0+(?___awmod)),w
	fcall	___bmul
	xorlw	0ffh
	addlw	1
	addlw	0Fh
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_desenhar_relogio_analogico+3)+0
	movf	(??_desenhar_relogio_analogico+3)+0,w
	movwf	(desenhar_relogio_analogico@hora)
	line	361
;girador.c: 361: minuto = 15-(ml+mh*10);
	movlw	(0Ah)
	movwf	(??_desenhar_relogio_analogico+0)+0
	movf	(??_desenhar_relogio_analogico+0)+0,w
	movwf	(?___bmul)
	movf	(_mh),w
	fcall	___bmul
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_desenhar_relogio_analogico+1)+0
	movf	(_ml),w
	addwf	0+(??_desenhar_relogio_analogico+1)+0,w
	xorlw	0ffh
	addlw	1
	addlw	0Fh
	movwf	(??_desenhar_relogio_analogico+2)+0
	movf	(??_desenhar_relogio_analogico+2)+0,w
	movwf	(desenhar_relogio_analogico@minuto)
	line	362
;girador.c: 362: segundo = 15-(sl+sh*10);
	movlw	(0Ah)
	movwf	(??_desenhar_relogio_analogico+0)+0
	movf	(??_desenhar_relogio_analogico+0)+0,w
	movwf	(?___bmul)
	movf	(_sh),w
	fcall	___bmul
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_desenhar_relogio_analogico+1)+0
	movf	(_sl),w
	addwf	0+(??_desenhar_relogio_analogico+1)+0,w
	xorlw	0ffh
	addlw	1
	addlw	0Fh
	movwf	(??_desenhar_relogio_analogico+2)+0
	movf	(??_desenhar_relogio_analogico+2)+0,w
	movwf	(desenhar_relogio_analogico@segundo)
	line	363
	
l4506:	
;girador.c: 363: if(segundo>128)segundo+=60;
	movlw	(081h)
	subwf	(desenhar_relogio_analogico@segundo),w
	skipc
	goto	u4801
	goto	u4800
u4801:
	goto	l4510
u4800:
	
l4508:	
	movlw	(03Ch)
	movwf	(??_desenhar_relogio_analogico+0)+0
	movf	(??_desenhar_relogio_analogico+0)+0,w
	addwf	(desenhar_relogio_analogico@segundo),f
	goto	l4510
	
l875:	
	line	364
	
l4510:	
;girador.c: 364: if(minuto>128)minuto+=60;
	movlw	(081h)
	subwf	(desenhar_relogio_analogico@minuto),w
	skipc
	goto	u4811
	goto	u4810
u4811:
	goto	l4514
u4810:
	
l4512:	
	movlw	(03Ch)
	movwf	(??_desenhar_relogio_analogico+0)+0
	movf	(??_desenhar_relogio_analogico+0)+0,w
	addwf	(desenhar_relogio_analogico@minuto),f
	goto	l4514
	
l876:	
	line	365
	
l4514:	
;girador.c: 365: if(hora>128)hora+=60;
	movlw	(081h)
	subwf	(desenhar_relogio_analogico@hora),w
	skipc
	goto	u4821
	goto	u4820
u4821:
	goto	l4518
u4820:
	
l4516:	
	movlw	(03Ch)
	movwf	(??_desenhar_relogio_analogico+0)+0
	movf	(??_desenhar_relogio_analogico+0)+0,w
	addwf	(desenhar_relogio_analogico@hora),f
	goto	l4518
	
l877:	
	line	366
	
l4518:	
;girador.c: 366: for(a=0;a<60;a++){
	clrf	(desenhar_relogio_analogico@a)
	
l4520:	
	movlw	(03Ch)
	subwf	(desenhar_relogio_analogico@a),w
	skipc
	goto	u4831
	goto	u4830
u4831:
	goto	l4524
u4830:
	goto	l4534
	
l4522:	
	goto	l4534
	
l878:	
	line	367
	
l4524:	
;girador.c: 367: telaL[a]=telaHL[a]=telaHF[a]=0;
	movf	(desenhar_relogio_analogico@a),w
	addlw	_telaHF&0ffh
	movwf	fsr0
	movlw	(0)
	bcf	status, 7	;select IRP bank1
	movwf	indf
	movwf	(??_desenhar_relogio_analogico+0)+0
	movf	(desenhar_relogio_analogico@a),w
	addlw	_telaHL&0ffh
	movwf	fsr0
	movf	(??_desenhar_relogio_analogico+0)+0,w
	bsf	status, 7	;select IRP bank2
	movwf	indf
	movf	(indf),w
	movwf	(??_desenhar_relogio_analogico+1)+0
	movf	(desenhar_relogio_analogico@a),w
	addlw	_telaL&0ffh
	movwf	fsr0
	movf	(??_desenhar_relogio_analogico+1)+0,w
	movwf	indf
	line	368
	
l4526:	
;girador.c: 368: if(a%10==0)telaHL[a]=telaHF[a]=0b00000001;
	movlw	low(0Ah)
	movwf	(?___awmod)
	movlw	high(0Ah)
	movwf	((?___awmod))+1
	movf	(desenhar_relogio_analogico@a),w
	movwf	(??_desenhar_relogio_analogico+0)+0
	clrf	(??_desenhar_relogio_analogico+0)+0+1
	movf	0+(??_desenhar_relogio_analogico+0)+0,w
	movwf	0+(?___awmod)+02h
	movf	1+(??_desenhar_relogio_analogico+0)+0,w
	movwf	1+(?___awmod)+02h
	fcall	___awmod
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	((1+(?___awmod))),w
	iorwf	((0+(?___awmod))),w
	skipz
	goto	u4841
	goto	u4840
u4841:
	goto	l4530
u4840:
	
l4528:	
	movf	(desenhar_relogio_analogico@a),w
	addlw	_telaHF&0ffh
	movwf	fsr0
	movlw	(01h)
	bcf	status, 7	;select IRP bank1
	movwf	indf
	movwf	(??_desenhar_relogio_analogico+0)+0
	movf	(desenhar_relogio_analogico@a),w
	addlw	_telaHL&0ffh
	movwf	fsr0
	movf	(??_desenhar_relogio_analogico+0)+0,w
	bsf	status, 7	;select IRP bank2
	movwf	indf
	goto	l4530
	
l880:	
	line	366
	
l4530:	
	movlw	(01h)
	movwf	(??_desenhar_relogio_analogico+0)+0
	movf	(??_desenhar_relogio_analogico+0)+0,w
	addwf	(desenhar_relogio_analogico@a),f
	
l4532:	
	movlw	(03Ch)
	subwf	(desenhar_relogio_analogico@a),w
	skipc
	goto	u4851
	goto	u4850
u4851:
	goto	l4524
u4850:
	goto	l4534
	
l879:	
	line	370
	
l4534:	
;girador.c: 369: }
;girador.c: 370: telaHF[2 ]=0b00000111;
	movlw	(07h)
	movwf	(??_desenhar_relogio_analogico+0)+0
	movf	(??_desenhar_relogio_analogico+0)+0,w
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	0+(_telaHF)^080h+02h
	line	371
	
l4536:	
;girador.c: 371: telaHF[1 ]=0b00000001;
	clrf	0+(_telaHF)^080h+01h
	bsf	status,0
	rlf	0+(_telaHF)^080h+01h,f
	line	372
	
l4538:	
;girador.c: 372: telaHF[0 ]=0b00000111;
	movlw	(07h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_desenhar_relogio_analogico+0)+0
	movf	(??_desenhar_relogio_analogico+0)+0,w
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	(_telaHF)^080h
	line	373
;girador.c: 373: telaHL[59]=0b00000001;
	bcf	status, 5	;RP0=0, select bank2
	bsf	status, 6	;RP1=1, select bank2
	clrf	0+(_telaHL)^0100h+03Bh
	bsf	status,0
	rlf	0+(_telaHL)^0100h+03Bh,f
	line	374
	
l4540:	
;girador.c: 374: telaHL[58]=0b00000111;
	movlw	(07h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_desenhar_relogio_analogico+0)+0
	movf	(??_desenhar_relogio_analogico+0)+0,w
	bcf	status, 5	;RP0=0, select bank2
	bsf	status, 6	;RP1=1, select bank2
	movwf	0+(_telaHL)^0100h+03Ah
	line	376
	
l4542:	
;girador.c: 376: telaHF[58]=0b00000111;
	movlw	(07h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_desenhar_relogio_analogico+0)+0
	movf	(??_desenhar_relogio_analogico+0)+0,w
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	0+(_telaHF)^080h+03Ah
	line	377
	
l4544:	
;girador.c: 377: telaHF[59]=0b00000101;
	movlw	(05h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_desenhar_relogio_analogico+0)+0
	movf	(??_desenhar_relogio_analogico+0)+0,w
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	0+(_telaHF)^080h+03Bh
	line	378
	
l4546:	
;girador.c: 378: telaHL[0 ]=0b00000111;
	movlw	(07h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_desenhar_relogio_analogico+0)+0
	movf	(??_desenhar_relogio_analogico+0)+0,w
	bcf	status, 5	;RP0=0, select bank2
	bsf	status, 6	;RP1=1, select bank2
	movwf	(_telaHL)^0100h
	line	379
	
l4548:	
;girador.c: 379: telaHL[1 ]=0b00000100;
	movlw	(04h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_desenhar_relogio_analogico+0)+0
	movf	(??_desenhar_relogio_analogico+0)+0,w
	bcf	status, 5	;RP0=0, select bank2
	bsf	status, 6	;RP1=1, select bank2
	movwf	0+(_telaHL)^0100h+01h
	line	380
	
l4550:	
;girador.c: 380: telaHL[2 ]=0b00000111;
	movlw	(07h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_desenhar_relogio_analogico+0)+0
	movf	(??_desenhar_relogio_analogico+0)+0,w
	bcf	status, 5	;RP0=0, select bank2
	bsf	status, 6	;RP1=1, select bank2
	movwf	0+(_telaHL)^0100h+02h
	line	382
	
l4552:	
;girador.c: 382: telaHL[29]=0b00011111;
	movlw	(01Fh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_desenhar_relogio_analogico+0)+0
	movf	(??_desenhar_relogio_analogico+0)+0,w
	bcf	status, 5	;RP0=0, select bank2
	bsf	status, 6	;RP1=1, select bank2
	movwf	0+(_telaHL)^0100h+01Dh
	line	383
	
l4554:	
;girador.c: 383: telaHL[30]=0b00010101;
	movlw	(015h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_desenhar_relogio_analogico+0)+0
	movf	(??_desenhar_relogio_analogico+0)+0,w
	bcf	status, 5	;RP0=0, select bank2
	bsf	status, 6	;RP1=1, select bank2
	movwf	0+(_telaHL)^0100h+01Eh
	line	384
	
l4556:	
;girador.c: 384: telaHL[31]=0b00010111;
	movlw	(017h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_desenhar_relogio_analogico+0)+0
	movf	(??_desenhar_relogio_analogico+0)+0,w
	bcf	status, 5	;RP0=0, select bank2
	bsf	status, 6	;RP1=1, select bank2
	movwf	0+(_telaHL)^0100h+01Fh
	line	386
	
l4558:	
;girador.c: 386: telaHF[32]=0b00011111;
	movlw	(01Fh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_desenhar_relogio_analogico+0)+0
	movf	(??_desenhar_relogio_analogico+0)+0,w
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	0+(_telaHF)^080h+020h
	line	387
	
l4560:	
;girador.c: 387: telaHF[31]=0b00000000;
	clrf	0+(_telaHF)^080h+01Fh
	line	388
	
l4562:	
;girador.c: 388: telaHF[30]=0b00011101;
	movlw	(01Dh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_desenhar_relogio_analogico+0)+0
	movf	(??_desenhar_relogio_analogico+0)+0,w
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	0+(_telaHF)^080h+01Eh
	line	389
	
l4564:	
;girador.c: 389: telaHF[29]=0b00010101;
	movlw	(015h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_desenhar_relogio_analogico+0)+0
	movf	(??_desenhar_relogio_analogico+0)+0,w
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	0+(_telaHF)^080h+01Dh
	line	390
	
l4566:	
;girador.c: 390: telaHF[28]=0b00010111;
	movlw	(017h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_desenhar_relogio_analogico+0)+0
	movf	(??_desenhar_relogio_analogico+0)+0,w
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	0+(_telaHF)^080h+01Ch
	line	392
	
l4568:	
;girador.c: 392: telaL[hora]|=0b11111111;
	movlw	(0FFh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_desenhar_relogio_analogico+0)+0
	movf	(desenhar_relogio_analogico@hora),w
	addlw	_telaL&0ffh
	movwf	fsr0
	movf	(??_desenhar_relogio_analogico+0)+0,w
	bsf	status, 7	;select IRP bank3
	movwf	indf
	line	393
	
l4570:	
;girador.c: 393: telaL[minuto]|=0b11111111;
	movlw	(0FFh)
	movwf	(??_desenhar_relogio_analogico+0)+0
	movf	(desenhar_relogio_analogico@minuto),w
	addlw	_telaL&0ffh
	movwf	fsr0
	movf	(??_desenhar_relogio_analogico+0)+0,w
	movwf	indf
	line	394
	
l4572:	
;girador.c: 394: telaL[segundo]|=0b11111111;
	movlw	(0FFh)
	movwf	(??_desenhar_relogio_analogico+0)+0
	movf	(desenhar_relogio_analogico@segundo),w
	addlw	_telaL&0ffh
	movwf	fsr0
	movf	(??_desenhar_relogio_analogico+0)+0,w
	movwf	indf
	line	396
	
l4574:	
;girador.c: 396: minuto=minuto<<1;
	movf	(desenhar_relogio_analogico@minuto),w
	movwf	(??_desenhar_relogio_analogico+0)+0
	addwf	(??_desenhar_relogio_analogico+0)+0,w
	movwf	(??_desenhar_relogio_analogico+1)+0
	movf	(??_desenhar_relogio_analogico+1)+0,w
	movwf	(desenhar_relogio_analogico@minuto)
	line	397
	
l4576:	
;girador.c: 397: segundo=segundo<<1;
	movf	(desenhar_relogio_analogico@segundo),w
	movwf	(??_desenhar_relogio_analogico+0)+0
	addwf	(??_desenhar_relogio_analogico+0)+0,w
	movwf	(??_desenhar_relogio_analogico+1)+0
	movf	(??_desenhar_relogio_analogico+1)+0,w
	movwf	(desenhar_relogio_analogico@segundo)
	line	398
	
l4578:	
;girador.c: 398: if(minuto<60)telaHF[minuto]|=0b11110000;
	movlw	(03Ch)
	subwf	(desenhar_relogio_analogico@minuto),w
	skipnc
	goto	u4861
	goto	u4860
u4861:
	goto	l4582
u4860:
	
l4580:	
	movlw	(0F0h)
	movwf	(??_desenhar_relogio_analogico+0)+0
	movf	(desenhar_relogio_analogico@minuto),w
	addlw	_telaHF&0ffh
	movwf	fsr0
	movf	(??_desenhar_relogio_analogico+0)+0,w
	bcf	status, 7	;select IRP bank1
	iorwf	indf,f
	goto	l4584
	line	399
	
l881:	
	
l4582:	
;girador.c: 399: else telaHL[minuto-60]|=0b11110000;
	movlw	(0F0h)
	movwf	(??_desenhar_relogio_analogico+0)+0
	movf	(desenhar_relogio_analogico@minuto),w
	addlw	0C4h
	addlw	_telaHL&0ffh
	movwf	fsr0
	movf	(??_desenhar_relogio_analogico+0)+0,w
	bsf	status, 7	;select IRP bank2
	iorwf	indf,f
	goto	l4584
	
l882:	
	line	400
	
l4584:	
;girador.c: 400: if(segundo<60)telaHF[segundo]|=0b11111100;
	movlw	(03Ch)
	subwf	(desenhar_relogio_analogico@segundo),w
	skipnc
	goto	u4871
	goto	u4870
u4871:
	goto	l4588
u4870:
	
l4586:	
	movlw	(0FCh)
	movwf	(??_desenhar_relogio_analogico+0)+0
	movf	(desenhar_relogio_analogico@segundo),w
	addlw	_telaHF&0ffh
	movwf	fsr0
	movf	(??_desenhar_relogio_analogico+0)+0,w
	bcf	status, 7	;select IRP bank1
	iorwf	indf,f
	goto	l885
	line	401
	
l883:	
	
l4588:	
;girador.c: 401: else telaHL[segundo-60]|=0b11111100;
	movlw	(0FCh)
	movwf	(??_desenhar_relogio_analogico+0)+0
	movf	(desenhar_relogio_analogico@segundo),w
	addlw	0C4h
	addlw	_telaHL&0ffh
	movwf	fsr0
	movf	(??_desenhar_relogio_analogico+0)+0,w
	bsf	status, 7	;select IRP bank2
	iorwf	indf,f
	goto	l885
	
l884:	
	line	402
	
l885:	
	return
	opt stack 0
GLOBAL	__end_of_desenhar_relogio_analogico
	__end_of_desenhar_relogio_analogico:
;; =============== function _desenhar_relogio_analogico ends ============

	signat	_desenhar_relogio_analogico,88
	global	_ponto
psect	text374,local,class=CODE,delta=2
global __ptext374
__ptext374:

;; *************** function _ponto *****************
;; Defined at:
;;		line 22 in file "C:\Users\Felipe\Desktop\GIRADOR+IR\girador-soft\girador.c"
;; Parameters:    Size  Location     Type
;;  x               1    wreg     unsigned char 
;;  y               1   15[BANK0 ] unsigned char 
;;  aceso           1   16[BANK0 ] unsigned char 
;; Auto vars:     Size  Location     Type
;;  x               1   30[BANK0 ] unsigned char 
;;  raiz            2   32[BANK0 ] unsigned int 
;;  ang             1   31[BANK0 ] unsigned char 
;;  bits            1   29[BANK0 ] unsigned char 
;;  parity          1   28[BANK0 ] unsigned char 
;;  up              1   27[BANK0 ] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, btemp+1, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       2       0       0       0
;;      Locals:         0       7       0       0       0
;;      Temps:          0      10       0       0       0
;;      Totals:         0      19       0       0       0
;;Total ram usage:       19 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		___wmul
;;		___awdiv
;; This function is called by:
;;		_linha
;;		_desenhar_numero
;;		_mostrar_caractere
;; This function uses a non-reentrant model
;;
psect	text374
	file	"C:\Users\Felipe\Desktop\GIRADOR+IR\girador-soft\girador.c"
	line	22
	global	__size_of_ponto
	__size_of_ponto	equ	__end_of_ponto-_ponto
	
_ponto:	
	opt	stack 3
; Regs used in _ponto: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
;ponto@x stored from wreg
	line	26
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(ponto@x)
	
l4234:	
;girador.c: 23: unsigned int raiz;
;girador.c: 24: char bits, parity, up, ang;
;girador.c: 26: parity = 0;
	clrf	(ponto@parity)
	line	27
	
l4236:	
;girador.c: 27: if(x>0b10000000){x=-x;parity=0b00001111;}
	movlw	(081h)
	subwf	(ponto@x),w
	skipc
	goto	u4181
	goto	u4180
u4181:
	goto	l4242
u4180:
	
l4238:	
	comf	(ponto@x),f
	incf	(ponto@x),f
	
l4240:	
	movlw	(0Fh)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	movwf	(ponto@parity)
	goto	l4242
	
l721:	
	line	28
	
l4242:	
;girador.c: 28: if(y>0b10000000){y=-y;parity|=0b11110000;}
	movlw	(081h)
	subwf	(ponto@y),w
	skipc
	goto	u4191
	goto	u4190
u4191:
	goto	l4248
u4190:
	
l4244:	
	comf	(ponto@y),f
	incf	(ponto@y),f
	
l4246:	
	movlw	(0F0h)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	iorwf	(ponto@parity),f
	goto	l4248
	
l722:	
	line	30
	
l4248:	
;girador.c: 30: raiz = x*x+y*y;
	movf	(ponto@x),w
	movwf	(??_ponto+0)+0
	clrf	(??_ponto+0)+0+1
	movf	0+(??_ponto+0)+0,w
	movwf	(?___wmul)
	movf	1+(??_ponto+0)+0,w
	movwf	(?___wmul+1)
	movf	(ponto@x),w
	movwf	(??_ponto+2)+0
	clrf	(??_ponto+2)+0+1
	movf	0+(??_ponto+2)+0,w
	movwf	0+(?___wmul)+02h
	movf	1+(??_ponto+2)+0,w
	movwf	1+(?___wmul)+02h
	fcall	___wmul
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(0+?___wmul),w
	movwf	(??_ponto+4)+0
	movf	(1+?___wmul),w
	movwf	((??_ponto+4)+0+1)
	movf	(ponto@y),w
	movwf	(??_ponto+6)+0
	clrf	(??_ponto+6)+0+1
	movf	0+(??_ponto+6)+0,w
	movwf	(?___wmul)
	movf	1+(??_ponto+6)+0,w
	movwf	(?___wmul+1)
	movf	(ponto@y),w
	movwf	(??_ponto+8)+0
	clrf	(??_ponto+8)+0+1
	movf	0+(??_ponto+8)+0,w
	movwf	0+(?___wmul)+02h
	movf	1+(??_ponto+8)+0,w
	movwf	1+(?___wmul)+02h
	fcall	___wmul
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(0+(?___wmul)),w
	addwf	0+(??_ponto+4)+0,w
	movwf	(ponto@raiz)
	movf	(1+(?___wmul)),w
	skipnc
	incf	(1+(?___wmul)),w
	addwf	1+(??_ponto+4)+0,w
	movwf	1+(ponto@raiz)
	line	31
	
l4250:	
;girador.c: 31: if(raiz==0)return;
	movf	((ponto@raiz+1)),w
	iorwf	((ponto@raiz)),w
	skipz
	goto	u4201
	goto	u4200
u4201:
	goto	l4256
u4200:
	goto	l724
	
l4252:	
	goto	l724
	
l4254:	
	goto	l4320
	line	32
	
l723:	
	
l4256:	
;girador.c: 32: else if(raiz<=1)bits=0b10000000;
	movlw	high(02h)
	subwf	(ponto@raiz+1),w
	movlw	low(02h)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4211
	goto	u4210
u4211:
	goto	l4260
u4210:
	
l4258:	
	movlw	(080h)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	movwf	(ponto@bits)
	goto	l4320
	line	33
	
l726:	
	
l4260:	
;girador.c: 33: else if(raiz<=4)bits=0b01000000;
	movlw	high(05h)
	subwf	(ponto@raiz+1),w
	movlw	low(05h)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4221
	goto	u4220
u4221:
	goto	l4264
u4220:
	
l4262:	
	movlw	(040h)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	movwf	(ponto@bits)
	goto	l4320
	line	34
	
l728:	
	
l4264:	
;girador.c: 34: else if(raiz<=9)bits=0b00100000;
	movlw	high(0Ah)
	subwf	(ponto@raiz+1),w
	movlw	low(0Ah)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4231
	goto	u4230
u4231:
	goto	l4268
u4230:
	
l4266:	
	movlw	(020h)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	movwf	(ponto@bits)
	goto	l4320
	line	35
	
l730:	
	
l4268:	
;girador.c: 35: else if(raiz<=16)bits=0b00010000;
	movlw	high(011h)
	subwf	(ponto@raiz+1),w
	movlw	low(011h)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4241
	goto	u4240
u4241:
	goto	l4272
u4240:
	
l4270:	
	movlw	(010h)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	movwf	(ponto@bits)
	goto	l4320
	line	36
	
l732:	
	
l4272:	
;girador.c: 36: else if(raiz<=25)bits=0b00001000;
	movlw	high(01Ah)
	subwf	(ponto@raiz+1),w
	movlw	low(01Ah)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4251
	goto	u4250
u4251:
	goto	l4276
u4250:
	
l4274:	
	movlw	(08h)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	movwf	(ponto@bits)
	goto	l4320
	line	37
	
l734:	
	
l4276:	
;girador.c: 37: else if(raiz<=36)bits=0b00000100;
	movlw	high(025h)
	subwf	(ponto@raiz+1),w
	movlw	low(025h)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4261
	goto	u4260
u4261:
	goto	l4280
u4260:
	
l4278:	
	movlw	(04h)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	movwf	(ponto@bits)
	goto	l4320
	line	38
	
l736:	
	
l4280:	
;girador.c: 38: else if(raiz<=49)bits=0b00000010;
	movlw	high(032h)
	subwf	(ponto@raiz+1),w
	movlw	low(032h)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4271
	goto	u4270
u4271:
	goto	l4284
u4270:
	
l4282:	
	movlw	(02h)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	movwf	(ponto@bits)
	goto	l4320
	line	39
	
l738:	
	
l4284:	
;girador.c: 39: else if(raiz<=64)bits=0b00000001;
	movlw	high(041h)
	subwf	(ponto@raiz+1),w
	movlw	low(041h)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4281
	goto	u4280
u4281:
	goto	l4288
u4280:
	
l4286:	
	clrf	(ponto@bits)
	bsf	status,0
	rlf	(ponto@bits),f
	goto	l4320
	line	40
	
l740:	
	
l4288:	
;girador.c: 40: else if(raiz<=81)bits=0b10000000;
	movlw	high(052h)
	subwf	(ponto@raiz+1),w
	movlw	low(052h)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4291
	goto	u4290
u4291:
	goto	l4292
u4290:
	
l4290:	
	movlw	(080h)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	movwf	(ponto@bits)
	goto	l4320
	line	41
	
l742:	
	
l4292:	
;girador.c: 41: else if(raiz<=100)bits=0b01000000;
	movlw	high(065h)
	subwf	(ponto@raiz+1),w
	movlw	low(065h)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4301
	goto	u4300
u4301:
	goto	l4296
u4300:
	
l4294:	
	movlw	(040h)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	movwf	(ponto@bits)
	goto	l4320
	line	42
	
l744:	
	
l4296:	
;girador.c: 42: else if(raiz<=121)bits=0b00100000;
	movlw	high(07Ah)
	subwf	(ponto@raiz+1),w
	movlw	low(07Ah)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4311
	goto	u4310
u4311:
	goto	l4300
u4310:
	
l4298:	
	movlw	(020h)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	movwf	(ponto@bits)
	goto	l4320
	line	43
	
l746:	
	
l4300:	
;girador.c: 43: else if(raiz<=144)bits=0b00010000;
	movlw	high(091h)
	subwf	(ponto@raiz+1),w
	movlw	low(091h)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4321
	goto	u4320
u4321:
	goto	l4304
u4320:
	
l4302:	
	movlw	(010h)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	movwf	(ponto@bits)
	goto	l4320
	line	44
	
l748:	
	
l4304:	
;girador.c: 44: else if(raiz<=169)bits=0b00001000;
	movlw	high(0AAh)
	subwf	(ponto@raiz+1),w
	movlw	low(0AAh)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4331
	goto	u4330
u4331:
	goto	l4308
u4330:
	
l4306:	
	movlw	(08h)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	movwf	(ponto@bits)
	goto	l4320
	line	45
	
l750:	
	
l4308:	
;girador.c: 45: else if(raiz<=196)bits=0b00000100;
	movlw	high(0C5h)
	subwf	(ponto@raiz+1),w
	movlw	low(0C5h)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4341
	goto	u4340
u4341:
	goto	l4312
u4340:
	
l4310:	
	movlw	(04h)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	movwf	(ponto@bits)
	goto	l4320
	line	46
	
l752:	
	
l4312:	
;girador.c: 46: else if(raiz<=225)bits=0b00000010;
	movlw	high(0E2h)
	subwf	(ponto@raiz+1),w
	movlw	low(0E2h)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4351
	goto	u4350
u4351:
	goto	l4316
u4350:
	
l4314:	
	movlw	(02h)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	movwf	(ponto@bits)
	goto	l4320
	line	47
	
l754:	
	
l4316:	
;girador.c: 47: else if(raiz<=256)bits=0b00000001;
	movlw	high(0101h)
	subwf	(ponto@raiz+1),w
	movlw	low(0101h)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4361
	goto	u4360
u4361:
	goto	l724
u4360:
	
l4318:	
	clrf	(ponto@bits)
	bsf	status,0
	rlf	(ponto@bits),f
	goto	l4320
	line	48
	
l756:	
;girador.c: 48: else return;
	goto	l724
	
l757:	
	goto	l4320
	
l755:	
	goto	l4320
	
l753:	
	goto	l4320
	
l751:	
	goto	l4320
	
l749:	
	goto	l4320
	
l747:	
	goto	l4320
	
l745:	
	goto	l4320
	
l743:	
	goto	l4320
	
l741:	
	goto	l4320
	
l739:	
	goto	l4320
	
l737:	
	goto	l4320
	
l735:	
	goto	l4320
	
l733:	
	goto	l4320
	
l731:	
	goto	l4320
	
l729:	
	goto	l4320
	
l727:	
	goto	l4320
	
l725:	
	line	49
	
l4320:	
;girador.c: 49: if(raiz>64)up = 1;
	movlw	high(041h)
	subwf	(ponto@raiz+1),w
	movlw	low(041h)
	skipnz
	subwf	(ponto@raiz),w
	skipc
	goto	u4371
	goto	u4370
u4371:
	goto	l758
u4370:
	
l4322:	
	clrf	(ponto@up)
	bsf	status,0
	rlf	(ponto@up),f
	goto	l4324
	line	50
	
l758:	
;girador.c: 50: else up = 0;
	clrf	(ponto@up)
	goto	l4324
	
l759:	
	line	52
	
l4324:	
;girador.c: 52: if(x==0 || y==0){
	movf	(ponto@x),w
	skipz
	goto	u4380
	goto	l4328
u4380:
	
l4326:	
	movf	(ponto@y),f
	skipz
	goto	u4391
	goto	u4390
u4391:
	goto	l4342
u4390:
	goto	l4328
	
l762:	
	line	53
	
l4328:	
;girador.c: 53: if(x==0){
	movf	(ponto@x),f
	skipz
	goto	u4401
	goto	u4400
u4401:
	goto	l4336
u4400:
	line	54
	
l4330:	
;girador.c: 54: if(parity==0)ang=30;
	movf	(ponto@parity),f
	skipz
	goto	u4411
	goto	u4410
u4411:
	goto	l4334
u4410:
	
l4332:	
	movlw	(01Eh)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	movwf	(ponto@ang)
	goto	l4482
	line	55
	
l764:	
	
l4334:	
;girador.c: 55: else ang=90;
	movlw	(05Ah)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	movwf	(ponto@ang)
	goto	l4482
	
l765:	
	line	56
;girador.c: 56: }else{
	goto	l4482
	
l763:	
	line	57
	
l4336:	
;girador.c: 57: if(parity==0)ang=0;
	movf	(ponto@parity),f
	skipz
	goto	u4421
	goto	u4420
u4421:
	goto	l4340
u4420:
	
l4338:	
	clrf	(ponto@ang)
	goto	l4482
	line	58
	
l767:	
	
l4340:	
;girador.c: 58: else ang=60;
	movlw	(03Ch)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	movwf	(ponto@ang)
	goto	l4482
	
l768:	
	goto	l4482
	line	59
	
l766:	
	line	60
;girador.c: 59: }
;girador.c: 60: }else{
	goto	l4482
	
l760:	
	line	61
	
l4342:	
;girador.c: 61: if(parity==0b00000000){
	movf	(ponto@parity),f
	skipz
	goto	u4431
	goto	u4430
u4431:
	goto	l4348
u4430:
	line	62
	
l4344:	
;girador.c: 62: ang = 0;
	clrf	(ponto@ang)
	line	63
	
l4346:	
;girador.c: 63: raiz = (y<<8)/x;
	movf	(ponto@x),w
	movwf	(??_ponto+0)+0
	clrf	(??_ponto+0)+0+1
	movf	0+(??_ponto+0)+0,w
	movwf	(?___awdiv)
	movf	1+(??_ponto+0)+0,w
	movwf	(?___awdiv+1)
	movf	(ponto@y),w
	movwf	(??_ponto+2)+0
	clrf	(??_ponto+2)+0+1
	movf	(??_ponto+2)+0,w
	movwf	(??_ponto+2)+1
	clrf	(??_ponto+2)+0
	movf	0+(??_ponto+2)+0,w
	movwf	0+(?___awdiv)+02h
	movf	1+(??_ponto+2)+0,w
	movwf	1+(?___awdiv)+02h
	fcall	___awdiv
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(1+(?___awdiv)),w
	clrf	(ponto@raiz+1)
	addwf	(ponto@raiz+1)
	movf	(0+(?___awdiv)),w
	clrf	(ponto@raiz)
	addwf	(ponto@raiz)

	line	64
;girador.c: 64: }else if(parity==0b00001111){
	goto	l4364
	
l770:	
	
l4348:	
	movf	(ponto@parity),w
	xorlw	0Fh
	skipz
	goto	u4441
	goto	u4440
u4441:
	goto	l4354
u4440:
	line	65
	
l4350:	
;girador.c: 65: ang = 30;
	movlw	(01Eh)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	movwf	(ponto@ang)
	line	66
	
l4352:	
;girador.c: 66: raiz = (x<<8)/y;
	movf	(ponto@y),w
	movwf	(??_ponto+0)+0
	clrf	(??_ponto+0)+0+1
	movf	0+(??_ponto+0)+0,w
	movwf	(?___awdiv)
	movf	1+(??_ponto+0)+0,w
	movwf	(?___awdiv+1)
	movf	(ponto@x),w
	movwf	(??_ponto+2)+0
	clrf	(??_ponto+2)+0+1
	movf	(??_ponto+2)+0,w
	movwf	(??_ponto+2)+1
	clrf	(??_ponto+2)+0
	movf	0+(??_ponto+2)+0,w
	movwf	0+(?___awdiv)+02h
	movf	1+(??_ponto+2)+0,w
	movwf	1+(?___awdiv)+02h
	fcall	___awdiv
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(1+(?___awdiv)),w
	clrf	(ponto@raiz+1)
	addwf	(ponto@raiz+1)
	movf	(0+(?___awdiv)),w
	clrf	(ponto@raiz)
	addwf	(ponto@raiz)

	line	67
;girador.c: 67: }else if(parity==0b11111111){
	goto	l4364
	
l772:	
	
l4354:	
	movf	(ponto@parity),w
	xorlw	0FFh
	skipz
	goto	u4451
	goto	u4450
u4451:
	goto	l4360
u4450:
	line	68
	
l4356:	
;girador.c: 68: ang = 60;
	movlw	(03Ch)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	movwf	(ponto@ang)
	line	69
	
l4358:	
;girador.c: 69: raiz = (y<<8)/x;
	movf	(ponto@x),w
	movwf	(??_ponto+0)+0
	clrf	(??_ponto+0)+0+1
	movf	0+(??_ponto+0)+0,w
	movwf	(?___awdiv)
	movf	1+(??_ponto+0)+0,w
	movwf	(?___awdiv+1)
	movf	(ponto@y),w
	movwf	(??_ponto+2)+0
	clrf	(??_ponto+2)+0+1
	movf	(??_ponto+2)+0,w
	movwf	(??_ponto+2)+1
	clrf	(??_ponto+2)+0
	movf	0+(??_ponto+2)+0,w
	movwf	0+(?___awdiv)+02h
	movf	1+(??_ponto+2)+0,w
	movwf	1+(?___awdiv)+02h
	fcall	___awdiv
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(1+(?___awdiv)),w
	clrf	(ponto@raiz+1)
	addwf	(ponto@raiz+1)
	movf	(0+(?___awdiv)),w
	clrf	(ponto@raiz)
	addwf	(ponto@raiz)

	line	70
;girador.c: 70: }else{
	goto	l4364
	
l774:	
	line	71
	
l4360:	
;girador.c: 71: ang = 90;
	movlw	(05Ah)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	movwf	(ponto@ang)
	line	72
	
l4362:	
;girador.c: 72: raiz = (x<<8)/y;
	movf	(ponto@y),w
	movwf	(??_ponto+0)+0
	clrf	(??_ponto+0)+0+1
	movf	0+(??_ponto+0)+0,w
	movwf	(?___awdiv)
	movf	1+(??_ponto+0)+0,w
	movwf	(?___awdiv+1)
	movf	(ponto@x),w
	movwf	(??_ponto+2)+0
	clrf	(??_ponto+2)+0+1
	movf	(??_ponto+2)+0,w
	movwf	(??_ponto+2)+1
	clrf	(??_ponto+2)+0
	movf	0+(??_ponto+2)+0,w
	movwf	0+(?___awdiv)+02h
	movf	1+(??_ponto+2)+0,w
	movwf	1+(?___awdiv)+02h
	fcall	___awdiv
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(1+(?___awdiv)),w
	clrf	(ponto@raiz+1)
	addwf	(ponto@raiz+1)
	movf	(0+(?___awdiv)),w
	clrf	(ponto@raiz)
	addwf	(ponto@raiz)

	goto	l4364
	line	73
	
l775:	
	goto	l4364
	
l773:	
	goto	l4364
	
l771:	
	line	74
	
l4364:	
;girador.c: 73: }
;girador.c: 74: if(raiz<7);
	movlw	high(07h)
	subwf	(ponto@raiz+1),w
	movlw	low(07h)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4461
	goto	u4460
u4461:
	goto	l4368
u4460:
	goto	l4482
	
l4366:	
	goto	l4482
	line	75
	
l776:	
	
l4368:	
;girador.c: 75: else if(raiz<20)ang++;
	movlw	high(014h)
	subwf	(ponto@raiz+1),w
	movlw	low(014h)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4471
	goto	u4470
u4471:
	goto	l4372
u4470:
	
l4370:	
	movlw	(01h)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	addwf	(ponto@ang),f
	goto	l4482
	line	76
	
l778:	
	
l4372:	
;girador.c: 76: else if(raiz<34)ang+=2;
	movlw	high(022h)
	subwf	(ponto@raiz+1),w
	movlw	low(022h)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4481
	goto	u4480
u4481:
	goto	l4376
u4480:
	
l4374:	
	movlw	(02h)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	addwf	(ponto@ang),f
	goto	l4482
	line	77
	
l780:	
	
l4376:	
;girador.c: 77: else if(raiz<47)ang+=3;
	movlw	high(02Fh)
	subwf	(ponto@raiz+1),w
	movlw	low(02Fh)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4491
	goto	u4490
u4491:
	goto	l4380
u4490:
	
l4378:	
	movlw	(03h)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	addwf	(ponto@ang),f
	goto	l4482
	line	78
	
l782:	
	
l4380:	
;girador.c: 78: else if(raiz<62)ang+=4;
	movlw	high(03Eh)
	subwf	(ponto@raiz+1),w
	movlw	low(03Eh)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4501
	goto	u4500
u4501:
	goto	l4384
u4500:
	
l4382:	
	movlw	(04h)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	addwf	(ponto@ang),f
	goto	l4482
	line	79
	
l784:	
	
l4384:	
;girador.c: 79: else if(raiz<76)ang+=5;
	movlw	high(04Ch)
	subwf	(ponto@raiz+1),w
	movlw	low(04Ch)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4511
	goto	u4510
u4511:
	goto	l4388
u4510:
	
l4386:	
	movlw	(05h)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	addwf	(ponto@ang),f
	goto	l4482
	line	80
	
l786:	
	
l4388:	
;girador.c: 80: else if(raiz<91)ang+=6;
	movlw	high(05Bh)
	subwf	(ponto@raiz+1),w
	movlw	low(05Bh)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4521
	goto	u4520
u4521:
	goto	l4392
u4520:
	
l4390:	
	movlw	(06h)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	addwf	(ponto@ang),f
	goto	l4482
	line	81
	
l788:	
	
l4392:	
;girador.c: 81: else if(raiz<106)ang+=7;
	movlw	high(06Ah)
	subwf	(ponto@raiz+1),w
	movlw	low(06Ah)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4531
	goto	u4530
u4531:
	goto	l4396
u4530:
	
l4394:	
	movlw	(07h)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	addwf	(ponto@ang),f
	goto	l4482
	line	82
	
l790:	
	
l4396:	
;girador.c: 82: else if(raiz<122)ang+=8;
	movlw	high(07Ah)
	subwf	(ponto@raiz+1),w
	movlw	low(07Ah)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4541
	goto	u4540
u4541:
	goto	l4400
u4540:
	
l4398:	
	movlw	(08h)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	addwf	(ponto@ang),f
	goto	l4482
	line	83
	
l792:	
	
l4400:	
;girador.c: 83: else if(raiz<139)ang+=9;
	movlw	high(08Bh)
	subwf	(ponto@raiz+1),w
	movlw	low(08Bh)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4551
	goto	u4550
u4551:
	goto	l4404
u4550:
	
l4402:	
	movlw	(09h)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	addwf	(ponto@ang),f
	goto	l4482
	line	84
	
l794:	
	
l4404:	
;girador.c: 84: else if(raiz<157)ang+=10;
	movlw	high(09Dh)
	subwf	(ponto@raiz+1),w
	movlw	low(09Dh)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4561
	goto	u4560
u4561:
	goto	l4408
u4560:
	
l4406:	
	movlw	(0Ah)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	addwf	(ponto@ang),f
	goto	l4482
	line	85
	
l796:	
	
l4408:	
;girador.c: 85: else if(raiz<176)ang+=11;
	movlw	high(0B0h)
	subwf	(ponto@raiz+1),w
	movlw	low(0B0h)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4571
	goto	u4570
u4571:
	goto	l4412
u4570:
	
l4410:	
	movlw	(0Bh)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	addwf	(ponto@ang),f
	goto	l4482
	line	86
	
l798:	
	
l4412:	
;girador.c: 86: else if(raiz<197)ang+=12;
	movlw	high(0C5h)
	subwf	(ponto@raiz+1),w
	movlw	low(0C5h)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4581
	goto	u4580
u4581:
	goto	l4416
u4580:
	
l4414:	
	movlw	(0Ch)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	addwf	(ponto@ang),f
	goto	l4482
	line	87
	
l800:	
	
l4416:	
;girador.c: 87: else if(raiz<219)ang+=13;
	movlw	high(0DBh)
	subwf	(ponto@raiz+1),w
	movlw	low(0DBh)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4591
	goto	u4590
u4591:
	goto	l4420
u4590:
	
l4418:	
	movlw	(0Dh)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	addwf	(ponto@ang),f
	goto	l4482
	line	88
	
l802:	
	
l4420:	
;girador.c: 88: else if(raiz<243)ang+=14;
	movlw	high(0F3h)
	subwf	(ponto@raiz+1),w
	movlw	low(0F3h)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4601
	goto	u4600
u4601:
	goto	l4424
u4600:
	
l4422:	
	movlw	(0Eh)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	addwf	(ponto@ang),f
	goto	l4482
	line	89
	
l804:	
	
l4424:	
;girador.c: 89: else if(raiz<270)ang+=15;
	movlw	high(010Eh)
	subwf	(ponto@raiz+1),w
	movlw	low(010Eh)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4611
	goto	u4610
u4611:
	goto	l4428
u4610:
	
l4426:	
	movlw	(0Fh)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	addwf	(ponto@ang),f
	goto	l4482
	line	90
	
l806:	
	
l4428:	
;girador.c: 90: else if(raiz<300)ang+=16;
	movlw	high(012Ch)
	subwf	(ponto@raiz+1),w
	movlw	low(012Ch)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4621
	goto	u4620
u4621:
	goto	l4432
u4620:
	
l4430:	
	movlw	(010h)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	addwf	(ponto@ang),f
	goto	l4482
	line	91
	
l808:	
	
l4432:	
;girador.c: 91: else if(raiz<334)ang+=17;
	movlw	high(014Eh)
	subwf	(ponto@raiz+1),w
	movlw	low(014Eh)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4631
	goto	u4630
u4631:
	goto	l4436
u4630:
	
l4434:	
	movlw	(011h)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	addwf	(ponto@ang),f
	goto	l4482
	line	92
	
l810:	
	
l4436:	
;girador.c: 92: else if(raiz<373)ang+=18;
	movlw	high(0175h)
	subwf	(ponto@raiz+1),w
	movlw	low(0175h)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4641
	goto	u4640
u4641:
	goto	l4440
u4640:
	
l4438:	
	movlw	(012h)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	addwf	(ponto@ang),f
	goto	l4482
	line	93
	
l812:	
	
l4440:	
;girador.c: 93: else if(raiz<418)ang+=19;
	movlw	high(01A2h)
	subwf	(ponto@raiz+1),w
	movlw	low(01A2h)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4651
	goto	u4650
u4651:
	goto	l4444
u4650:
	
l4442:	
	movlw	(013h)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	addwf	(ponto@ang),f
	goto	l4482
	line	94
	
l814:	
	
l4444:	
;girador.c: 94: else if(raiz<471)ang+=20;
	movlw	high(01D7h)
	subwf	(ponto@raiz+1),w
	movlw	low(01D7h)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4661
	goto	u4660
u4661:
	goto	l4448
u4660:
	
l4446:	
	movlw	(014h)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	addwf	(ponto@ang),f
	goto	l4482
	line	95
	
l816:	
	
l4448:	
;girador.c: 95: else if(raiz<537)ang+=21;
	movlw	high(0219h)
	subwf	(ponto@raiz+1),w
	movlw	low(0219h)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4671
	goto	u4670
u4671:
	goto	l4452
u4670:
	
l4450:	
	movlw	(015h)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	addwf	(ponto@ang),f
	goto	l4482
	line	96
	
l818:	
	
l4452:	
;girador.c: 96: else if(raiz<618)ang+=22;
	movlw	high(026Ah)
	subwf	(ponto@raiz+1),w
	movlw	low(026Ah)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4681
	goto	u4680
u4681:
	goto	l4456
u4680:
	
l4454:	
	movlw	(016h)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	addwf	(ponto@ang),f
	goto	l4482
	line	97
	
l820:	
	
l4456:	
;girador.c: 97: else if(raiz<723)ang+=23;
	movlw	high(02D3h)
	subwf	(ponto@raiz+1),w
	movlw	low(02D3h)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4691
	goto	u4690
u4691:
	goto	l4460
u4690:
	
l4458:	
	movlw	(017h)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	addwf	(ponto@ang),f
	goto	l4482
	line	98
	
l822:	
	
l4460:	
;girador.c: 98: else if(raiz<864)ang+=24;
	movlw	high(0360h)
	subwf	(ponto@raiz+1),w
	movlw	low(0360h)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4701
	goto	u4700
u4701:
	goto	l4464
u4700:
	
l4462:	
	movlw	(018h)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	addwf	(ponto@ang),f
	goto	l4482
	line	99
	
l824:	
	
l4464:	
;girador.c: 99: else if(raiz<1066)ang+=25;
	movlw	high(042Ah)
	subwf	(ponto@raiz+1),w
	movlw	low(042Ah)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4711
	goto	u4710
u4711:
	goto	l4468
u4710:
	
l4466:	
	movlw	(019h)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	addwf	(ponto@ang),f
	goto	l4482
	line	100
	
l826:	
	
l4468:	
;girador.c: 100: else if(raiz<1381)ang+=26;
	movlw	high(0565h)
	subwf	(ponto@raiz+1),w
	movlw	low(0565h)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4721
	goto	u4720
u4721:
	goto	l4472
u4720:
	
l4470:	
	movlw	(01Ah)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	addwf	(ponto@ang),f
	goto	l4482
	line	101
	
l828:	
	
l4472:	
;girador.c: 101: else if(raiz<1945)ang+=27;
	movlw	high(0799h)
	subwf	(ponto@raiz+1),w
	movlw	low(0799h)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4731
	goto	u4730
u4731:
	goto	l4476
u4730:
	
l4474:	
	movlw	(01Bh)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	addwf	(ponto@ang),f
	goto	l4482
	line	102
	
l830:	
	
l4476:	
;girador.c: 102: else if(raiz<3253)ang+=28;
	movlw	high(0CB5h)
	subwf	(ponto@raiz+1),w
	movlw	low(0CB5h)
	skipnz
	subwf	(ponto@raiz),w
	skipnc
	goto	u4741
	goto	u4740
u4741:
	goto	l4480
u4740:
	
l4478:	
	movlw	(01Ch)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	addwf	(ponto@ang),f
	goto	l4482
	line	103
	
l832:	
	
l4480:	
;girador.c: 103: else ang+=29;
	movlw	(01Dh)
	movwf	(??_ponto+0)+0
	movf	(??_ponto+0)+0,w
	addwf	(ponto@ang),f
	goto	l4482
	
l833:	
	goto	l4482
	
l831:	
	goto	l4482
	
l829:	
	goto	l4482
	
l827:	
	goto	l4482
	
l825:	
	goto	l4482
	
l823:	
	goto	l4482
	
l821:	
	goto	l4482
	
l819:	
	goto	l4482
	
l817:	
	goto	l4482
	
l815:	
	goto	l4482
	
l813:	
	goto	l4482
	
l811:	
	goto	l4482
	
l809:	
	goto	l4482
	
l807:	
	goto	l4482
	
l805:	
	goto	l4482
	
l803:	
	goto	l4482
	
l801:	
	goto	l4482
	
l799:	
	goto	l4482
	
l797:	
	goto	l4482
	
l795:	
	goto	l4482
	
l793:	
	goto	l4482
	
l791:	
	goto	l4482
	
l789:	
	goto	l4482
	
l787:	
	goto	l4482
	
l785:	
	goto	l4482
	
l783:	
	goto	l4482
	
l781:	
	goto	l4482
	
l779:	
	goto	l4482
	
l777:	
	goto	l4482
	line	104
	
l769:	
	line	105
	
l4482:	
;girador.c: 104: }
;girador.c: 105: if(aceso){
	movf	(ponto@aceso),w
	skipz
	goto	u4750
	goto	l4494
u4750:
	line	106
	
l4484:	
;girador.c: 106: if(up){
	movf	(ponto@up),w
	skipz
	goto	u4760
	goto	l4492
u4760:
	line	107
	
l4486:	
;girador.c: 107: if(ang<60)telaHF[ang] |=bits;
	movlw	(03Ch)
	subwf	(ponto@ang),w
	skipnc
	goto	u4771
	goto	u4770
u4771:
	goto	l4490
u4770:
	
l4488:	
	movf	(ponto@bits),w
	movwf	(??_ponto+0)+0
	movf	(ponto@ang),w
	addlw	_telaHF&0ffh
	movwf	fsr0
	movf	(??_ponto+0)+0,w
	bcf	status, 7	;select IRP bank1
	iorwf	indf,f
	goto	l724
	line	108
	
l836:	
	
l4490:	
;girador.c: 108: else telaHL[ang-60]|=bits;
	movf	(ponto@bits),w
	movwf	(??_ponto+0)+0
	movf	(ponto@ang),w
	addlw	0C4h
	addlw	_telaHL&0ffh
	movwf	fsr0
	movf	(??_ponto+0)+0,w
	bsf	status, 7	;select IRP bank2
	iorwf	indf,f
	goto	l724
	
l837:	
	line	109
;girador.c: 109: }else telaL[ang>>1] |=bits;
	goto	l724
	
l835:	
	
l4492:	
	movf	(ponto@bits),w
	movwf	(??_ponto+0)+0
	movf	(ponto@ang),w
	movwf	(??_ponto+1)+0
	clrc
	rrf	(??_ponto+1)+0,w
	addlw	_telaL&0ffh
	movwf	fsr0
	movf	(??_ponto+0)+0,w
	bsf	status, 7	;select IRP bank3
	iorwf	indf,f
	goto	l724
	
l838:	
	line	110
;girador.c: 110: }else{
	goto	l724
	
l834:	
	line	111
	
l4494:	
;girador.c: 111: if(up){
	movf	(ponto@up),w
	skipz
	goto	u4780
	goto	l4502
u4780:
	line	112
	
l4496:	
;girador.c: 112: if(ang<60)telaHF[ang] &=!bits;
	movlw	(03Ch)
	subwf	(ponto@ang),w
	skipnc
	goto	u4791
	goto	u4790
u4791:
	goto	l4500
u4790:
	
l4498:	
	movf	(ponto@bits)
	movlw	0
	skipnz
	movlw	1
	movwf	(??_ponto+0)+0
	movf	(ponto@ang),w
	addlw	_telaHF&0ffh
	movwf	fsr0
	movf	(??_ponto+0)+0,w
	bcf	status, 7	;select IRP bank1
	andwf	indf,f
	goto	l724
	line	113
	
l841:	
	
l4500:	
;girador.c: 113: else telaHL[ang-60]&=!bits;
	movf	(ponto@bits)
	movlw	0
	skipnz
	movlw	1
	movwf	(??_ponto+0)+0
	movf	(ponto@ang),w
	addlw	0C4h
	addlw	_telaHL&0ffh
	movwf	fsr0
	movf	(??_ponto+0)+0,w
	bsf	status, 7	;select IRP bank2
	andwf	indf,f
	goto	l724
	
l842:	
	line	114
;girador.c: 114: }else telaL[ang>>1] &=!bits;
	goto	l724
	
l840:	
	
l4502:	
	movf	(ponto@bits)
	movlw	0
	skipnz
	movlw	1
	movwf	(??_ponto+0)+0
	movf	(ponto@ang),w
	movwf	(??_ponto+1)+0
	clrc
	rrf	(??_ponto+1)+0,w
	addlw	_telaL&0ffh
	movwf	fsr0
	movf	(??_ponto+0)+0,w
	bsf	status, 7	;select IRP bank3
	andwf	indf,f
	goto	l724
	
l843:	
	goto	l724
	line	115
	
l839:	
	line	116
	
l724:	
	return
	opt stack 0
GLOBAL	__end_of_ponto
	__end_of_ponto:
;; =============== function _ponto ends ============

	signat	_ponto,12408
	global	___awmod
psect	text375,local,class=CODE,delta=2
global __ptext375
__ptext375:

;; *************** function ___awmod *****************
;; Defined at:
;;		line 5 in file "C:\Program Files (x86)\HI-TECH Software\PICC\9.83\sources\awmod.c"
;; Parameters:    Size  Location     Type
;;  divisor         2    6[BANK0 ] int 
;;  dividend        2    8[BANK0 ] int 
;; Auto vars:     Size  Location     Type
;;  sign            1   12[BANK0 ] unsigned char 
;;  counter         1   11[BANK0 ] unsigned char 
;; Return value:  Size  Location     Type
;;                  2    6[BANK0 ] int 
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       4       0       0       0
;;      Locals:         0       2       0       0       0
;;      Temps:          0       1       0       0       0
;;      Totals:         0       7       0       0       0
;;Total ram usage:        7 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_desenhar_relogio_analogico
;;		_tentar_mostrar_expoeletrica
;;		_main
;; This function uses a non-reentrant model
;;
psect	text375
	file	"C:\Program Files (x86)\HI-TECH Software\PICC\9.83\sources\awmod.c"
	line	5
	global	__size_of___awmod
	__size_of___awmod	equ	__end_of___awmod-___awmod
	
___awmod:	
	opt	stack 5
; Regs used in ___awmod: [wreg+status,2+status,0]
	line	8
	
l4200:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(___awmod@sign)
	line	9
	btfss	(___awmod@dividend+1),7
	goto	u4091
	goto	u4090
u4091:
	goto	l4204
u4090:
	line	10
	
l4202:	
	comf	(___awmod@dividend),f
	comf	(___awmod@dividend+1),f
	incf	(___awmod@dividend),f
	skipnz
	incf	(___awmod@dividend+1),f
	line	11
	clrf	(___awmod@sign)
	bsf	status,0
	rlf	(___awmod@sign),f
	goto	l4204
	line	12
	
l1878:	
	line	13
	
l4204:	
	btfss	(___awmod@divisor+1),7
	goto	u4101
	goto	u4100
u4101:
	goto	l4208
u4100:
	line	14
	
l4206:	
	comf	(___awmod@divisor),f
	comf	(___awmod@divisor+1),f
	incf	(___awmod@divisor),f
	skipnz
	incf	(___awmod@divisor+1),f
	goto	l4208
	
l1879:	
	line	15
	
l4208:	
	movf	(___awmod@divisor+1),w
	iorwf	(___awmod@divisor),w
	skipnz
	goto	u4111
	goto	u4110
u4111:
	goto	l4226
u4110:
	line	16
	
l4210:	
	clrf	(___awmod@counter)
	bsf	status,0
	rlf	(___awmod@counter),f
	line	17
	goto	l4216
	
l1882:	
	line	18
	
l4212:	
	movlw	01h
	
u4125:
	clrc
	rlf	(___awmod@divisor),f
	rlf	(___awmod@divisor+1),f
	addlw	-1
	skipz
	goto	u4125
	line	19
	
l4214:	
	movlw	(01h)
	movwf	(??___awmod+0)+0
	movf	(??___awmod+0)+0,w
	addwf	(___awmod@counter),f
	goto	l4216
	line	20
	
l1881:	
	line	17
	
l4216:	
	btfss	(___awmod@divisor+1),(15)&7
	goto	u4131
	goto	u4130
u4131:
	goto	l4212
u4130:
	goto	l4218
	
l1883:	
	goto	l4218
	line	21
	
l1884:	
	line	22
	
l4218:	
	movf	(___awmod@divisor+1),w
	subwf	(___awmod@dividend+1),w
	skipz
	goto	u4145
	movf	(___awmod@divisor),w
	subwf	(___awmod@dividend),w
u4145:
	skipc
	goto	u4141
	goto	u4140
u4141:
	goto	l4222
u4140:
	line	23
	
l4220:	
	movf	(___awmod@divisor),w
	subwf	(___awmod@dividend),f
	movf	(___awmod@divisor+1),w
	skipc
	decf	(___awmod@dividend+1),f
	subwf	(___awmod@dividend+1),f
	goto	l4222
	
l1885:	
	line	24
	
l4222:	
	movlw	01h
	
u4155:
	clrc
	rrf	(___awmod@divisor+1),f
	rrf	(___awmod@divisor),f
	addlw	-1
	skipz
	goto	u4155
	line	25
	
l4224:	
	movlw	low(01h)
	subwf	(___awmod@counter),f
	btfss	status,2
	goto	u4161
	goto	u4160
u4161:
	goto	l4218
u4160:
	goto	l4226
	
l1886:	
	goto	l4226
	line	26
	
l1880:	
	line	27
	
l4226:	
	movf	(___awmod@sign),w
	skipz
	goto	u4170
	goto	l4230
u4170:
	line	28
	
l4228:	
	comf	(___awmod@dividend),f
	comf	(___awmod@dividend+1),f
	incf	(___awmod@dividend),f
	skipnz
	incf	(___awmod@dividend+1),f
	goto	l4230
	
l1887:	
	line	29
	
l4230:	
	movf	(___awmod@dividend+1),w
	clrf	(?___awmod+1)
	addwf	(?___awmod+1)
	movf	(___awmod@dividend),w
	clrf	(?___awmod)
	addwf	(?___awmod)

	goto	l1888
	
l4232:	
	line	30
	
l1888:	
	return
	opt stack 0
GLOBAL	__end_of___awmod
	__end_of___awmod:
;; =============== function ___awmod ends ============

	signat	___awmod,8314
	global	___awdiv
psect	text376,local,class=CODE,delta=2
global __ptext376
__ptext376:

;; *************** function ___awdiv *****************
;; Defined at:
;;		line 5 in file "C:\Program Files (x86)\HI-TECH Software\PICC\9.83\sources\awdiv.c"
;; Parameters:    Size  Location     Type
;;  divisor         2    6[BANK0 ] int 
;;  dividend        2    8[BANK0 ] int 
;; Auto vars:     Size  Location     Type
;;  quotient        2   13[BANK0 ] int 
;;  sign            1   12[BANK0 ] unsigned char 
;;  counter         1   11[BANK0 ] unsigned char 
;; Return value:  Size  Location     Type
;;                  2    6[BANK0 ] int 
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       4       0       0       0
;;      Locals:         0       4       0       0       0
;;      Temps:          0       1       0       0       0
;;      Totals:         0       9       0       0       0
;;Total ram usage:        9 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_ponto
;;		_linha
;; This function uses a non-reentrant model
;;
psect	text376
	file	"C:\Program Files (x86)\HI-TECH Software\PICC\9.83\sources\awdiv.c"
	line	5
	global	__size_of___awdiv
	__size_of___awdiv	equ	__end_of___awdiv-___awdiv
	
___awdiv:	
	opt	stack 3
; Regs used in ___awdiv: [wreg+status,2+status,0]
	line	9
	
l4160:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(___awdiv@sign)
	line	10
	btfss	(___awdiv@divisor+1),7
	goto	u3991
	goto	u3990
u3991:
	goto	l4164
u3990:
	line	11
	
l4162:	
	comf	(___awdiv@divisor),f
	comf	(___awdiv@divisor+1),f
	incf	(___awdiv@divisor),f
	skipnz
	incf	(___awdiv@divisor+1),f
	line	12
	clrf	(___awdiv@sign)
	bsf	status,0
	rlf	(___awdiv@sign),f
	goto	l4164
	line	13
	
l1810:	
	line	14
	
l4164:	
	btfss	(___awdiv@dividend+1),7
	goto	u4001
	goto	u4000
u4001:
	goto	l4170
u4000:
	line	15
	
l4166:	
	comf	(___awdiv@dividend),f
	comf	(___awdiv@dividend+1),f
	incf	(___awdiv@dividend),f
	skipnz
	incf	(___awdiv@dividend+1),f
	line	16
	
l4168:	
	movlw	(01h)
	movwf	(??___awdiv+0)+0
	movf	(??___awdiv+0)+0,w
	xorwf	(___awdiv@sign),f
	goto	l4170
	line	17
	
l1811:	
	line	18
	
l4170:	
	clrf	(___awdiv@quotient)
	clrf	(___awdiv@quotient+1)
	line	19
	
l4172:	
	movf	(___awdiv@divisor+1),w
	iorwf	(___awdiv@divisor),w
	skipnz
	goto	u4011
	goto	u4010
u4011:
	goto	l4192
u4010:
	line	20
	
l4174:	
	clrf	(___awdiv@counter)
	bsf	status,0
	rlf	(___awdiv@counter),f
	line	21
	goto	l4180
	
l1814:	
	line	22
	
l4176:	
	movlw	01h
	
u4025:
	clrc
	rlf	(___awdiv@divisor),f
	rlf	(___awdiv@divisor+1),f
	addlw	-1
	skipz
	goto	u4025
	line	23
	
l4178:	
	movlw	(01h)
	movwf	(??___awdiv+0)+0
	movf	(??___awdiv+0)+0,w
	addwf	(___awdiv@counter),f
	goto	l4180
	line	24
	
l1813:	
	line	21
	
l4180:	
	btfss	(___awdiv@divisor+1),(15)&7
	goto	u4031
	goto	u4030
u4031:
	goto	l4176
u4030:
	goto	l4182
	
l1815:	
	goto	l4182
	line	25
	
l1816:	
	line	26
	
l4182:	
	movlw	01h
	
u4045:
	clrc
	rlf	(___awdiv@quotient),f
	rlf	(___awdiv@quotient+1),f
	addlw	-1
	skipz
	goto	u4045
	line	27
	movf	(___awdiv@divisor+1),w
	subwf	(___awdiv@dividend+1),w
	skipz
	goto	u4055
	movf	(___awdiv@divisor),w
	subwf	(___awdiv@dividend),w
u4055:
	skipc
	goto	u4051
	goto	u4050
u4051:
	goto	l4188
u4050:
	line	28
	
l4184:	
	movf	(___awdiv@divisor),w
	subwf	(___awdiv@dividend),f
	movf	(___awdiv@divisor+1),w
	skipc
	decf	(___awdiv@dividend+1),f
	subwf	(___awdiv@dividend+1),f
	line	29
	
l4186:	
	bsf	(___awdiv@quotient)+(0/8),(0)&7
	goto	l4188
	line	30
	
l1817:	
	line	31
	
l4188:	
	movlw	01h
	
u4065:
	clrc
	rrf	(___awdiv@divisor+1),f
	rrf	(___awdiv@divisor),f
	addlw	-1
	skipz
	goto	u4065
	line	32
	
l4190:	
	movlw	low(01h)
	subwf	(___awdiv@counter),f
	btfss	status,2
	goto	u4071
	goto	u4070
u4071:
	goto	l4182
u4070:
	goto	l4192
	
l1818:	
	goto	l4192
	line	33
	
l1812:	
	line	34
	
l4192:	
	movf	(___awdiv@sign),w
	skipz
	goto	u4080
	goto	l4196
u4080:
	line	35
	
l4194:	
	comf	(___awdiv@quotient),f
	comf	(___awdiv@quotient+1),f
	incf	(___awdiv@quotient),f
	skipnz
	incf	(___awdiv@quotient+1),f
	goto	l4196
	
l1819:	
	line	36
	
l4196:	
	movf	(___awdiv@quotient+1),w
	clrf	(?___awdiv+1)
	addwf	(?___awdiv+1)
	movf	(___awdiv@quotient),w
	clrf	(?___awdiv)
	addwf	(?___awdiv)

	goto	l1820
	
l4198:	
	line	37
	
l1820:	
	return
	opt stack 0
GLOBAL	__end_of___awdiv
	__end_of___awdiv:
;; =============== function ___awdiv ends ============

	signat	___awdiv,8314
	global	___wmul
psect	text377,local,class=CODE,delta=2
global __ptext377
__ptext377:

;; *************** function ___wmul *****************
;; Defined at:
;;		line 3 in file "C:\Program Files (x86)\HI-TECH Software\PICC\9.83\sources\wmul.c"
;; Parameters:    Size  Location     Type
;;  multiplier      2    0[BANK0 ] unsigned int 
;;  multiplicand    2    2[BANK0 ] unsigned int 
;; Auto vars:     Size  Location     Type
;;  product         2    4[BANK0 ] unsigned int 
;; Return value:  Size  Location     Type
;;                  2    0[BANK0 ] unsigned int 
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       4       0       0       0
;;      Locals:         0       2       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       6       0       0       0
;;Total ram usage:        6 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_ponto
;;		_linha
;;		_desenhar_relogio_analogico
;; This function uses a non-reentrant model
;;
psect	text377
	file	"C:\Program Files (x86)\HI-TECH Software\PICC\9.83\sources\wmul.c"
	line	3
	global	__size_of___wmul
	__size_of___wmul	equ	__end_of___wmul-___wmul
	
___wmul:	
	opt	stack 3
; Regs used in ___wmul: [wreg+status,2+status,0]
	line	4
	
l4148:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(___wmul@product)
	clrf	(___wmul@product+1)
	goto	l4150
	line	6
	
l1670:	
	line	7
	
l4150:	
	btfss	(___wmul@multiplier),(0)&7
	goto	u3951
	goto	u3950
u3951:
	goto	l1671
u3950:
	line	8
	
l4152:	
	movf	(___wmul@multiplicand),w
	addwf	(___wmul@product),f
	skipnc
	incf	(___wmul@product+1),f
	movf	(___wmul@multiplicand+1),w
	addwf	(___wmul@product+1),f
	
l1671:	
	line	9
	movlw	01h
	
u3965:
	clrc
	rlf	(___wmul@multiplicand),f
	rlf	(___wmul@multiplicand+1),f
	addlw	-1
	skipz
	goto	u3965
	line	10
	
l4154:	
	movlw	01h
	
u3975:
	clrc
	rrf	(___wmul@multiplier+1),f
	rrf	(___wmul@multiplier),f
	addlw	-1
	skipz
	goto	u3975
	line	11
	movf	((___wmul@multiplier+1)),w
	iorwf	((___wmul@multiplier)),w
	skipz
	goto	u3981
	goto	u3980
u3981:
	goto	l4150
u3980:
	goto	l4156
	
l1672:	
	line	12
	
l4156:	
	movf	(___wmul@product+1),w
	clrf	(?___wmul+1)
	addwf	(?___wmul+1)
	movf	(___wmul@product),w
	clrf	(?___wmul)
	addwf	(?___wmul)

	goto	l1673
	
l4158:	
	line	13
	
l1673:	
	return
	opt stack 0
GLOBAL	__end_of___wmul
	__end_of___wmul:
;; =============== function ___wmul ends ============

	signat	___wmul,8314
	global	___bmul
psect	text378,local,class=CODE,delta=2
global __ptext378
__ptext378:

;; *************** function ___bmul *****************
;; Defined at:
;;		line 3 in file "C:\Program Files (x86)\HI-TECH Software\PICC\9.83\sources\bmul.c"
;; Parameters:    Size  Location     Type
;;  multiplier      1    wreg     unsigned char 
;;  multiplicand    1   13[BANK0 ] unsigned char 
;; Auto vars:     Size  Location     Type
;;  multiplier      1   16[BANK0 ] unsigned char 
;;  product         1   15[BANK0 ] unsigned char 
;; Return value:  Size  Location     Type
;;                  1    wreg      unsigned char 
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       1       0       0       0
;;      Locals:         0       2       0       0       0
;;      Temps:          0       1       0       0       0
;;      Totals:         0       4       0       0       0
;;Total ram usage:        4 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_desenhar_relogio_analogico
;; This function uses a non-reentrant model
;;
psect	text378
	file	"C:\Program Files (x86)\HI-TECH Software\PICC\9.83\sources\bmul.c"
	line	3
	global	__size_of___bmul
	__size_of___bmul	equ	__end_of___bmul-___bmul
	
___bmul:	
	opt	stack 5
; Regs used in ___bmul: [wreg+status,2+status,0]
;___bmul@multiplier stored from wreg
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(___bmul@multiplier)
	line	4
	
l4134:	
	clrf	(___bmul@product)
	line	6
	
l1664:	
	line	7
	btfss	(___bmul@multiplier),(0)&7
	goto	u3931
	goto	u3930
u3931:
	goto	l4138
u3930:
	line	8
	
l4136:	
	movf	(___bmul@multiplicand),w
	movwf	(??___bmul+0)+0
	movf	(??___bmul+0)+0,w
	addwf	(___bmul@product),f
	goto	l4138
	
l1665:	
	line	9
	
l4138:	
	clrc
	rlf	(___bmul@multiplicand),f

	line	10
	
l4140:	
	clrc
	rrf	(___bmul@multiplier),f

	line	11
	
l4142:	
	movf	(___bmul@multiplier),f
	skipz
	goto	u3941
	goto	u3940
u3941:
	goto	l1664
u3940:
	goto	l4144
	
l1666:	
	line	12
	
l4144:	
	movf	(___bmul@product),w
	goto	l1667
	
l4146:	
	line	13
	
l1667:	
	return
	opt stack 0
GLOBAL	__end_of___bmul
	__end_of___bmul:
;; =============== function ___bmul ends ============

	signat	___bmul,8313
	global	_interrupcoes
psect	text379,local,class=CODE,delta=2
global __ptext379
__ptext379:

;; *************** function _interrupcoes *****************
;; Defined at:
;;		line 744 in file "C:\Users\Felipe\Desktop\GIRADOR+IR\girador-soft\girador.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  buf             1    7[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         1       0       0       0       0
;;      Temps:          7       0       0       0       0
;;      Totals:         8       0       0       0       0
;;Total ram usage:        8 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		Interrupt level 1
;; This function uses a non-reentrant model
;;
psect	text379
	file	"C:\Users\Felipe\Desktop\GIRADOR+IR\girador-soft\girador.c"
	line	744
	global	__size_of_interrupcoes
	__size_of_interrupcoes	equ	__end_of_interrupcoes-_interrupcoes
	
_interrupcoes:	
	opt	stack 3
; Regs used in _interrupcoes: [wreg-fsr0h+status,2+status,0]
psect	intentry,class=CODE,delta=2
global __pintentry
__pintentry:
global interrupt_function
interrupt_function:
	global saved_w
	saved_w	set	btemp+0
	movwf	saved_w
	swapf	status,w
	movwf	(??_interrupcoes+3)
	movf	fsr0,w
	movwf	(??_interrupcoes+4)
	movf	pclath,w
	movwf	(??_interrupcoes+5)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	btemp+1,w
	movwf	(??_interrupcoes+6)
	ljmp	_interrupcoes
psect	text379
	line	754
	
i1l3984:	
;girador.c: 745: unsigned char buf;
;girador.c: 754: if(TMR1IF){
	btfss	(96/8),(96)&7
	goto	u359_21
	goto	u359_20
u359_21:
	goto	i1l4028
u359_20:
	line	755
	
i1l3986:	
;girador.c: 755: TMR1IF=0;
	bcf	(96/8),(96)&7
	line	756
	
i1l3988:	
;girador.c: 756: TMR1L = 1;
	movlw	(01h)
	movwf	(14)	;volatile
	line	757
;girador.c: 757: TMR1H = 0b10000000;
	movlw	(080h)
	movwf	(15)	;volatile
	line	758
;girador.c: 758: T1CON = 0b00001111;
	movlw	(0Fh)
	movwf	(16)	;volatile
	line	759
	
i1l3990:	
;girador.c: 759: mudar = 1;
	clrf	(_mudar)
	bsf	status,0
	rlf	(_mudar),f
	line	760
;girador.c: 760: sl++;
	movlw	(01h)
	movwf	(??_interrupcoes+0)+0
	movf	(??_interrupcoes+0)+0,w
	addwf	(_sl),f
	line	761
	
i1l3992:	
;girador.c: 761: if(sl>=10){
	movlw	(0Ah)
	subwf	(_sl),w
	skipc
	goto	u360_21
	goto	u360_20
u360_21:
	goto	i1l4028
u360_20:
	line	762
	
i1l3994:	
;girador.c: 762: sl = 0;
	clrf	(_sl)
	line	763
	
i1l3996:	
;girador.c: 763: sh++;
	movlw	(01h)
	movwf	(??_interrupcoes+0)+0
	movf	(??_interrupcoes+0)+0,w
	addwf	(_sh),f
	line	764
	
i1l3998:	
;girador.c: 764: if(sh>=6){
	movlw	(06h)
	subwf	(_sh),w
	skipc
	goto	u361_21
	goto	u361_20
u361_21:
	goto	i1l4028
u361_20:
	line	765
	
i1l4000:	
;girador.c: 765: sh = 0;
	clrf	(_sh)
	line	766
	
i1l4002:	
;girador.c: 766: ml++;
	movlw	(01h)
	movwf	(??_interrupcoes+0)+0
	movf	(??_interrupcoes+0)+0,w
	addwf	(_ml),f
	line	767
	
i1l4004:	
;girador.c: 767: if(ml>=10){
	movlw	(0Ah)
	subwf	(_ml),w
	skipc
	goto	u362_21
	goto	u362_20
u362_21:
	goto	i1l4028
u362_20:
	line	768
	
i1l4006:	
;girador.c: 768: ml = 0;
	clrf	(_ml)
	line	769
	
i1l4008:	
;girador.c: 769: mh++;
	movlw	(01h)
	movwf	(??_interrupcoes+0)+0
	movf	(??_interrupcoes+0)+0,w
	addwf	(_mh),f
	line	770
	
i1l4010:	
;girador.c: 770: if(mh>=6){
	movlw	(06h)
	subwf	(_mh),w
	skipc
	goto	u363_21
	goto	u363_20
u363_21:
	goto	i1l4028
u363_20:
	line	771
	
i1l4012:	
;girador.c: 771: mh = 0;
	clrf	(_mh)
	line	772
	
i1l4014:	
;girador.c: 772: hl++;
	movlw	(01h)
	movwf	(??_interrupcoes+0)+0
	movf	(??_interrupcoes+0)+0,w
	addwf	(_hl),f
	line	773
	
i1l4016:	
;girador.c: 773: if(hh==2 && hl==4){
	movf	(_hh),w
	xorlw	02h
	skipz
	goto	u364_21
	goto	u364_20
u364_21:
	goto	i1l4022
u364_20:
	
i1l4018:	
	movf	(_hl),w
	xorlw	04h
	skipz
	goto	u365_21
	goto	u365_20
u365_21:
	goto	i1l4022
u365_20:
	line	774
	
i1l4020:	
;girador.c: 774: hh = 0;
	clrf	(_hh)
	line	775
;girador.c: 775: hl = 0;
	clrf	(_hl)
	goto	i1l4022
	line	776
	
i1l944:	
	line	777
	
i1l4022:	
;girador.c: 776: }
;girador.c: 777: if(hl>=10){
	movlw	(0Ah)
	subwf	(_hl),w
	skipc
	goto	u366_21
	goto	u366_20
u366_21:
	goto	i1l4028
u366_20:
	line	778
	
i1l4024:	
;girador.c: 778: hl = 0;
	clrf	(_hl)
	line	779
	
i1l4026:	
;girador.c: 779: hh++;
	movlw	(01h)
	movwf	(??_interrupcoes+0)+0
	movf	(??_interrupcoes+0)+0,w
	addwf	(_hh),f
	goto	i1l4028
	line	780
	
i1l945:	
	goto	i1l4028
	line	781
	
i1l943:	
	goto	i1l4028
	line	782
	
i1l942:	
	goto	i1l4028
	line	783
	
i1l941:	
	goto	i1l4028
	line	784
	
i1l940:	
	goto	i1l4028
	line	785
	
i1l939:	
	line	793
	
i1l4028:	
;girador.c: 780: }
;girador.c: 781: }
;girador.c: 782: }
;girador.c: 783: }
;girador.c: 784: }
;girador.c: 785: }
;girador.c: 793: if(TMR0IF&&TMR0IE){
	btfss	(90/8),(90)&7
	goto	u367_21
	goto	u367_20
u367_21:
	goto	i1l946
u367_20:
	
i1l4030:	
	btfss	(93/8),(93)&7
	goto	u368_21
	goto	u368_20
u368_21:
	goto	i1l946
u368_20:
	line	809
	
i1l4032:	
;girador.c: 809: TMR0IF = 0;
	bcf	(90/8),(90)&7
	line	810
	
i1l4034:	
;girador.c: 810: TMR0 = delay;
	movf	(_delay),w
	movwf	(1)	;volatile
	line	811
;girador.c: 811: if(frame<60)PORTD = telaHF[frame];
	movlw	(03Ch)
	subwf	(_frame),w
	skipnc
	goto	u369_21
	goto	u369_20
u369_21:
	goto	i1l4038
u369_20:
	
i1l4036:	
	movf	(_frame),w
	addlw	_telaHF&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank1
	movf	indf,w
	movwf	(8)	;volatile
	goto	i1l4040
	line	812
	
i1l947:	
	
i1l4038:	
;girador.c: 812: else PORTD = telaHL[frame-60];
	movf	(_frame),w
	addlw	0C4h
	addlw	_telaHL&0ffh
	movwf	fsr0
	bsf	status, 7	;select IRP bank2
	movf	indf,w
	movwf	(8)	;volatile
	goto	i1l4040
	
i1l948:	
	line	813
	
i1l4040:	
;girador.c: 813: if(frame%2==0){
	btfsc	(_frame),(0)&7
	goto	u370_21
	goto	u370_20
u370_21:
	goto	i1l4048
u370_20:
	line	814
	
i1l4042:	
;girador.c: 814: buf = telaL[frame>>1];
	movf	(_frame),w
	movwf	(??_interrupcoes+0)+0
	clrc
	rrf	(??_interrupcoes+0)+0,w
	addlw	_telaL&0ffh
	movwf	fsr0
	bsf	status, 7	;select IRP bank3
	movf	indf,w
	movwf	(??_interrupcoes+1)+0
	movf	(??_interrupcoes+1)+0,w
	movwf	(interrupcoes@buf)
	line	815
	
i1l4044:	
;girador.c: 815: PORTE = buf;
	movf	(interrupcoes@buf),w
	movwf	(9)	;volatile
	line	816
	
i1l4046:	
;girador.c: 816: PORTA = buf>>2;
	movf	(interrupcoes@buf),w
	movwf	(??_interrupcoes+0)+0
	movlw	02h
u371_25:
	clrc
	rrf	(??_interrupcoes+0)+0,f
	addlw	-1
	skipz
	goto	u371_25
	movf	0+(??_interrupcoes+0)+0,w
	movwf	(5)	;volatile
	goto	i1l4048
	line	817
	
i1l949:	
	line	818
	
i1l4048:	
;girador.c: 817: }
;girador.c: 818: if(frame==15){
	movf	(_frame),w
	xorlw	0Fh
	skipz
	goto	u372_21
	goto	u372_20
u372_21:
	goto	i1l4054
u372_20:
	line	819
	
i1l4050:	
;girador.c: 819: if(RC3)SENSOR&=~0b00000010;
	btfss	(59/8),(59)&7
	goto	u373_21
	goto	u373_20
u373_21:
	goto	i1l951
u373_20:
	
i1l4052:	
	movlw	(0FDh)
	movwf	(??_interrupcoes+0)+0
	movf	(??_interrupcoes+0)+0,w
	andwf	(_SENSOR),f
	goto	i1l952
	line	820
	
i1l951:	
;girador.c: 820: else SENSOR|= 0b00000010;
	bsf	(_SENSOR)+(1/8),(1)&7
	
i1l952:	
	line	821
;girador.c: 821: RC4 = 1;
	bsf	(60/8),(60)&7
	line	822
;girador.c: 822: }else if(frame==30){
	goto	i1l4090
	
i1l950:	
	
i1l4054:	
	movf	(_frame),w
	xorlw	01Eh
	skipz
	goto	u374_21
	goto	u374_20
u374_21:
	goto	i1l4060
u374_20:
	line	823
	
i1l4056:	
;girador.c: 823: if(RC3)SENSOR&=~0b00000100;
	btfss	(59/8),(59)&7
	goto	u375_21
	goto	u375_20
u375_21:
	goto	i1l955
u375_20:
	
i1l4058:	
	movlw	(0FBh)
	movwf	(??_interrupcoes+0)+0
	movf	(??_interrupcoes+0)+0,w
	andwf	(_SENSOR),f
	goto	i1l956
	line	824
	
i1l955:	
;girador.c: 824: else SENSOR|= 0b00000100;
	bsf	(_SENSOR)+(2/8),(2)&7
	
i1l956:	
	line	825
;girador.c: 825: RC4 = 1;
	bsf	(60/8),(60)&7
	line	826
;girador.c: 826: }else if(frame==45){
	goto	i1l4090
	
i1l954:	
	
i1l4060:	
	movf	(_frame),w
	xorlw	02Dh
	skipz
	goto	u376_21
	goto	u376_20
u376_21:
	goto	i1l4066
u376_20:
	line	827
	
i1l4062:	
;girador.c: 827: if(RC3)SENSOR&=~0b00001000;
	btfss	(59/8),(59)&7
	goto	u377_21
	goto	u377_20
u377_21:
	goto	i1l959
u377_20:
	
i1l4064:	
	movlw	(0F7h)
	movwf	(??_interrupcoes+0)+0
	movf	(??_interrupcoes+0)+0,w
	andwf	(_SENSOR),f
	goto	i1l960
	line	828
	
i1l959:	
;girador.c: 828: else SENSOR|= 0b00001000;
	bsf	(_SENSOR)+(3/8),(3)&7
	
i1l960:	
	line	829
;girador.c: 829: RC4 = 1;
	bsf	(60/8),(60)&7
	line	830
;girador.c: 830: }else if(frame==60){
	goto	i1l4090
	
i1l958:	
	
i1l4066:	
	movf	(_frame),w
	xorlw	03Ch
	skipz
	goto	u378_21
	goto	u378_20
u378_21:
	goto	i1l4072
u378_20:
	line	831
	
i1l4068:	
;girador.c: 831: if(RC3)SENSOR&=~0b00010000;
	btfss	(59/8),(59)&7
	goto	u379_21
	goto	u379_20
u379_21:
	goto	i1l963
u379_20:
	
i1l4070:	
	movlw	(0EFh)
	movwf	(??_interrupcoes+0)+0
	movf	(??_interrupcoes+0)+0,w
	andwf	(_SENSOR),f
	goto	i1l964
	line	832
	
i1l963:	
;girador.c: 832: else SENSOR|= 0b00010000;
	bsf	(_SENSOR)+(4/8),(4)&7
	
i1l964:	
	line	833
;girador.c: 833: RC4 = 1;
	bsf	(60/8),(60)&7
	line	834
;girador.c: 834: }else if(frame==75){
	goto	i1l4090
	
i1l962:	
	
i1l4072:	
	movf	(_frame),w
	xorlw	04Bh
	skipz
	goto	u380_21
	goto	u380_20
u380_21:
	goto	i1l4078
u380_20:
	line	835
	
i1l4074:	
;girador.c: 835: if(RC3)SENSOR&=~0b00100000;
	btfss	(59/8),(59)&7
	goto	u381_21
	goto	u381_20
u381_21:
	goto	i1l967
u381_20:
	
i1l4076:	
	movlw	(0DFh)
	movwf	(??_interrupcoes+0)+0
	movf	(??_interrupcoes+0)+0,w
	andwf	(_SENSOR),f
	goto	i1l968
	line	836
	
i1l967:	
;girador.c: 836: else SENSOR|= 0b00100000;
	bsf	(_SENSOR)+(5/8),(5)&7
	
i1l968:	
	line	837
;girador.c: 837: RC4 = 1;
	bsf	(60/8),(60)&7
	line	838
;girador.c: 838: }else if(frame==90){
	goto	i1l4090
	
i1l966:	
	
i1l4078:	
	movf	(_frame),w
	xorlw	05Ah
	skipz
	goto	u382_21
	goto	u382_20
u382_21:
	goto	i1l4084
u382_20:
	line	839
	
i1l4080:	
;girador.c: 839: if(RC3)SENSOR&=~0b01000000;
	btfss	(59/8),(59)&7
	goto	u383_21
	goto	u383_20
u383_21:
	goto	i1l971
u383_20:
	
i1l4082:	
	movlw	(0BFh)
	movwf	(??_interrupcoes+0)+0
	movf	(??_interrupcoes+0)+0,w
	andwf	(_SENSOR),f
	goto	i1l972
	line	840
	
i1l971:	
;girador.c: 840: else SENSOR|= 0b01000000;
	bsf	(_SENSOR)+(6/8),(6)&7
	
i1l972:	
	line	841
;girador.c: 841: RC4 = 1;
	bsf	(60/8),(60)&7
	line	842
;girador.c: 842: }else if(frame==105){
	goto	i1l4090
	
i1l970:	
	
i1l4084:	
	movf	(_frame),w
	xorlw	069h
	skipz
	goto	u384_21
	goto	u384_20
u384_21:
	goto	i1l974
u384_20:
	line	843
	
i1l4086:	
;girador.c: 843: if(RC3)SENSOR&=~0b10000000;
	btfss	(59/8),(59)&7
	goto	u385_21
	goto	u385_20
u385_21:
	goto	i1l975
u385_20:
	
i1l4088:	
	movlw	(07Fh)
	movwf	(??_interrupcoes+0)+0
	movf	(??_interrupcoes+0)+0,w
	andwf	(_SENSOR),f
	goto	i1l976
	line	844
	
i1l975:	
;girador.c: 844: else SENSOR|= 0b10000000;
	bsf	(_SENSOR)+(7/8),(7)&7
	
i1l976:	
	line	845
;girador.c: 845: RC4 = 1;
	bsf	(60/8),(60)&7
	line	846
;girador.c: 846: }else RC4 = 0;
	goto	i1l4090
	
i1l974:	
	bcf	(60/8),(60)&7
	goto	i1l4090
	
i1l977:	
	goto	i1l4090
	
i1l973:	
	goto	i1l4090
	
i1l969:	
	goto	i1l4090
	
i1l965:	
	goto	i1l4090
	
i1l961:	
	goto	i1l4090
	
i1l957:	
	goto	i1l4090
	
i1l953:	
	line	849
	
i1l4090:	
;girador.c: 849: frame++;
	movlw	(01h)
	movwf	(??_interrupcoes+0)+0
	movf	(??_interrupcoes+0)+0,w
	addwf	(_frame),f
	line	850
	
i1l4092:	
;girador.c: 850: if(frame==120){
	movf	(_frame),w
	xorlw	078h
	skipz
	goto	u386_21
	goto	u386_20
u386_21:
	goto	i1l946
u386_20:
	line	851
	
i1l4094:	
;girador.c: 851: TMR0IE = 0;
	bcf	(93/8),(93)&7
	goto	i1l946
	line	852
	
i1l978:	
	line	853
	
i1l946:	
	line	858
;girador.c: 852: }
;girador.c: 853: }
;girador.c: 858: if(INTF){
	btfss	(89/8),(89)&7
	goto	u387_21
	goto	u387_20
u387_21:
	goto	i1l987
u387_20:
	line	859
	
i1l4096:	
;girador.c: 859: INTF= 0;
	bcf	(89/8),(89)&7
	line	860
;girador.c: 860: if(!INTEDG){
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	btfsc	(1038/8)^080h,(1038)&7
	goto	u388_21
	goto	u388_20
u388_21:
	goto	i1l4120
u388_20:
	line	861
	
i1l4098:	
;girador.c: 861: TMR0 = 0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(1)	;volatile
	line	862
	
i1l4100:	
;girador.c: 862: TMR0IE= 0;
	bcf	(93/8),(93)&7
	line	863
	
i1l4102:	
;girador.c: 863: PORTD = telaHF[0];
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movf	(_telaHF)^080h,w
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(8)	;volatile
	line	864
	
i1l4104:	
;girador.c: 864: PORTE = telaL[0];
	bsf	status, 5	;RP0=1, select bank3
	bsf	status, 6	;RP1=1, select bank3
	movf	(_telaL)^0180h,w
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(9)	;volatile
	line	865
	
i1l4106:	
;girador.c: 865: PORTA = telaL[0]>>2;
	bsf	status, 5	;RP0=1, select bank3
	bsf	status, 6	;RP1=1, select bank3
	movf	(_telaL)^0180h,w
	movwf	(??_interrupcoes+0)+0
	movlw	02h
u389_25:
	clrc
	rrf	(??_interrupcoes+0)+0,f
	addlw	-1
	skipz
	goto	u389_25
	movf	0+(??_interrupcoes+0)+0,w
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(5)	;volatile
	line	866
	
i1l4108:	
;girador.c: 866: frame = 1;
	clrf	(_frame)
	bsf	status,0
	rlf	(_frame),f
	line	867
	
i1l4110:	
;girador.c: 867: INTEDG = 1;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bsf	(1038/8)^080h,(1038)&7
	line	868
	
i1l4112:	
;girador.c: 868: RC4 = 1;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bsf	(60/8),(60)&7
	line	869
	
i1l4114:	
;girador.c: 869: if(RC3)SENSOR = 0b00000000;
	btfss	(59/8),(59)&7
	goto	u390_21
	goto	u390_20
u390_21:
	goto	i1l4118
u390_20:
	
i1l4116:	
	clrf	(_SENSOR)
	goto	i1l987
	line	870
	
i1l981:	
	
i1l4118:	
;girador.c: 870: else SENSOR = 0b00000001;
	clrf	(_SENSOR)
	bsf	status,0
	rlf	(_SENSOR),f
	goto	i1l987
	
i1l982:	
	line	871
;girador.c: 871: }else{
	goto	i1l987
	
i1l980:	
	line	872
	
i1l4120:	
;girador.c: 872: buf = CALIBRACAO - TMR0;
	bcf	status, 5	;RP0=0, select bank0
	decf	(1),w	;volatile
	xorlw	0ffh
	addwf	(_CALIBRACAO),w
	movwf	(??_interrupcoes+0)+0
	movf	(??_interrupcoes+0)+0,w
	movwf	(interrupcoes@buf)
	line	873
	
i1l4122:	
;girador.c: 873: if(delay<buf-1 || delay>buf+1)
	movf	(interrupcoes@buf),w
	addlw	low(-1)
	movwf	(??_interrupcoes+0)+0
	movlw	high(-1)
	skipnc
	movlw	(high(-1)+1)&0ffh
	movwf	((??_interrupcoes+0)+0)+1
	movf	1+(??_interrupcoes+0)+0,w
	xorlw	80h
	sublw	080h
	skipz
	goto	u391_25
	movf	0+(??_interrupcoes+0)+0,w
	subwf	(_delay),w
u391_25:

	skipc
	goto	u391_21
	goto	u391_20
u391_21:
	goto	i1l4126
u391_20:
	
i1l4124:	
	movf	(interrupcoes@buf),w
	addlw	low(01h)
	movwf	(??_interrupcoes+0)+0
	movlw	high(01h)
	skipnc
	movlw	(high(01h)+1)&0ffh
	movwf	((??_interrupcoes+0)+0)+1
	movf	1+(??_interrupcoes+0)+0,w
	xorlw	80h
	movwf	(??_interrupcoes+2)+0
	movlw	80h
	subwf	(??_interrupcoes+2)+0,w
	skipz
	goto	u392_25
	movf	(_delay),w
	subwf	0+(??_interrupcoes+0)+0,w
u392_25:

	skipnc
	goto	u392_21
	goto	u392_20
u392_21:
	goto	i1l984
u392_20:
	goto	i1l4126
	
i1l986:	
	line	874
	
i1l4126:	
;girador.c: 874: delay = buf;
	movf	(interrupcoes@buf),w
	movwf	(??_interrupcoes+0)+0
	movf	(??_interrupcoes+0)+0,w
	movwf	(_delay)
	
i1l984:	
	line	875
;girador.c: 875: TMR0 = delay;
	movf	(_delay),w
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(1)	;volatile
	line	876
	
i1l4128:	
;girador.c: 876: TMR0IF = 0;
	bcf	(90/8),(90)&7
	line	877
	
i1l4130:	
;girador.c: 877: TMR0IE = 1;
	bsf	(93/8),(93)&7
	line	878
;girador.c: 878: PORTD = telaHF[1];
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movf	0+(_telaHF)^080h+01h,w
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(8)	;volatile
	line	879
;girador.c: 879: frame = 2;
	movlw	(02h)
	movwf	(??_interrupcoes+0)+0
	movf	(??_interrupcoes+0)+0,w
	movwf	(_frame)
	line	880
	
i1l4132:	
;girador.c: 880: INTEDG = 0;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bcf	(1038/8)^080h,(1038)&7
	goto	i1l987
	line	881
	
i1l983:	
	goto	i1l987
	line	890
	
i1l979:	
	line	891
	
i1l987:	
	movf	(??_interrupcoes+6),w
	bcf	status, 5	;RP0=0, select bank0
	movwf	btemp+1
	movf	(??_interrupcoes+5),w
	movwf	pclath
	movf	(??_interrupcoes+4),w
	movwf	fsr0
	swapf	(??_interrupcoes+3)^0FFFFFF80h,w
	movwf	status
	swapf	saved_w,f
	swapf	saved_w,w
	retfie
	opt stack 0
GLOBAL	__end_of_interrupcoes
	__end_of_interrupcoes:
;; =============== function _interrupcoes ends ============

	signat	_interrupcoes,88
psect	text380,local,class=CODE,delta=2
global __ptext380
__ptext380:
	global	btemp
	btemp set 07Eh

	DABS	1,126,2	;btemp
	global	wtemp0
	wtemp0 set btemp
	end
