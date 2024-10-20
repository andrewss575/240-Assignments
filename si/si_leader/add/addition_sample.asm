;This code is what the professor gave us. It is our job to edit this code to fit bigger values

; ex2_addition.asm
; byte num1 = 200, num2 = 100, sum = 0;
; sum = num1 + num2;

section .data

	; initializes values. The goal is to add num1 and num2 to sum. num1 and num2 are both 
	; bytes (8 bits) so only values (0-255 for unsigned) or (-128-127 for signed) can be 
	; in them. Since we know that sum is going to be bigger than 255, we changing it to a 
	; word, wich is 16 bits
        num1     db      100   ;num1 = 64h
        num2     db      200   ;num2 = 0C8h
        sum      dw      0     ;sum = 00h

section .text
        global _start

_start:
	; clear the high byte of the AX register
	mov	ah, 0
	
	; moves value of num1 into al(8 bit register). al is now 100
        mov     al, byte[num1]  ;al = num1 = 64h
        
        ; adds al(100) and num2(200) to al to make it 44
        ; it is 44 because al is 8bits and we need more room for the leading bit (since 300 is 9 bits big)
        ; 44 represents what 300 is without that leading bit. We need to retreive that remaining bit from CF    
        add     al, byte[num2]  ;al = al + num2 = 2Ch = 44
        
        ; Carry Flag changes to 1 when the sum is bigger than the register storing it
        ; adc adds the carry flag (CF) to the ah register (ah = ah + CF + 0)
        ; what it does is since al reached its max, adc adds CF(which would be 1 since
        ; al reached all 256 digits(0-255)) to ah
	adc	ah, 0		;ah = ah + 0 + CF = 01h  
	      
	;since al and ah are part of ax, we mov ax to sum. ah has 01(which lets it known
	; that al had all 256 digits filled) and al has the 44 that represents 300 in binary without the leading bit
	
	;PLEASE NOTE that this only works for ah and al register. For bigger registers, you need to store the
	; CF into a SEPERATE register and crunch them together into the sum variable
	mov     word[sum], ax   ;sum = ax = 012Ch

        mov     rax, 60                                         ;terminate excuting process
        mov     rdi, 0                                          ;exit status
        syscall                                                 ;calling system services
