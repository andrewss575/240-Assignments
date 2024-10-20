; ex2_addition.asm
; short num1 = 30000, num2 = 40000
; int sum = 0;
; sum = int(num1 + num2);

section .data
        num1     dw      30000                                   ;num1 = 7530h
        num2     dw      40000                                   ;num2 = 9C40h
        sum      dd      0                                       ;sum = 0000h

section .text
        global _start

_start:
	mov	bx, 0
        mov     ax, word[num1]                                  ;ax = num1 = 7530h
        add     ax, word[num2]                                  ;ax = ax + num2 = 1170h(4464 in 		
        							;decimal) which is the remainder after
        							;all 65536 of ax register is used up
        ; becasue we are working with bigger numbers, 
        ; we cannot use ah and al and then have ax be 
        ; desired output(see base_add.asm). We need 
        ; 16-bit registers so we use ax and bx and
        ; manually crunch them together(as seen in line 39 and 40).
        ; all values are inputed into the stack	and each section 
        ; of the stack is 8 bits. Because ax is 16 bits, line 27 
        ; saves sum as ax(0x1170) which takes up two boxes of the stack(sum+0 and sum+1). 
        ; We want to moosh ax and bx into sum so we add bx into [sum+2]
        ; because the first two boxes are already occupied by ax. See 
        ; add_stack_rep.jpg for visual explanation	
        
        ; Note: no matter what number you have that can fit into dw(double_word), 
        ; when you add num1 and num2 and it overflows 16-bits, the overflow will 
        ; always be one extra bit and will always be 1, resulting in a 17-bit sum. Thats why CF is useful 
        ; here because it can only be 0 or 1 (T or F). And because we dont have a 17bit data, 
        ; we use the sum as 32 bits (double word), hence the leading 0's in 0001 1170h	as sum
        	
	adc	bx, 0						;bx = bx + 0 + CF = 0001h = 1
        mov     word[sum+0], ax                                 ;sum = ax = 1170Ch
	mov     word[sum+2], bx					;sum = ax & bx = 00011170h = 70000
	
        mov     rax, 60                                         ;terminate excuting process
        mov     rdi, 0                                          ;exit status
        syscall                                                 ;calling system services
