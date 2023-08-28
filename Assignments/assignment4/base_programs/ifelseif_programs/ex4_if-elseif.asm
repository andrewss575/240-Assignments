; ex4_if-elseif-else.asm
; byte num1 = 9, num2 = 5;
; byte greater = 0, less = 0, equal = 0;
; if(num1 > num2) {
;    greater++;
; } else if(num1 < num2){
;    less++;
; } else {
;    equal++;
; }

section .data
        num1    db      9			;num1 = 09h
        num2    db      5			;num2 = 05h
        greater	db      0                       ;greater = 00h
	less	db	0			;less = 00h
	equal	db	0			;equal = 00h
    
section .text
        global _start
_start:
        mov     al, byte[num1]                  ;al = num1 = 09h
        mov     bl, byte[num2]                  ;ab = num1 = 05h
        cmp     al, bl                          ;al-bl to change flag 
        ja      if_block                        ;if(num1>num2) goto if_block
	jb	else_if				;if(num1<num2) goto else_if
else_block:
	inc	byte[equal]			;equal++
	jmp	end_if				;goto end_if
if_block:
        inc	byte[greater]			;greater++
	jmp	end_if				;goto end_if
else_if:
	inc	byte[less]			;less++
end_if:
        mov     rax, 60                         ;terminate excuting process
        mov     rdi, 0                          ;exit status
        syscall                                 ;calling system services