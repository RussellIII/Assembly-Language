.386
STACK   SEGMENT USE16 STACK
	    DB 200 DUP(0)
STACK   ENDS
DATA    SEGMENT USE16
BNAME   DB 'liu chenyan', 0		;owner's name
BPASS   DB 'test', 0, 0			;correct password
IN_NAME DB 15					;palce storing name
        DB 0
        DB 15 DUP(0)
IN_PWD  DB 10					;place storing password
		DB 0
		DB 10 DUP(0)
IN_ITEM DB 20
		DB 0
		DB 20 DUP(0)
N       EQU 30
AUTH    DB 0
SNAME   DB 'ONLINE SHOP'
GA1     DB 'PEN', 7 DUP(0), 10
        DW 35, 56, 70, 25, ?
GA2     DB 'BOOK', 6 DUP(0), 9
        DW 12, 30, 25, 5, ?
GAN     DB N-2 DUP('Temp-Value', 8, 15, 0, 20, 0, 30, 0, 2, 0, ?, ?)
BUF1    DB 'WELCOME! YOU ARE VISITING ONLINE SHOP', 0AH, 0DH, '$'
BUF2    DB 'PLEASE ENTER YOUR NAME AND PASSWORD:', 0AH, 0DH, '$'
BUF3    DB 'FAIL TO LOG IN!', 0AH, 0DH, '$'
BUF4	DB 'PLEASE ENTER THEN ITEM YOU WOULD LIKE TO INQURE:', 0AH, 0DH, '$'
CRLF    DB 0DH, 0AH, '$'
DATA    ENDS

CODE    SEGMENT USE16
        ASSUME CS:CODE, DS:DATA, SS: STACK
START:  MOV AX, DATA
		MOV DS, AX
FUNC1:	MOV AUTH, 0
		LEA DX, BUF1			;print: YOU ARE VISITING ONLINE SHOP
		MOV AH, 9
		INT 21H					
		LEA DX, BUF2			;print: PLEASE ENTER YOUR NAME AND PASSWORD
		MOV AH, 9
		INT 21H
		LEA DX, IN_NAME			;scanf: name
		MOV AH, 10
		INT 21H
		LEA DX, CRLF			;回车换行
		MOV AH, 9
		INT 21H

		CMP IN_NAME + 1, 0			;if entered nothing, goto FUNC3
		JE  FUNC3

		CMP IN_NAME + 1, 1			;if entered only one char, goto CODION1 to see more
		JNE CODON1

		CMP IN_NAME+2, 'q' 		;if the name is 'q', exit
		JE  EXT

CODON1:	LEA DX, IN_PWD			;scanf: password
		MOV AH,10
		INT 21H
		LEA DX, CRLF			;回车换行
		MOV AH, 9
		INT 21H

		MOV AUTH, 1				;else let AUTH be 1 and goto FUNC2
		JMP  FUNC2
	
FUNC2:	CMP IN_NAME + 13, 0DH
		JNE WARN
		CMP IN_PWD + 6, 0DH
		JNE WARN
		MOV CX, 11
		MOV BX, 0
LOP1:	MOV AH, IN_NAME + 2[BX]
		MOV AL, BNAME + [BX]
		CMP AH, AL
		JNE WARN
		DEC CX
		INC BX
		CMP CX, 0
		JNE LOP1
		MOV CX, 4
		MOV BX, 0
LOP2:	MOV AH, IN_PWD + 2[BX]
		MOV AL, BPASS + [BX]
		CMP AH, AL
		JNZ WARN
		DEC CX
		INC BX
		CMP CX, 0
		JNE LOP2
		MOV AUTH, 1
		JMP FUNC3

WARN:	LEA DX, BUF3			;print: FAIL TO LOG IN
		MOV AH, 9
		INT 21H
		JMP FUNC1

