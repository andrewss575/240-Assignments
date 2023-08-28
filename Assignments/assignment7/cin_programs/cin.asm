; char num;
; char buffer;
; char msg1[] = "Input a number (1~9) : ";
; char msg2[] = "Multiple of 3 include: ";
;
; register int r10 = 0;
; do {
; 	cout << msg1;
;	cin >> buffer;
;	num = atoi(buffer);
;	if(num%3 == 0) {
;		cout << msg2 << buffer;
;	}
;	r10++;
; } while(r10 < 9);

section	.data
	msg1	db	"Input a number(1-9) : " 
	msg2	db	" is a multiple of 3", 10
	
section	.bss
	num	resb	1
	buffer	resb	1
	
section	.text
	global _start
	
_start:
	mov	r10, 0
next1:
	; cout << mesg
        mov     rax, 1						;SYS_write
        mov     rdi, 1						;write to STD_OUT
        mov     rsi, msg1					;address of mesg
        mov     rdx, 22						;22 character to write
        syscall	
        
        ; cin >> num
	mov	rax, 0						;SYS_read
	mov	rdi, 0						;read from STD_IN
	mov	rsi, buffer					;address of the buffer
	mov	rdx, 2						;input length = 1
	syscall							;calling system services
	
	;converting buffer to int (atoi)
	mov	al, byte[buffer]				;al = buffer (ex: '5'=35h)
	and	al, 0fh						;al = block bit7~4 (ex: 05h)
	mov	byte[num], al					;num = al (ex: num=05h)

	;if(num % 3 == 0), its a multiple of 3
	mov	bl, 3						;b1 = 3 for divisor
	mov	ah, 0						;making ah 0 to prepase its usage as a remainder
	div	bl						;divide user inputed number by 3 and checkin if its 
	cmp	ah, 0						;divisible by comparing it with 0
	je	is_divisible					;jump to is_divisible if remainder = 0
	jmp	skip						;otherwize jump to skip
	
is_divisible:
	; cout << num
        mov     rax, 1						;SYS_write
        mov     rdi, 1						;where to write
        mov     rsi, buffer					;address of buffer
        mov     rdx, 1						;1 character to write
        syscall							;calling system services
        
	; cout << mesg
        mov     rax, 1						;SYS_write
        mov     rdi, 1						;write to STD_OUT
        mov     rsi, msg2					;address of mesg
        mov     rdx, 20						;22 character to write
        syscall	
        
skip:
        inc	r10						;r10 = r10 + 1
	cmp	r10, 8						;compare r10 and 8
	jle	next1						;if r10 <= 8 keep looping to next1
	jmp	end						;else, end program
	
end:
	mov	rax, 60
	mov	rdi, 0
	syscall
