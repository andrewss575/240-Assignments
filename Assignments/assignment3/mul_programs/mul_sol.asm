;unsigned int num1 = 300,000;
;unsigned int num2 = 400,000;
;unsigned long product = 0;
;product = long(num1 * num2);

section .data
        num1     dd      300000               ;double word        ;num1 = 0004 93E0h
        num2     dd      400000               ;double word        ;num2 = 0006 1A80h
        mult     dq      0                    ;quad word          ;mult = 0000 0000 0000 0000h

section .text
        global _start

_start:
        mov     eax, dword[num1]                                  ;eax = num1 = 0004 93E0h
        mul     dword[num2]                                  	  ;edx:eax = eax * num2 = 0000 001Bh:F08E B000h
        mov     dword[mult], eax                                  ;mult = eax = F08E B000h
        mov     dword[mult+4], edx                                ;mult+4 = edx = 0000 001Bh

        mov     rax, 60                                         ;terminate excuting process
        mov     rdi, 0                                          ;exit status
        syscall                                                 ;calling system services
