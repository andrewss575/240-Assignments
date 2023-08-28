;ex_while.asm
;register char cl = 1;
;char sum = 0;
;while (cl <= 10) {
;	sum = sum + cl;
;	cl++;
;}

section .data
sum     db      0

section .text
        global _start
_start:
	mov	cl, 1				;cl = 1
whileloop:
        cmp     cl, 10				;compare cl and 10
        ja      exit1				;if(cl>10) jump to exit
        add     byte[sum], cl			;sum = sum + cl
        inc     cl				;cl = cl + 1
	jmp	whileloop			;jump to whileloop
exit1:
        mov     rax, 60				;terminate excuting process
        mov     rdi, 0				;exit status
        syscall					;calling system services