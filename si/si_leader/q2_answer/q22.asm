; signed short shortArr[10] = {-3012, 623, 1234, -2345, 3456, 12367, -89, 6232, -231, 0};
; signed short div3Sum;
; signed short newArr[10];
; register long rsi = 0 //64-bit register
; register long r11 = 0 //64-bit register
; do {
; 	if(shortArr[rsi] < 0 && shortArr[rsi]%3 != 0) {
; 		div3Sum += shortArr[rsi];
;		newArr[r11] = shortArr[rsi];
;		r11++;
; 	}
; 	rsi++;
; }while (shortArr[rsi] != 0)


section .data
    shortArr    dw  -3012, 623, 1234, -2345, 3456, 12367, -89, 6232, -231, 0
    
;.bss is for unitialized variables.
section .bss
    div3Sum     resw    1	;regular variable of word size
    newArr	resw	10	;array of 10 uninitialized word-sized elements

section .text
    global _start
_start:
    mov rsi, 0		;offset for shortArr
    mov r11, 0		;offset for newArr

whileLoop:
    ;checking if element is negative, and if so go to check2, if not,
    ;iterate to next element or if current element is 0, end program
    mov cx, word[shortArr + rsi]
    add rsi, 2
    cmp cx, 0
    jl check2

    cmp cx, 0
    jne whileLoop
       
    jmp end

;checking if element is divisible by 3, if so, move element into newArr array and add to div3Sum
;if not, iterate to next element or if current element is 0, end program
check2:
    mov ax, cx
    mov bx, 3
    ;cwd is used to extend ax to dx:ax. This is important for dividing negative signed numbers,
    ;as we need to assign the leading bits to 1 or f in hex. For example, using cwd on ax where
    ;ax is -100 turns dx = 0xffff and ax = 0xff9c, so that when we divide by a 16 bit register(let's say cx), 
    ;it succesfully divides; -100/2 = dx:ax/cx = oxffffff9c/0x0002. If we didnt use cwd, it wouldve been
    ;0x0000ff9x/0x0002 which will lead to an incorrect answer
    cwd
    idiv bx
    
    cmp dx, 0
    je whileLoop
    
    add word[div3Sum], cx
    mov word[newArr + r11], cx
    add r11, 2
    
    cmp cx, 0
    jne whileLoop


end:
    mov rax, 60
    mov rdi, 0
    syscall

