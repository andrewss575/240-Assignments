
section .data
str1    db      "1 + 2 + 3 +...+ 10 = "
sum     dw      0
ascii   db      "00", 10

section .text
        global _start
_start:
	; calculates 1+2+3+...+100
	mov	cx, 1						
doloop:
        add     word[sum], cx					
        inc     cx						
        cmp     cx, 100						
        jbe     doloop						
	
	mov 	ah, byte[sum]						
	mov	al, byte[sum+1]					
	
	; exit program
        mov     rax, 60					
        mov     rdi, 0						
        syscall	
