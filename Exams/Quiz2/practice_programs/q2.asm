; unsigned short num1 = 325, 510, 35, 333, 82, 101, 455, 250, 98
; unsigned short even, odd
; even = 0;
; odd = 0;
; cl = 1;
; rsi = 0;
; do {
; 	if(num1[rsi] % 2 != 0) {
;     	   odd++;
;	} else {
;	  even++;
;       }
;	rsi++; in assembly, it has to be cl = cl + 2 because we have to move 2 bytes to get to the next element
;	cl++;
; }while(cl <= 10);

section .data
	num1	dw	325, 510, 35, 333, 82, 101, 455, 250, 98
	bytes
section .bss
	even	resw	1
	odd	resw	1
	
section .text
	global _start
	
_start:

	mov	word[even], 0
	mov	word[odd], 0
	mov	rsi, 0
	mov	cl, 1	
doloop:
	mov	ax, word[num1 + rsi]
	mov	bl, 2
	div	bl
	cmp	ah, 0
	jne	is_odd
	inc	word[even]
	jmp	end_if

is_odd:
	inc word[odd]
	
	
end_if:
	add	rsi, 2
	inc	cl
	cmp	cl, 10
	jbe	doloop
	
	mov	rax, 60
	mov	rdi, 0
	syscall
