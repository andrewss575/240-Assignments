; signed short shortArr[10] = {-3012, 623, 1234, -2345, 3456, 12367, -89, 6232, -231};
; signed short oddSum;
; register long rsi = 0 //64-bit register
; register long rcx = 9 //64-bit register
; do {
; 	if(shortArr[rsi] < 0 && shortArr[rsi]%2 != 0) {
; 		oddSum += shortArr[rsi];
; 	}
; 	rsi++;
;	rcx--;
; }while (num[rsi] != 0)


section .data
    shortArr    dw  -3012, 23, -1234, -2345, 3456, 1267, -89, 6232, -231
section .bss
    oddSum     resw    1

section .text
    global _start
_start:
    mov rsi, 0
    mov rcx, 9

whileLoop:

    mov ax, word[shortArr + rsi]
    cmp ax, 0
    jle check2

    add rsi, 2
    dec rcx
    cmp rcx, 0
    jne whileLoop
    ;could also have used 'loop whileLoop'
    
    jmp end
    
    

check2:
    cwd
    mov bx, 2
    mov dx, 0
    idiv bx
    
    mov ax, word[shortArr + rsi] 
    add rsi, 2
    dec rcx
    
    cmp dx, 0
    je whileLoop
    
    add word[oddSum], ax
    
    
    cmp rcx, 0
    jne whileLoop


end:
    mov rax, 60
    mov rdi, 0
    syscall

