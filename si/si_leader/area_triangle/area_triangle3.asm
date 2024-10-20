; This code will find the area of a triangle using 
; newly taught div and mul operators. 
; This code is similar to area_triangle2 where it is optimal but uses bigger numbers to show 
; that overflowed bits gets stored in rdx register during muliplication 
; if we use registers bigger than 8 bits

section .data
	;setting up the base and height as words and area as double word because area will be bigger than 16 bits
	;TIP: we use ax, bx, cx, dx registers for words(dw)
	
	base	dw	300
	height	dw	500
	area	dd	0
	
section .text
	global _start

_start:
	
	;moving the value stored in base in ax register
	;we put 'word' behind [base] to specify that base is a word(16 bits). 
	;We don't have to do this since assembly will find out it's a 
	;word but its a good convention, as it it provides cleaner code
	mov	ax, word[base]


	; mutiplies the value of height(500) to ax register(now 300). 
	; the product is bigger than ax can hold so the leading remaining bits gets stored in dx.
	; this is different than when multiplying 8 bit registers which stores remaining bits in ah instead of dx
	mul	word[height]
	
	;we know that both the combination of dx and ax (dx:ax) hold the product of height * base so we have to
	;combine the two registers into a variable so it can be seen as a whole and not two seperate parts
	;the variable has to hold up to 32 bits(a dword) because the product is bigger than word size(16 bits)
	;basically we are extracting values from dx and ax and storing in area.
	;this is not the accurate area yet, we still have to divide
	; unlike the previous programs, we have to do this in order to see the product of base and height as a whole
	; and not seperpate parts. We can then store area into a bigger rax register that is a dword(eax)
	mov	word[area], ax
	mov	word[area+2], dx
	
	;for division, dx is used to store remainders, so we set it 
	;to 0 to erase any memory that may have been saved to it
	mov	dx, 0
	
	;we save the product of base and height(stored in area), and store into an rax register that 
	; supports its size. eax works
	mov	eax, dword[area]
	
	;setting up the divisor and save that to ecx. could also be ebx or edx
	;the reason it is eax is because the diviser and the dividend must be the same size
	mov	ecx, 2
	
	;divide eax by ecx. div and mul know to use eax
	div	ecx
	
	;moves new value of eax to area
	mov	dword[area], eax
	
	;NOTE: We found the area but as a whole number. A remainder occurs in this instance and that gets stored 
	;in dx but we didnt save that into a variable. If you'd like, you can add one :)
	
	;ends execution
	mov	rax, 60
	mov	rdi, 0
	syscall
	
