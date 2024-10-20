; This code will find the area of a triangle using 
; newly taught div and mul operators.
;However, we are utilizing smaller register sizes for more optimal code
; the area is bigger than 256 though, so we still hav that as a word

section .data
	;setting up the base and height as bytes but the area as a word
	base	db	59
	height	db	27
	area	dw	0
	
section .text
	global _start

_start:
	
	;moving the value stored in base in al register
	;we put 'byte' behind [base] to specify that base is a byte(8 bits). 
	;We don't have to do this since assembly will find out it's a 
	;word but its a good convention, as it it provides cleaner code
	mov	al, byte[base]


	; mutiplies the value of height(27) to ah register(now 59) and saves
	; it to al and the remaining leading bits to ah (ax encompasses these values)
	; NOTE: The reamining bits go to an rax subregister(ah) only for 8 bit registers
	; any bigger registers store their remaining leading bits in an rdx register.
	mul	byte[height]
	
	; bc in this case, where remaining leading bits go to ah, you can just ax to capture both ah 
	; and al to get correct product of length*height. Not applicable to higher register sizes though
	; moving the new value of ax(ah and al -> 1593) to area
	; we do not have to do this either since we can simply just use div to divide by 2 since 1593
	; is already in ax
	mov	word[area], ax
	
	; Now we need to divide. Even tough we used bytes for our multiplication, we have to use words for our 
	; division because what we are dividing is the (base*height) which is now a word size number.
	
	; For division, dx is used to store remainders, so we set it 
	; to 0 to erase any memory that my have been saved to it
	mov	dx, 0

	; setting up the divisor and save that to cx. could also be bx or dx
	; we use cx(16 bits) and not cl(8 bits) for storing 2 because the dividend and 
	; the divisior must be the same register size. So if 1593 can fit in a word,
	; than 2 should also be in a word size register
	mov	cx, 2
	
	;divide ax by cx(1593/2). div and mul know to use ax as a dividend(rax, eax for bigger numbers)
	div	cx
	
	;moves new value of ax to area
	mov	word[area], ax
	
	;NOTE: We found the area but as a whole number. A remainder occurs in this instance and that gets stored 
	;in dx but we didnt save that into a variable. If you'd like, you can add one :)
	
	;ends execution
	mov	rax, 60
	mov	rdi, 0
	syscall
	
