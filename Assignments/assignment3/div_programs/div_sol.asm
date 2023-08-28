;unsigned long num1 = 50,000,000,000;
;unsigned int num2 = 3,333,333;
;unsigned int quotient = 0, remainder = 0;
;quotient = num1 / num2;
;remainder = num1 % num2;

section .data
        num1      dq      50000000000                              ;num1 = 0000 000B A43B 7400h
        num2      dd      3333333                                  ;num2 = 0032 DCD5h
        quotient  dd      0                                        ;quotient = 0000 0000h
	remainder dd      0                                        ;remainder = 0000 0000h

section .text
        global _start

_start:
	mov	edx, dword[num1+4]				;edx = num1+4 = 0000 000Bh
	mov 	eax, dword[num1+0]				;eax = num1+0 = A43B 7400h
      	
        div     dword[num2]                                  	;eax = eax/num2 = 0000 3A98 = 15000
								;edx = eax%num2 = 0000 1388h = 5000
								
        mov     dword[quotient], eax                            ;quotient = eax = 0000 3A98h = 15000
        mov     dword[remainder], edx                           ;remainder = edx = 0000 1388h = 5000

        mov     rax, 60                                         ;terminate excuting process
        mov     rdi, 0                                          ;exit status
        syscall                                                 ;calling system services
