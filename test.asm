EARL:
	SSP 5
	EXT
BTNINIT:
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
	STO R18 37
	STO R19 22
	STO R4 8
	GDC R4 R19 67 7
	ADD R4 6
	GDC R4 R19 111 7
	ADD R4 6
	GDC R4 R19 108 7
	ADD R4 6
	GDC R4 R19 111 7
        ADD R4 6
        GDC R4 R19 114 7
        STO R24 5
        STO R25 35
        STO R26 45
        STO R27 37
        STO R28 37
        STO R4 8
        GDC R4 R28 67 7
        ADD R4 6
        GDC R4 R28 111 7
        ADD R4 6
        GDC R4 R28 108 7
        ADD R4 6
        GDC R4 R28 111 7
        ADD R4 6
        GDC R4 R28 114 7
BTN:
	GDL R0 R0 R0 R1 5             ; Exit
	GDL R0 R0 R2 R0 5
	GDL R2 R0 R2 R1 5
	GDL R0 R1 R2 R1 5
	GDL R15 R16 R15 R17 5         ; Color
	GDL R15 R16 R18 R16 5
	GDL R18 R16 R18 R17 5
	GDL R15 R17 R18 R17 5
	GDL R24 R25 R24 R26 5         ; Clear
	GDL R24 R25 R27 R25 5
	GDL R27 R25 R27 R26 5
	GDL R24 R26 R27 R26 5
	JMP MOUSE
BTNHL:
	MUS R10 R11 R12               ; Get Mouse Information from Peripherals Page
	GDL R0 R0 R0 R1 7             ; R0 R1 => R0 R2 LEADING
	GDL R0 R0 R2 R0 7             ; R0 R1 => R0 R3 TOP
	GDL R2 R0 R2 R1 7             ; R3 R1 => R3 R2 TRAILING
	GDL R0 R1 R2 R1 7             ; R0 R2 => R3 R2 BOTTOM
	IFQ 1 R10 R2 7                ; Check for Cursor Button Colision on Click
	IFQ 1 R11 R1 6
	IFQ 2 R10 R0 5
	IFQ 2 R11 R0 4
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
        IFQ 1 R10 R18 7               ; Check for Cursor Button Colision on Click
        IFQ 1 R11 R17 6
        IFQ 2 R10 R15 5
        IFQ 2 R11 R16 4
        IFQ 3 R12 2 2
        RAN R23 16 154
	JMP BTNDHL
	JMP BTN
BTNCHL:
        MUS R10 R11 R12               ; Get Mouse Information from Peripherals Page
        GDL R24 R25 R24 R26 7         ; R0 R1 => R0 R2 LEADING
        GDL R24 R25 R27 R25 7         ; R0 R1 => R0 R3 TOP
        GDL R27 R25 R27 R26 7         ; R3 R1 => R3 R2 TRAILING
        GDL R24 R26 R27 R26 7         ; R0 R2 => R3 R2 BOTTOM
        IFQ 1 R10 R27 8               ; Check for Cursor Button Colision on Click
        IFQ 1 R11 R26 7
        IFQ 2 R10 R24 6
        IFQ 2 R11 R25 5
        IFQ 3 R12 2 3
        GCS
	JMP BTNINIT
        JMP BTNCHL
        JMP BTN
MOUSE:
	MUS R10 R11 R12               ; Get Mouse Information from Peripherals Page
	IFQ 3 R12 2 5
	IFQ 3 R3A 0 3
	STO R3A 1
	JMP 2
	STO R3A 0
	IFQ 1 R10 R2 6                ; Check for Cursor Button Colision on Click
	IFQ 1 R11 R1 5
	IFQ 2 R10 R0 4
	IFQ 2 R11 R0 3
	GPX R20 R21 0
	JMP BTNHL
	IFQ 1 R10 R18 6               ; Check for Cursor Button Colision on Click
	IFQ 1 R11 R17 5
	IFQ 2 R10 R15 4
	IFQ 2 R11 R16 3
	GPX R20 R21 0
	JMP BTNDHL
        IFQ 1 R10 R27 6               ; Check for Cursor Button Colision on Click
        IFQ 1 R11 R26 5
        IFQ 2 R10 R24 4
        IFQ 2 R11 R25 3
        GPX R20 R21 0
        JMP BTNCHL
	GPX R10 R11 R23               ; When doesnt colide then draw cursor
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
	STO R3A 0
	STO R23 7
	JMP BTNINIT
