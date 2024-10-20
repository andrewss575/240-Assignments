; signed short shortArr[10] = {-3012, 623, -1234, 2345, 3456, 1267, -89, 6232, -231, 0};
; signed short evenSum;
; register long rsi = 0 //64-bit register
; register long rdi = 0 //64-bit register
; while (num[rsi] != 0) {
;	 if(shortArr[rsi] < 0 && shortArr[rsi]%2 == 0) {
; 		evenSum += shortArr[rsi];
; 	}
; 	rsi++;
; }

section .data
    shortArr    dw  -3012, 23, -1234, 2345, 3456, 1267, -89, 6232, -231, 0
section .bss
    evenSum     resw    1

section .text
    global _start
_start:
    mov rsi, 0
    mov rdi, 0

whileLoop:
    cmp word[shortArr + rsi], 0
    je end

    mov ax, word[shortArr + rsi]
    cmp ax, 0
    jle check2

    add rsi, 2
    jmp whileLoop

check2:
    cwd
    mov cx, 2
    idiv cx
    mov ax, word[shortArr + rsi] 
    add rsi, 2
    cmp dx, 0
    jne whileLoop
    add word[evenSum], ax
    jmp whileLoop


end:
    mov rax, 60
    mov rdi, 0
    syscall



