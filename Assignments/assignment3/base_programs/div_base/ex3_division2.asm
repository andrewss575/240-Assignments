; ex3_division.asm
; short num1 = 100000, num2 = 333;
; short quot = 0, remd = 0;
; quot = num1 / num2;
; remd = num1 % num2;

section .data
        num1      dd      100000                                ;num1 = 0001 86A0h
        num2      dw      333                                   ;num2 = 014Dh
        quotient  dw      0                                     ;quotient = 0000h
	remainder dw      0                                     ;remainder = 0000h

section .text
        global _start

_start:

	; Looks at slides 62-63 in chapter 7 lecture slides to understand which registers to use. 
	; For this example, because we are dividing by a 16-bit integer (333), we utilize ax and dx 
	; registers where ax will be the quotient and dx will be the remainder as well as extra space for num1
	
	; because we are using 16-bit registers, we must break up the 17-bit num1 (100000) into dx and ax register 
	; where dx holds the leading bits
	mov	dx, word[num1+2]				;dx = num1+2 = 0001
        mov     ax, word[num1+0]                                ;ax = num1+0 = 86A0h
        
        ;this div line knows to use dx and ax registers together when dividing by num2
        ;the line holds the quotient now in ax and remainder now in dx
        div     word[num2]                                  	;ax=ax/num2=012Ch=300
								;dx=ax%num2=0064h=100
	;moving ax and dx in their respectable variable names
        mov     word[quotient], ax                              ;quotient= ax=012Ch=300
        mov     word[remainder], dx                             ;remainder=dx=0001h=100

        mov     rax, 60                                         ;terminate excuting process
        mov     rdi, 0                                          ;exit status
        syscall                                                 ;calling system services
