; This program uses two labels to create a single loop that iterates through numbers 5-8 and checks if they are divisble by 5, 
; and if it is, the mul5 varibale gets incremented. This program is here to demonstrtae how well students can traverse 
; through code when there are multiple jumps

; This section shows what values the variables hold BEFORE the code gets executed in 'section .text'
section .data

;mul5 is a byte so its 8 bits long or 2 hex digits
mul5	db	0		;mul5 = 0 = 0x00


section .text
	global	_start
_start:
	; used to show the start of number to which we are traversing. 5 becomes the first number where we check if its divisble
	; by 5 or not(which it is)
	mov	cl, 5		;cl = 5 = 0x05 (word-size)
next:
	; in this program, we are dividing by 8 bit registers, and when we do that, the quotient gets stored in al and the remainder in ah. 
	; This is different that words, for example where the quotient gets stored in ax and the remainder in dx
	mov	ah, 0		;setting ah to 0 for every iteration bc we need to clear out the register that contains remainder BEFORE dividing
	; al will be the dividend everytime there is a '->' in comment, that displays the next iteration
	mov	al, cl		;(1st iter) al = cl = 5 = 0x05 -> al = 0x06 -> al = 0x07 -> al = 0x08
	mov	bl, 5		;bl = 5 = 0x05 (all iterations)
	div	bl		;(1st iter)al = al/bl = 1, ah = al%bl = 0 -> al = al/bl = 1, ah = al%bl = 1 
				;-> al = al/bl = 1, ah = al%bl = 2-> al = al/bl = 1, ah = al%bl = 3  
	cmp	ah, 0		; compare ah with 0(all iterations)
	jne	skip		;(jump to skip label if ah != 0): (1st iter) ah = 0, don't jump -> ah = 1, jump to 'skip'
				;-> ah = 2, jump to 'skip' -> ah = 3, jump to 'skip'
	inc	byte[mul5]	; this line will get run when ah == 0 and will increment mul5, which in this case, is only once
				; reminder: even though, we didnt jump to the skip label when reaching the command, the next line 
				; of code that will be read will still be in the skip label. This is because labels do not have a 
				; different scope. they are all within the same scope
skip:
	inc	cl		; (1st iter) cl = cl + 1 = 6 = 0x06 -> cl = 0x07 -> cl = 0x08 -> cl = 0x09
	cmp	cl, 9		; compare cl with 9(all iterations)
	jne	next		; (jump to next label if cl != 9): (1st iter) cl = 5, jump to 'next' -> cl=6, jump to 'next'
				; -> cl=7, jump to 'next' -> cl = 8, jump to 'next' -> cl = 9, do not jump, exit program
				
; At this point is where we track all the registers/variables AFTER the code executes. Let's start with mul5. AT the beginning,
; mul5 is 0 and is only incemrented by 1 when a number (5-8) is divisble by 5. When the code runs, it only gets incremented 
; once, which means only 5 itself is divisible by 5, so mul5 is 1 or 0x01 in byte-sized hex. 

; Now of ah, al, bl, cl.
; In the last iteration of the loop, cl was 9, and when it is 9, it stops looping and ends the program, so cl ends with 
; 0x09 in byte-sized hex. In our code, during every iteration (except for the last one), al copies cl, and the last number
; it copied was 8, but that's not what al ended in. During the last 'div bl' instruction, al gets divided by 5, which stores 
; the quotient in al and the remainder in ah, so since 8/5 is 1 R 3, al ends with 1 or 0x01 and ah ends with 3 or 0x03. 
; For bl, in every ieration. bl always gets stored as 5 so bl ends with 5 or 0x05 in byte sied hex form.

;exits the program
	mov rax, 60
	mov rdi, 0
	syscall
