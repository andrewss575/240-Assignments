; ex8_coutMacro.asm
; short sumN;
; const char N = 100;
; char string[] = "1 + 2 + 3 +...+ N = ";
; char ascii[] = "0000\n";
;
; cout << "1 + 2 + 3 +...+ N = ";
; rcx = 0;
; do {
;   sumN += rcx;
; } while(rcx >= 0);
; ascii = itoa(sumN);
; cout << ascii;

%macro	print 	2
        mov     rax, 1					;SYS_write
        mov     rdi, 1					;where to write
        mov     rsi, %1					;address of strint
        mov     rdx, %2					;number of character
        syscall						;calling system services
%endmacro

section .bss
sumN	resw    1

section .data
N	equ	100
str1	db      "1 + 2 + 3 +...+ N = "
ascii	db      "0000", 10

section .text
        global _start
_start:
	; calculates 1+2+3+...+N
	mov	cx, 0					;cx = 0
next1:
	add	word[sumN], cx				;sumN += cx
	inc	cx					;cx++
	cmp	cx, N					;compare cx with N
	jbe	next1					;if(cx<=100) goto next1

	; converts sum100 into ascii
	mov	rcx, 3
	mov	ax, word[sumN]				;ax = sumN
next2:
	mov	dx, 0					;dx = 0
	mov	bx, 10					;bx = 10
	div	bx					;dx=(dx:ax)%10, ax=(dx:ax)/10
	add     byte[ascii+rcx], dl			;ascii+0 = al + 30h
	dec	rcx
	cmp	rcx, 0
	jge	next2

	print	str1, 20				;cout << str1
	print	ascii, 5				;cout << ascii

        mov     rax, 60					;terminate program
        mov     rdi, 0					;exit status
        syscall						;calling system services