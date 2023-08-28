; ex9_coutConvFunct.asm
; #begin define print(addr, n)
;	mov	rax, 1
;	mov	rdi, 1
;	mov	rsi, addr
;	mov	rdx, n
;	syscall
; #end
;
; void main() {
; 	short sumN;
; 	const char N = 100;
; 	char str1[] = "1 + 2 + 3 +...+ N = ";
; 	char ascii[] = "0000\n";
;
; 	call calculate(N, sumN);
; 	call toAscii(N, ascii);
; 	print(str1, 20);
; 	print(ascii, 5);
; }
; 
; void calculate(N, sumN) {
;	for(cx=0; cx<=N; cx++) {
;		sumN += cx;
;	}
; }
;
; void toAscii(N, ascii) {
; 	ascii = itoa(sumN);
; }

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
	mov	di, N					;di = N = 100
	call 	calculate				;call calculate

	; converts sum100 into ascii
	mov	di, word[sumN]				;di = sumN
	call	toAscii

	; display message and result
	print	str1, 20				;cout << str1
	print	ascii, 5				;cout << ascii

        mov     rax, 60					;terminate program
        mov     rdi, 0					;exit status
        syscall						;calling system services

; calculation function
calculate:
	mov	rcx, 0					;rcx = 0
next1:
	add	word[sumN], cx				;sumN += cx
	inc	cx					;cx++
	cmp	cx, di					;compare cx and di=100
	jbe	next1					;if(cx<=100) jump to next1
	ret

; number to ascii function
toAscii:
	mov	rcx, 3					;rcx = 3
	mov	ax, di					;ax = di = sumN
	mov	bx, 10					;bx = 10
next2:
	mov	dx, 0					;dx = 0
	div	bx					;dx=(dx:ax)%10, ax=(dx:ax)/10
	add     byte[ascii+rcx], dl			;ascii+0 = al + 30h
	dec	cx					;cx--
	cmp	cx, 0					;compare cx and 0
	jge	next2					;if (cx>=0) jump to next2
	ret