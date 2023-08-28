; unsigned short num1 = 325;
; unsigned short even = 0, odd = 0;
; if(num1 % 2 == 0) {
;     even++;
; } else {
;     odd++;
; }

section .data
	num1	dw 325			;num1 = 0145h = 325
	even	dw 0			;even = 0000h = 0
	odd	dw 0			;odd = 0000h = 0
	
section .text
	global _start
	
_start:
	;usually when dividing, if we divide by an 8 bit registers, the dividend has to consist of 8 bit registers.
	;However, we are using ax(a 16-bit register) as the divisor
	;we can mov ax even though we are dividing by an 8 bit register because ax IS ah and al combined. 
	;This relationship is only for 8 bit registers. If it were any other higher bit registers, you could not do that
	mov ax, word[num1]		;ax = num1 = 0145h = 325
	mov cl, 2			;cl = 2 = 00h
	
	;because we are dividing by a 8bit register(cl), our results will be saved in 8 bit registers ah and al
	div cl				;al = ax/cl = 325/2 = 162 = 00A2h
					;ah = ax%cl = 1 = 0001h
	cmp ah, 0			;compare dx(1) with 0
	jne is_odd			;if dx != 0, jump to is_odd label
	
is_even:
	inc word[even]			;even++
	jmp end				;jump to end of program to terminate
is_odd:
	inc word[odd]			;odd++
	jmp end				;jump to end of program to terminate

end:
	mov rax, 60
	mov rdi, 0
	syscall
		
	
