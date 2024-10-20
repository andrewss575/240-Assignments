; ex2_subtraction.asm
; byte num1 = 100, num2 = 200, sum = 0;
; sum = num1 - num2;

section .data
	; initializaizng data values we need to subtract(comments show their hex)
	; note that even though dif will be -100 we 
	; intialize it as a word because this code defines -100 as 1111 1111 1001 1100 
	; which is bigger than a byte. The extra 1's essentially show that the number is negative
        num1     db      100                                    ;num1 = 64h
        num2     db      200                                    ;num2 = 0C8h = 200
        dif      dw      0                                      ;dif = 00h

section .text
        global _start

_start:
	; moves byte to al register
        mov     al, byte[num1]                                  ;al = num1 = 64h
        
        ; subtracts num1 from al(num2), which makes al 156 unsigned or 1001 1100 where there are infinite 0's to the left.
        ; It would equal -100 signed if we were to represent it as 1111 1111 1001 1100, so dif should be word-sized
        ; So we have to use sbb instruction because negative numbers are represented with 1's in form of the binary
        ; here we have 1001 1100 = 0x9C = 156 but to get signed representation we 
        ; need 1111 1111 1001 1100 = 0x FF9C = -100. sbb acheives that
        sub     al, byte[num2]                                  ;al = al - num2 = 9ch
        
        ; From the previous instruction, the differenc is less than 0, which means that CF turns to 1.
        ; sbb subtracts CF, which is 1, from 0 which results to -1 or 1111 1111 of 0xff
        ; and saves it to ah. The carry flag (CF) is set to 1 after the sub instruction because 
        ; the subtraction of num2 from num1 requires a borrow. When the subtraction is performed, 
        ; the processor subtracts the least significant byte of num2 from the least significant byte 
        ; of num1, and sets the carry flag if a borrow is required. The borrow occurs because num2 
        ; is greater than num1 in this case. Now ah = 1001 1100 and al = 1111 1111 so if we look at ax as
        ; a whole, we get 1111 1111 1001 1100 = -100


	sbb	ah, 0						;ah = ah - 0 - CF = 0ffh
	
	; moves dif to ax which equals ah and al combined, making 1111 1111 1001 1100 or 0xff9c
	; note that 0xff9c or 1111 1111 1001 1100 is also 65436 when unsigned. 
	; Also note that the 1111 1111 tells it that the number is negative when signed
        mov     word[dif], ax                                   ;dif = ax = 0ff9ch = -100

        mov     rax, 60                                         ;terminate excuting process
        mov     rdi, 0                                          ;exit status
        syscall                                                 ;calling system services
