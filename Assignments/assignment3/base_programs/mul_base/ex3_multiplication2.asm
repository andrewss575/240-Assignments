; ex3_multiplication.asm
; byte num1 = 6, num2 = 3;
; short mult = 0;
; mult = num1 * num2;

section .data
        num1     dw      2500                                   ;num1 = 09C4h
        num2     dw      3500                                   ;num2 = 0DACh
        mult     dd      0                                      ;mult = 0000 0000h

section .text
        global _start

_start:
	; Note: Look at slide 49 in chapter 7 slides to get the instructions on what register to use when multiplying
	; For this example, we are using 2 words(16-bit) so use ax register. The result will lead in overflow;
	; that's why mul uses dx register for what's left over by taking the leading hex digits.

        mov     ax, word[num1]                                  ;al = num1 = 09C4h
        
        ; multiplies num1 * num2 which in hex is 8583B0h but thats 24-bits so we use dx to take some of the leading
        ; digits(dx:ax = 0085h:83B0h). This way, dx and ax both remain within their 16-bit scope of space.
        mul     word[num2]                                  	;dx:ax = ax * num2 = 0085h:83B0h
        
        
        ;see assignment1 addition base program asm file to get a better idea to following lines
        
        ;moving ax into the first two stack spaces because each space fits 8-bits and ax is 16-bits
        mov     word[mult], ax                                  ;mult = ax = 83B0h
        
        ;moving dx into the last two stack spaces for mult because each space fits 8-bits and dx is 16-bits
        mov     word[mult+2], dx                                ;mult+2 = dx = 0085h

        mov     rax, 60                                         ;terminate excuting process
        mov     rdi, 0                                          ;exit status
        syscall                                                 ;calling system services
