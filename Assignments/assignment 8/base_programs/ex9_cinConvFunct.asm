; ex9_cinConvFunct.asm
; #begin define print(addr, n)
;	rax = 1;
;	rdi = 1;
;	rsi = addr of string;
;	rdx = n;
;	syscall;
; #end
; #begin define scan(addr, n)
;	rax = 1;
;	rdi = 1;
;	rsi = addr of buffer;
;	rdx = n;
;	syscall;
; #end
;
; void main() {
; 	char buffer[4];
; 	long n;
; 	short sumN;
; 	char msg1[] = "Input a number (100~140): ";
; 	char msg2[] = "1 + 2 + 3 +...+ N = ";
; 	char ascii[] = "0000\n";
;
; 	print(msg1, 26);
; 	scan(buffer, 4);
; 	call toNumber(n, buffer);
; 	call calculate(n, sumN);
; 	call toAscii(n, ascii);
; 	print(msg2, 20);
; 	print(ascii, 5);
; }
;
; void toNumber(n, buffer) {
;	n = atoi(buffer);
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
        mov     rdi, 1					;standard output device
        mov     rsi, %1					;output string address
        mov     rdx, %2					;number of character
        syscall						;calling system services
%endmacro

%macro	scan 	2
        mov     rax, 0					;SYS_read
        mov     rdi, 0					;standard input device
        mov     rsi, %1					;input buffer address
        mov     rdx, %2					;number of character
        syscall						;calling system services
%endmacro

section .bss
buffer	resb	4
n	resw	1
sumN	resw    1

section .data
msg1	db	"Input a number (100~140): "
msg2	db      "1 + 2 + 3 +...+ N = "
ascii	db      "0000", 10

section .text
        global _start
_start:
	print	msg1, 26				;cout << msg1
	scan	buffer, 4				;cin >> buffer

	; converts buffer into n
	mov	rbx, buffer				;rbx = address of buffer
	call	toNumber

	; calculates 1+2+3+...+N
	mov	rcx, 0					;rcx = 0
	mov	di, word[n]				;di = n
	call 	calculate				;call calculate

	; converts sum100 into ascii
	mov	rcx, 3
	mov	di, word[sumN]				;di = sumN
	call	toAscii

	; display message and result
	print	msg2, 20				;cout << str1
	print	ascii, 5				;cout << ascii

        mov     rax, 60					;terminate program
        mov     rdi, 0					;exit status
        syscall						;calling system services

; ascii to number function
toNumber:
	mov	rax, 0					;clear rax
	mov	rdi, 10					;rdi = 10
	mov	rsi, 0					;counter = rsi = 0
next0:
	and	byte[rbx+rsi], 0fh			;convert ascii to number
	add	al, byte[rbx+rsi]			;al = number
	adc	ah, 0					;ah = 0
	cmp	rsi, 2					;compare rsi with 2
	je	skip0					;if rsi=2 goto skip0
	mul	di					;dx:ax = ax * di
skip0:
	inc	rsi					;rcx++
	cmp	rsi, 3					;compare rcx with 3
	jl	next0					;if rcx<3 goto next0
	mov	word[n], ax				;n = ax
	ret

; calculation function
calculate:
next1:
	add	word[sumN], cx				;sumN += cx
	inc	cx					;cx++
	cmp	cx, di					;compare cx and di=100
	jbe	next1					;if(cx<=100) jump to next1
	ret

; number to ascii function
toAscii:
	mov	ax, di
	mov	bx, 10					;bx = 10
next2:
	mov	dx, 0					;dx = 0
	div	bx					;dx=(dx:ax)%10, ax=(dx:ax)/10
	add     byte[ascii+rcx], dl			;ascii+0 = al + 30h
	dec	cx					;cx--
	cmp	cx, 0					;compare cx and 0
	jge	next2					;if (cx>=0) jump to next2
	ret