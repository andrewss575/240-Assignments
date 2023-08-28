;disregard this, its kinda weird, just look at the solution better

; parity.asm
; byte num = 325;
; byte even = 0, odd = 0;
; if(num % 2 != 0) {
;    odd++;
; } else {
;    even++;
; }

section .data
        num     db      325
        even    db      0                                       ;even = 0
        odd     db      0                                       ;odd = 0

section .text
        global _start
_start:
        mov     ax, 0                                           ;ax = 0
	mov	al, num						;al = num
        mov     bl, 2                                           ;bl = 2
        div     bl                                              ;ah = ax%bl, al = ax/bl
        cmp     ah, 0                                           ;compare ah,0
        jnz     odd_num                                         ;if(rem!=0) goto odd_num
        inc     byte[even]                                      ;even = even + 1
        jmp     end_if                                          ;goto end_if
odd_num:
        inc     byte[odd]                                       ;odd = odd + 1
end_if:
        mov     rax, 60                                         ;terminate excuting process
        mov     rdi, 0                                          ;exit status
        syscall                                                 ;calling system services
