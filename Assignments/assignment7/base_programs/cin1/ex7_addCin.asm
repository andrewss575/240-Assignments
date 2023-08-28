; ex7_addCin.asm
; char msg1[25] = "Input 1st number (0~9): "
; char msg2[25] = "Input 2nd number (0~9): "
; char asc3[4] = "00\n";
; char plus = '+', equal = '=';
; char num1, num2, sum;
; char asc1[2], asc2[2];
; cout << msg1; 
; cin >> asc1; 
; num1 = atoi(asc1);
; cout << msg2; 
; cin >> asc2;
; num2 = atoi(asc2);
; sum = num1 + num2;
; asc3 = itoa(sum);
; cout << asc1[0] << '+' << asc2[0] << '=' << asc3;

section .data
	msg1	db	"Input 1st number (0~9): "		;input message
	msg2	db	"Input 2nd number (0~9): "		;input message
	asc3	db	"00", 10				;asc3 = 30,30,10
	plus	db	'+'
	equal	db	'='

section .bss
	num1	resb	1					;num1 = 00h
	num2	resb	1					;num2 = 00h
        sum	resb    1					;sum = 00h
        asc1	resb	2					;asc1 = 0000h
        asc2	resb	2					;asc2 = 0000h

section .text
        global _start

_start:
	; cout << meg1
        mov     rax, 1						;SYS_write
        mov     rdi, 1						;write to STD_OUT
        mov     rsi, msg1					;address of msg1
        mov     rdx, 24						;24 character to write
        syscall							;calling system services

	; cin >> num1
	mov	rax, 0						;SYS_read
	mov	rdi, 0						;read from STD_IN
	mov	rsi, asc1					;address of the asc1
	mov	rdx, 2						;input length = 1
	syscall							;calling system services
	mov	al, byte[asc1]					;al = asc1 (ex: '5'=35h)
	and	al, 0fh						;al = block bit7~4 (ex: 05h)
	mov	byte[num1], al					;num = al (ex: num1=05h)

	; cout << meg2
        mov     rax, 1						;SYS_write
        mov     rdi, 1						;write to STD_OUT
        mov     rsi, msg2					;address of msg2
        mov     rdx, 24						;24 character to write
        syscall							;calling system services

	; cin >> num2
	mov	rax, 0						;SYS_read
	mov	rdi, 0						;read from STD_IN
	mov	rsi, asc2					;address of the asc1
	; its 2 instead of 1 because memory still stores the enter input from previous cin
	mov	rdx, 2						;input length = 1
	syscall							;calling system services
	mov	al, byte[asc2]					;al = asc2 (ex: '7'=37h)
	and	al, 0fh						;al = block bit7~4 (ex: 07h)
	mov	byte[num2], al					;num2 = al (ex: num1=07h)

	;sum = num1 + num2
	mov	al, byte[num1]					;al = num1 = 05h
	add	al, byte[num2]					;al = num1+num2 = 0Ch = 12
	mov	byte[sum], al					;sum = al = 0Ch = 12

	;converts sum to asc3 code
	mov 	ah, 0						;ah = 0
	mov	al, byte[sum]					;al = sum
	mov	bl, 10						;bl = 10 = 0ah
	div	bl						;ah = ax%10, al = ax/10
        add     byte[asc3+0], al				;asc3+0 = al + 30h = '1'
        add     byte[asc3+1], ah				;asc3+1 = ah + 30h = '2'

	;cout << asc1
	mov     rax, 1						;SYS_write
        mov     rdi, 1						;where to write
        mov     rsi, asc1					;address of asc1
        mov     rdx, 1						;1 character to write
        syscall							;calling system services

	;cout << '+'
	mov     rax, 1						;SYS_write
        mov     rdi, 1						;where to write
        mov     rsi, plus					;address of plus
        mov     rdx, 1						;1 character to write
        syscall							;calling system services

	;cout << asc2
	mov     rax, 1						;SYS_write
        mov     rdi, 1						;where to write
        mov     rsi, asc2					;address of asc2
        mov     rdx, 1						;1 character to write
        syscall							;calling system services

	;cout << '='
	mov     rax, 1						;SYS_write
        mov     rdi, 1						;where to write
        mov     rsi, equal					;address of equal
        mov     rdx, 1						;1 character to write
        syscall							;calling system services

	;cout << asc3
	mov     rax, 1						;SYS_write
        mov     rdi, 1						;where to write
        mov     rsi, asc3					;address of asc2
        mov     rdx, 3						;1 character to write
        syscall							;calling system services

        mov     rax, 60                                         ;terminate excuting process
        mov     rdi, 0                                          ;exit status
        syscall                                                 ;calling system services
