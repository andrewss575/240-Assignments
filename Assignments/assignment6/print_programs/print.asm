; char str1[] = "1+2+3+...+100=";
; register char cx = 1;
; short sum = 0;
; char ascii[5] = "0000\n";
; for(cx=1; cx<=100; cx++)
;     sum += cx;
; ascii = itoa(sum);
; cout << str1 << ascii;

section .data
	str1	db	"1 + 2 + 3 + ... + 100 = "
	sum	dw	0
	ascii	db	"0000", 10			;ascii = 30h 30h 30h 30h 10h(new line)

section .text
	global _start

_start:

	; I was having trouble adding cx directly to sum and then sum to ax(idk why) so I used bx as a catalyst
	
	;finding the sum of 1+2+3+...+100
	mov	cx, 1					;cx = 1
	mov	bx, word[sum]				;bx = sum = 0
	sumloop:
		add	bx, cx				;bx = cx + bx
		inc	cx				;cx++
		cmp	cx, 100				;compare cx and 100
		jbe	sumloop				;if(cx<=100) jump to sumloop
		
	;turning sum into ascii	
	mov	word[sum], bx				;sum = bx = 5050
	mov	rbx, 0					;rbx = 0
	
	;getting the first digit
	mov	ax, word[sum]				;ax = sum = 5050
	cwd						;ax = ax:dx (changes 16 bit to 32 bit register)
	mov	bx, 1000				;bx = 1000
	div	bx					;ax = 5050/1000 = 5 ;bx = 5050%1000 = 50
        add     byte[ascii+0], al			;ascii+0 = al + 30h = 5 + 30h = 35h = '5'
        						;ascii = '5000', 10					
        ;getting the second digit			
        mov	ax, dx					;ax = dx = 50
        cwd						;ax = ax:dx (changes 16 bit to 32 bit register)
        mov	bx, 100					;bx = 100
        div	bx					;ax = 50/100 = 0 ;bx = 50%100 = 50
        add     byte[ascii+1], al			;ascii+1 = al + 30h = 0 + 30h = 30h = '0'
        						;ascii = '5000', 10
        ;getting the third digit
	mov	ax, dx					;ax = dx = 50
	cwd						;ax = ax:dx (changes 16 bit to 32 bit register)
        mov	bx, 10					;bx = 10
        div	bx					;ax = 50/10 = 5 ;bx = 50%100 = 0
        add     byte[ascii+2], al			;ascii+2 = al + 30h = 5 + 30h = 35h = '5'
        						;ascii = '5050', 10   						
        ;getting the 4th digit
        mov	ax, dx					;ax = dx = 0
        cwd						;ax = ax:dx (changes 16 bit to 32 bit register)
        mov	bx, 1					;bx = 1
        div	bx					;ax = 0/1 = 0 ;bx = 0%1 = 1
        add     byte[ascii+3], al			;ascii+3 = al + 30h = 0 + 30h = 30h = '0'
							;ascii = '5050', 10 
	; cout << str1
        mov     rax, 1					;SYS_write
        mov     rdi, 1					;where to write
        mov     rsi, str1				;address of str1
        mov     rdx, 24 				;24 character to write
        syscall						;calling system services

	; cout << ascii
        mov     rax, 1					;SYS_write
        mov     rdi, 1					;where to write
        mov     rsi, ascii				;address of ascii
        mov     rdx, 5					;5 character to write(including newline)
        syscall						;calling system services
	
	;exit call
	mov rax, 60
	mov rdi, 0
	syscall
	