FUNC3:	LEA DX, BUF4			;print: PLEASE ENTER THEN ITEM YOU WOULD LIKE TO INQURE
		MOV AH, 9
		INT 21H
		LEA DX, IN_ITEM			;scan the item user want to inquire
		MOV AH, 10				;scan the item user want to inquire
		INT 21H					;scan the item user want to inquire
		LEA DX, CRLF			;回车换行
		MOV AH, 9				;回车换行
		INT 21H					;回车换行
		CMP IN_ITEM + 1, 0		;if user entered nothing, goto FUNC1
		JE  FUNC1				;if user entered nothing, goto FUNC1
		MOV CL, IN_ITEM + 1 
		SUB CL, 1
		MOV CH, 0
		MOV DX, -1				;DX counts the term of item 
		MOV SI, OFFSET GA1
		SUB SI, 21
LOP3:	MOV BX, -1				;BX counts the term of literal
		ADD SI, 21
		INC DX
		CMP DX, 30
		JE  FUNC3
LOP4:	INC BX
		MOV AH, IN_ITEM + 2[BX]
		MOV AL, [SI]+[BX]
		CMP AH, AL
		JNE LOP3
		CMP BX, CX
		JNE LOP4
		INC BX
		CMP IN_ITEM + 2[BX], 0DH
		JNE LOP3
		MOV BX, 0

		CMP AUTH, 1
		JE OPITEM

		CMP AUTH, 0
		JE RECOM

OPITEM: MOV DH, [SI]+[BX]
		CMP DH, 0
		JE OPITEM1
		MOV DL, DH
		MOV AH, 2
		INT 21H
		INC BX 
		JMP OPITEM
OPITEM1:LEA DX, CRLF			;回车换行
		MOV AH, 9				;回车换行
		INT 21H
		JMP  FUNC1

RECOM:  MOV AL, [SI] + 10		;DISCOUNT IN AX
		MOV AH, 0
		MOV CX, [SI] + 13		;SALE PRICE IN CX
		MUL CX					;SALE * DISCOUNT IN AX
		MOV CX, 10
		MOV DX, 0
		DIV CX					;ACTUAL SALE PRICE IN AX
		MOV BX, AX				;ACTUAL SALE PRICE IN BX
		MOV AX, [SI] + 11		;PURCHASE PRICE
		MOV CX, 128
		MUL CX					;PURCHASE PRICE * 128 IN AX
		MOV CX, BX				;ACTUAL SALE PRICE IN CX
		MOV DX, 0
		DIV CX					;PURCHASE PRICE * 128 / ACTUAL SALE PRICE IN AX
		MOV BX, AX				;PURCHASE PRICE * 128 / ACTUAL SALE PRICE IN BX
		MOV AX, [SI] + 15		;NUM OF PURCHASE IN AX
		MOV CX, 2				;2 IN CX
		MUL CX					;2 * NUM OF PURCHASE IN AX
		MOV DI, AX				;2 * NUM OF PURCHASE IN DI
		MOV AX, [SI] + 17		;NUM OF SALE
		MOV CX, 128
		MUL CX					;NUM OF SALE * 128 IN AX
		MOV CX, DI				;2 * NUM OF PURCHASE IN CX
		MOV DX, 0
		DIV CX					;NUM OF SALE * 128 / 2 * NUM OF PURCHASE IN AX
		ADD BX, AX
		JMP FUNC4
FUNC4:  CMP BX, 100
		JA PUTA
		CMP BX, 50
		JA PUTB
		CMP BX, 10
		JA PUTC
		CMP BX, 10
		JBE PUTF
PUTA:	MOV DL, 'A'
		MOV AH,2
		INT 21H
		LEA DX, CRLF			;回车换行
		MOV AH, 9				;回车换行
		INT 21H					;回车换行
		JMP FUNC1
PUTB:	MOV DL, 'B'
		MOV AH,2
		INT 21H
		LEA DX, CRLF			;回车换行
		MOV AH, 9				;回车换行
		INT 21H					;回车换行
		JMP FUNC1
PUTC:	MOV DL, 'C'
		MOV AH,2
		INT 21H
		LEA DX, CRLF			;回车换行
		MOV AH, 9				;回车换行
		INT 21H					;回车换行
		JMP FUNC1
PUTF: 	MOV DL, 'F'
		MOV AH,2
		INT 21H
		LEA DX, CRLF			;回车换行
		MOV AH, 9				;回车换行
		INT 21H					;回车换行
		JMP FUNC1
EXT:	MOV AH, 4CH
		INT 21H




CODE    ENDS
		END START