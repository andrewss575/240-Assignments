; This code will find the area of a triangle using 
; newly taught div and mul operators

section .data
	;setting up the variables as words
	;(for what we are trying to do, we dont need ,more space than that)
	;TIP: we use ax, bx, cx, dx registers for words(dw)
	base	dw	59
	height	dw	27
	area	dw	0
	
section .text
	global _start

_start:
	
	;moving the value stored in base in ax register
	;we put 'word' behind [base] to specify that base is a word(16 bits). 
	;We don't have to do this since assembly will find out it's a 
	;word but its a good convention, as it it provides cleaner code
	mov	ax, word[base]


	; mutiplies the value of height(27) to ax register(now 59) and saves
	; it to ax
	mul	word[height]
	;moving the new value of ax(1593) to ax
	mov	word[area], ax
	
	;for division, dx is used to store remainders, so we set it 
	;to 0 to erase any memory that may have been saved to it
	mov	dx, 0

	;setting up the divisor and save that to cx. could also be bx or dx
	mov	cx, 2
	;divide ax by cx(1593/2). div and mul know to use ax(rax, eax for bigger numbers)
	div	cx
	;moves new value of ax to area
	mov	word[area], ax
	
	;ends execution
	mov	rax, 60
	mov	rdi, 0
	syscall
	
