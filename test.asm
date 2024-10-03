EARL:
	SSP 5
	EXT
BTN:
	STO R0 5
	STO R1 15
	STO R2 30
	GDL R0 R0 R0 R1 5             ; R0 R1 => R0 R2 LEADING
	GDL R0 R0 R2 R0 5             ; R0 R1 => R0 R3 TOP
	GDL R2 R0 R2 R1 5             ; R3 R1 => R3 R2 TRAILING
	GDL R0 R1 R2 R1 5             ; R0 R2 => R3 R2 BOTTOM
	STO R0 7
	STO R1 8
	GDC R1 R0 69 7
	ADD R1 6
	GDC R1 R0 120 7
	ADD R1 6
	GDC R1 R0 105 7
	ADD R1 6
	GDC R1 R0 116 7
	JMP MOUSE
BTNHL:
	MUS R10 R11 R12               ; Get Mouse Information from Peripherals Page
	STO R0 5
	STO R1 15
	STO R2 30
	GDL R0 R0 R0 R1 7             ; R0 R1 => R0 R2 LEADING
	GDL R0 R0 R2 R0 7             ; R0 R1 => R0 R3 TOP
	GDL R2 R0 R2 R1 7             ; R3 R1 => R3 R2 TRAILING
	GDL R0 R1 R2 R1 7             ; R0 R2 => R3 R2 BOTTOM
	IFQ 1 R10 30 7                ; Check for Cursor Button Colision on Click
	IFQ 1 R11 15 6
	IFQ 2 R10 5 5
	IFQ 2 R11 5 4
	IFQ 3 R12 2 2
    JMP MOUSE_LEFT                ; On left click
	JMP BTNHL
	JMP BTN
MOUSE:
    MUS R10 R11 R12               ; Get Mouse Information from Peripherals Page
    IFQ 1 R10 30 6                ; Check for Cursor Button Colision on Click
	IFQ 1 R11 15 5
	IFQ 2 R10 5 4
	IFQ 2 R11 5 3
	GPX R20 R21 0
	JMP BTNHL
    GPX R10 R11 7                 ; When doesnt colide draw cursor
	STO R22 0
	IFQ 0 R10 R20 2               ; Coord Check X
	ADD R22 1
	IFQ 2 R22 1 4
	GPX R20 R21 0
	STO R20 R10
	STO R21 R11
	IFQ 0 R11 R21 2               ; Coord Check Y
	ADD R22 1
	IFQ 3 R22 1 4
	GPX R20 R21 0
	STO R20 R10
	STO R21 R11
	JMP MOUSE
MOUSE_LEFT:
	IFQ 1 R10 30 5                ; Check for Cursor Button Colision on Click
	IFQ 1 R11 15 4
	IFQ 2 R10 5 3
	IFQ 2 R11 5 2
	EXT
	GPX R10 R11 0                 ; Clear Cursor
	JMP MOUSE
MAIN:
	JMP BTN