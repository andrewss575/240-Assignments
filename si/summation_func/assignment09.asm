#NOT COMPLETED. STILL NEED TO ADD FUNCTIOALITY FOR SUMS THAT IS BIGGER THAN 5 DIGITS

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
num	resw	1
sumN	resw    1

section .data
msg1	db	"Input a number (100~255): "
msg2	db      "(1*2) + (2*2) + (2*3) +...+ "
msg3	db	" = "
ascii	db      "000000", 10

section .text
        global _start
_start:
	print	msg1, 26				;cout << msg1
	scan	buffer, 4				;cin >> buffer

	; converts butter to num	
	mov	rbx, buffer				;rbx = address of buffer
	call	toNumber

	; calculates 1+2+3+...+N
	mov	rcx, 0					;rcx = 0
	mov	edi, dword[num]				;di = num
	call 	calculate				;call calculate

	; converts sumN into ascii
	mov	rcx, 5
	mov	edi, dword[sumN]			;di = sumN
	call	toAscii

	print	msg2, 25				;cout << msg2
	print	buffer, 3				;cout << buffer
	print	msg3, 3					;cout << " = "
	print	ascii, 7				;cout << ascii

        mov     rax, 60					;terminate program
        mov     rdi, 0					;exit status
        syscall						;calling system services

; ascii to number function
toNumber:
	mov	rax, 0					;clear rax
	mov	rdi, 10					;rdi = 10
	mov	rsi, 0					;counter = rsi = 0
next0:
	mov	cl, byte[rbx+rsi]			;cl = [buffer+rsi]
	and	cl, 0fh					;convert ascii to number
	add	al, cl					;al = number
	adc	ah, 0					;ah = 0
	cmp	rsi, 2					;compare rsi with 2
	je	skip0					;if rsi=2 goto skip0
	mul	di					;dx:ax = ax * di
skip0:
	inc	rsi					;rcx++
	cmp	rsi, 3					;compare rcx with 3
	jl	next0					;if rcx<3 goto next0
	mov	word[num], ax				;num = ax
	ret

; calculation function
calculate:
next1:	
	mov	eax, 2
	mul	ecx
	add	dword[sumN], eax				;sumN += cx
	inc	ecx					;cx++
	cmp	ecx, edi					;compare cx and di=num
	jbe	next1					;if(cx<=num) jump to next1
	ret

; number to ascii function
toAscii:
	mov	eax, edi
	mov	bx, 10					;bx = 10
next2:
	mov	dx, 0					;dx = 0
	div	bx					;dx=(dx:ax)%10, ax=(dx:ax)/10
	add     byte[ascii+rcx], dl			;ascii+0 = al + 30h
	dec	cx					;cx--
	cmp	cx, 0					;compare cx and 0
	jge	next2					;if (cx>=0) jump to next2
	ret
