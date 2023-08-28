; unsigned char num1 = 250;	//data type: 8 bits
; unsigned char num2 = 200;	//data type: 8 bits
; unsigned char num3 = 120;	//data type: 8 bits
; unsigned short sum = 0	//data type: 16 bits
; unsigned int product = 0;	//data type: 32 bits

; sum = num1 + num2;
; product = sum * short(num3);


section .data
        num1     db      250                                   
        num2     db      200                                   
        num3     db      120                                   
        sum	 dw	 0				       
        product	 dd	 0				       
        
section .text
        global _start

_start:
	
	;adding num1 and num2 using ah and al registers
	mov	ah, 0
	mov	al, byte[num1]
	add	al, byte[num2]
	adc	ah, 0
	mov	word[sum], ax
	
	;when multiplying, the number's bit size must be same so convert 
	;byte size num3 into word size using movzx and dx register
	mov	dl, byte[num3]
	movzx	dx, dl
	
	;multiplying num3 * sum using dx and eax registers
	mul	dx
	mov	dword[product], eax
	
;----------------------------AFTER QUIZ REALIZATION----------------------------------------
;line 37 is unconventional because the mul operator has a relationship 
;with ax and dx. Even though dx is 0 because the product btwn sum and num3 is not bigger
;than a word, we have to include it. When we mov dword[product], eax, we are saving product
;in 32 bits like instructed but we forgot to include the dx, in case it had some value with
;it(which it doesnt in this case but  we still need it for the cases in which it does have
;something) so the better line will be :
	
	;mov	word[product+0], ax
	;mov	word[product+2], dx
	
; this way, product is still a double word but includes dx
;---------------------------------------------------------------------------------------
	mov     rax, 60                                         ;terminate excuting process
        mov     rdi, 0                                          ;exit status
        syscall                                                 ;calling system services
	
