; ex6_coutSum.asm
; Calculates  1+2+3+...+10 and displays the result in a terminal window
; char str1[] = "1+2+3+...+10=";
; char sum = 0;
; char ascii[3] = "00\n";
; for(cl=1; cl<=10; cl++)
;    sum += cl;
; ascii = itoa(sum);
; cout << str1 << ascii;

section .data
str1    db      "1 + 2 + 3 +...+ 10 = "
sum     db      0
ascii   db      "00", 10

section .text
        global _start
_start:
	; calculates 1+2+3+...+10
	mov	cl, 1						;cl = 1
doloop:
        add     byte[sum], cl					;sum = sum + cl
        inc     cl						;cl = cl + 1
        cmp     cl, 10						;compare cx and 10
        jbe     doloop						;if(cl<=10) jump to doloop
	
	; converts integer to ascii code
	mov 	ah, 0						;ah = 0
	mov	al, byte[sum]					;al = sum
	mov	bl, 10						;bl = 10 = 0ah
	div	bl						;ah = ax%10, al = ax/10
        add     byte[ascii+0], al				;ascii+0 = al + 30h = '5'
        add     byte[ascii+1], ah				;ascii+1 = ah + 30h = '5'
	mov	byte[ascii+2], 10				;add '\n' at the end

	; cout << str
        mov     rax, 1						;SYS_write
        mov     rdi, 1						;where to write
        mov     rsi, str1					;address of str1
        mov     rdx, 21						;21 character to write
        syscall							;calling system services

	; cout << ascii
        mov     rax, 1						;SYS_write
        mov     rdi, 1						;where to write
        mov     rsi, ascii					;address of ascii
        mov     rdx, 3						;3 character to write
        syscall							;calling system services

	; exit program
        mov     rax, 60						;terminate excuting process
        mov     rdi, 0						;exit status
        syscall							;calling system services