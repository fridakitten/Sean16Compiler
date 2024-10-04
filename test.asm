EARL:
	SSP 5
	EXT
BTNINIT:
	STO R3A 0                     ; CONFIG
	STO R0 5                      ; BTN VALUE
	STO R1 15
	STO R2 32
	STO R3 7
	STO R4 8
	GDC R4 R3 69 7
	ADD R4 6
	GDC R4 R3 120 7
	ADD R4 6
	GDC R4 R3 105 7
	ADD R4 6
	GDC R4 R3 116 7
	STO R15 5
	STO R16 20
	STO R17 30
	STO R18 32
	STO R19 22
	STO R4 8
	GDC R4 R19 68 7
	ADD R4 6
	GDC R4 R19 114 7
	ADD R4 6
	GDC R4 R19 97 7
	ADD R4 6
	GDC R4 R19 119 7
	STO R15 5
	STO R16 20
	STO R17 30
	STO R18 32
	STO R19 22
	STO R4 8
	GDC R4 R19 68 7
	ADD R4 6
	GDC R4 R19 114 7
	ADD R4 6
	GDC R4 R19 97 7
	ADD R4 6
	GDC R4 R19 119 7
BTN:
	GDL R0 R0 R0 R1 5             ; R0 R0 => R0 R2 LEADING
	GDL R0 R0 R2 R0 5             ; R0 R1 => R0 R3 TOP
	GDL R2 R0 R2 R1 5             ; R3 R1 => R3 R2 TRAILING
	GDL R0 R1 R2 R1 5             ; R0 R2 => R3 R2 BOTTOM
	GDL R15 R16 R15 R17 5             ; LEADING
	GDL R15 R16 R18 R16 5             ; TOP
	GDL R18 R16 R18 R17 5             ; TRAILING
	GDL R15 R17 R18 R17 5             ; BOTTOM
	JMP MOUSE
BTNHL:
	MUS R10 R11 R12               ; Get Mouse Information from Peripherals Page
	GDL R0 R0 R0 R1 7             ; R0 R1 => R0 R2 LEADING
	GDL R0 R0 R2 R0 7             ; R0 R1 => R0 R3 TOP
	GDL R2 R0 R2 R1 7             ; R3 R1 => R3 R2 TRAILING
	GDL R0 R1 R2 R1 7             ; R0 R2 => R3 R2 BOTTOM
	IFQ 1 R10 32 7                ; Check for Cursor Button Colision on Click
	IFQ 1 R11 15 6
	IFQ 2 R10 5 5
	IFQ 2 R11 5 4
	IFQ 3 R12 2 2
	EXT                           ; On left click
	JMP BTNHL
	JMP BTN
 BTNDHL:
	MUS R10 R11 R12               ; Get Mouse Information from Peripherals Page
	GDL R15 R16 R15 R17 7         ; R0 R1 => R0 R2 LEADING
	GDL R15 R16 R18 R16 7         ; R0 R1 => R0 R3 TOP
	GDL R18 R16 R18 R17 7         ; R3 R1 => R3 R2 TRAILING
	GDL R15 R17 R18 R17 7         ; R0 R2 => R3 R2 BOTTOM
	IFQ 1 R10 32 11               ; Check for Cursor Button Colision on Click
 	IFQ 1 R11 30 10
	IFQ 2 R10 5 9
	IFQ 2 R11 5 8
	IFQ 3 R12 2 6
	IFQ 0 R3A 0 3
	STO R3A 0
	JMP BTN
	STO R3A 1
	DSP R3A
	JMP BTNDHL
	JMP BTN
MOUSE:
	MUS R10 R11 R12               ; Get Mouse Information from Peripherals Page
	IFQ 1 R10 32 6                ; Check for Cursor Button Colision on Click
	IFQ 1 R11 15 5
	IFQ 2 R10 5 4
	IFQ 2 R11 5 3
	GPX R20 R21 0
	JMP BTNHL
	IFQ 1 R10 32 6                ; Check for Cursor Button Colision on Click
	IFQ 1 R11 30 5
	IFQ 2 R10 5 4
	IFQ 2 R11 5 3
	GPX R20 R21 0
	JMP BTNDHL
	GPX R10 R11 7                 ; When doesnt colide then draw cursor
	IFQ 3 R3A 1 2                 ; Draw Mode check
	JMP MOUSE
	STO R22 0
	IFQ 0 R10 R20 2               ; Coord Check X
	ADD R22 1
	IFQ 2 R22 1 5
	GPX R20 R21 0
	STO R20 R10
	STO R21 R11
	JMP MOUSE
	IFQ 0 R11 R21 2               ; Coord Check Y
	ADD R22 1
	IFQ 3 R22 1 4
	GPX R20 R21 0
	STO R20 R10
	STO R21 R11
	JMP MOUSE
MAIN:
	JMP BTNINIT
