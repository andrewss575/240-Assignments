;quiz01_1.asm
;unsigned char num1 = 250;			//data type: 8 bits
;unsigned char num2 = 200;			//data type: 8 bits
;unsigned char num3 = 120;			//data type: 8 bits
;unsigned short sum = 0				//data type: 16 bits
;unsigned int product = 0;			//data type: 32 bits
;sum = num1 + num2;
;product = sum * short(num3);

section .data
        num1      db      250			;num1 = FAh
        num2      db      200			;num2 = C8h
        num3      db      120			;num3 = 78h
        sum	  dw      0			;sum =  0000h
	product	  dd      0			;product = 0000 0000h

section .text
        global _start
_start:
	mov	ah, 0				;ah = 0
	mov     al, byte[num1]			;al = num1 = FAh
	add     al, byte[num2]			;al = al+num2 = FAh+C8h = C2h
	adc	ah, 0				;ah = ah+0+CF = 01h
	mov	word[sum], ax			;sum = ax = 01C2h

	mov	al, byte[num3]			;al = num3 = 78h
	cbw					;convert al to ax = 0078h
	mul	word[sum]			;dx:ax = ax*sum = 0000:D2F0h
	mov     word[product+2], dx		;product+2 = dx = 0000h
	mov     word[product+0], ax		;product+0 = ax = D2F0h

	mov     rax, 60				;terminate excuting process
	mov     rdi, 0				;exit status
	syscall					;calling system services
