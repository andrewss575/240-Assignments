;ex_doWhile.asm
;register char cl = 1;
;char sum = 0;
;do {
;	sum = sum + cl;
;	cl++;
;} while(cl <= 10);

section .data
sum     db      0

section .text
        global _start
_start:
	mov	cl, 1				;cl = 1
doloop:
        add     byte[sum], cl			;sum = sum + cl
        inc     cl				;cl = cl + 1
        cmp     cl, 10				;compare cl and 10
        jbe     doloop				;if(cl<=10) jump to doloop

        mov     rax, 60				;terminate excuting process
        mov     rdi, 0				;exit status
        syscall					;calling system services