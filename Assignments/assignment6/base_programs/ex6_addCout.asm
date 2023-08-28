; ex6_addCout.asm
; char asc1 = '5', asc2 = '7', asc3 = "00\n";
; char num1, num2, sum;
; num1 = atoi(asc1);
; num2 = atoi(asc2);
; sum = num1 + num2;
; asc3 = itoa(sum);
; cout << asc1 << '+' << asc2 << '=' << asc3;

section .data
        asc1	db	'5'					;asc1 = 35h
        asc2	db	'7'					;asc2 = 37h
	asc3	db	"00", 10				;asc3 = 30h,30h,10 (10 is newline)
	plus	db	'+'
	equal	db	'='

section .bss
	num1	resb	1					;num1 = 00h
	num2	resb	1					;num2 = 00h
        sum	resb    1					;sum = 00h

section .text
        global _start

_start:
	;converts asc1 to num1
	mov	al, byte[asc1]					;al = 35h
	and	al, 0fh						;al = al and 0fh = 05h
	mov	byte[num1], al					;num1 = 05h

	;converts asc2 to num2
	mov	bl, byte[asc2]					;bl = 37h
	and	bl, 0fh						;bl = bl and 0fh = 07h
	mov	byte[num2], bl					;num2 = 07h

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
        mov     rdx, 3						;3 characters to write(including new line)
        syscall							;calling system services

        mov     rax, 60                                         ;terminate excuting process
        mov     rdi, 0                                          ;exit status
        syscall                                                 ;calling system services
