; ex2_subtraction.asm
; byte num1 = 100, num2 = 200, sum = 0;
; sum = num1 - num2;

section .data
	; initializaizng data values we need to subtract(comments show their hex)
	; note that even though dif will be -100(which cant fit in a byte), we 
	; intialize it as a word because using 1's compliment -100 is defined as 1111 1111 1001 1100 
	; which is bigger than a byte
        num1     db      100                                    ;num1 = 64h
        num2     db      200                                    ;num2 = 0C8h = 200
        dif      dw      0                                      ;dif = 00h

section .text
        global _start

_start:
	; moves byte to al register
        mov     al, byte[num1]                                  ;al = num1 = 64h
        
        ; subtracts num1 from al(num2), which makes al 156 because al only saves 1001 1100 which would be 
        ; -100 if all the 1's were part of it. 1001 1100 = 156 where 1111 1111 1001 1100 = -100. This is why
        ; we used sbb to get the correct value. The Carry Flag (CF) becomes 1 because the differnece is a 
        ; negative number(-100)
        sub     al, byte[num2]                                  ;al = al - num2 = 9ch
        
        ; sbb subtracts CF from the sepcified register(ah = ah - 0 - 1(CF))
        ; this results to -1 or 1111 1111 or 0xff and saves it to ah.
        ; The carry flag (CF) is set to 1 after the sub instruction because 
        ; the subtraction of num2 from num1 requires a borrow(a negative number). When the subtraction is performed, 
        ; the processor subtracts the least significant byte of num2 from the least significant byte 
        ; of num1, and sets the carry flag if a borrow is required. The borrow occurs because num2 
        ; is greater than num1 in this case

	sbb	ah, 0						;ah = ah - 0 - CF = 0ffh
	
	; moves dif to ax which equals ah and al combined, making 1111 1111 1001 1100 or 0xff9c
	; note that 0xff9c or 1111 1111 1001 1100 is also 65436 when unsigned but -100 when signed. 
	; Also note that the 1111 1111 tells it that the number is negative when signed
	; Also note that this approach only works when dealing with 8 bit registers. If we are subtracting 
	; using a higher bit register, you would have to subtract the CF(sbb) from a register other than rax. 
	; Then you have two registers representing a single value which could then be combined to a variable(diff)
	; to form that single value
        mov     word[dif], ax                                   ;dif = ax = 0ff9ch = -100

        mov     rax, 60                                         ;terminate excuting process
        mov     rdi, 0                                          ;exit status
        syscall                                                 ;calling system services
