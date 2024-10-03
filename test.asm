EARL:
	SSP 5
	EXT
BTN:
	STO R0 5
	STO R1 15
	STO R2 30
	GDL R0 R0 R0 R1 5              ; R0 R1 => R0 R2 LEADING
	GDL R0 R0 R2 R0 5              ; R0 R1 => R0 R3 TOP
	GDL R2 R0 R2 R1 5              ; R3 R1 => R3 R2 TRAILING
	GDL R0 R1 R2 R1 5              ; R0 R2 => R3 R2 BOTTOM
	STO R0 7
	STO R1 8
	GDC R1 R0 69 7
	ADD R1 6
	GDC R1 R0 120 7
	ADD R1 6
	GDC R1 R0 105 7
	ADD R1 6
	GDC R1 R0 116 7
	JMP CURSOR
CURSOR:
    MUS 0 0 R32
	IFQ 3 R32 2 3                   ; Left click
	MUS R10 R11 0                   ; Get Mouse Position
	GDL R30 R31 R10 R11 R12         ; Drawing Cursor
	MUS R30 R31 0                   ; Get Initial Mouse Position
	IFQ 3 R32 1 2                   ; Right click
	RAN R12 1 155
	JMP CURSOR
MAIN:
	JMP BTN