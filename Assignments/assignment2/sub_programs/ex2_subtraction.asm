; see sub_base.asm for explanation of subtraction numbers
; see ex2_addition.asm for explanation as to why we use line 20 and 21

; ex2_subtraction.asm
; short num1 = 30000, num2 = 40000
; int dif = 0;
; dif = int(num1 - num2);

section .data
        num1     dw      30000                                    ;num1 = 7530h = 30000
        num2     dw      40000                                    ;num2 = 9C40h = 40000
        dif      dd      0                                        ;dif = 0000h

section .text
        global _start

_start:
        mov     ax, word[num1]                                  ;ax = num1 = 7530h
        sub     ax, word[num2]                                  ;ax = ax + -num2 = D8F0h
	sbb	bx, 0						;bx = bx - 0 - CF = ffffh
        mov     word[dif + 0], ax                               ;dif = ax = D8F0h
	mov	word[dif + 2], bx				;dif = ax & bx = ffffD8F0h
	
        mov     rax, 60                                         ;terminate excuting process
        mov     rdi, 0                                          ;exit status
        syscall                                                 ;calling system services
