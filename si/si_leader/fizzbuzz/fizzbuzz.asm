; This program prints out fizz if test number is divisble by 2, buzz if divisible by 3, and
; fizzbuzz if divisible by both

; Assembly code reads top to bottom, but what if we have code we don't want to run(like if statements)
; IN that case, we use jmp command to jump to a different lines and skips one we dont want to execute
; In this programs, we have 4 possible cases as to what tnum can be: divisible by 3, divisible by 2, 
; divisible by both 3 and 2, divisible by niether 3 and 2
; The code is assembled in a way that lets all of these possibilities occur without distrubing each other
;

;Case 1: tnum is divisble by 3
	;will check if divisble by 2, it is not, so jmp div_2 will do nothing
	;next up, will check if tnum is divisble by 3, it is, so it will jump to div_3 with line 'je div_3'
	;prints 'buzz' and jumps to the end because we already checked if tnum is divisible by 2.
	;if we dont jump to the end, the div_2 label will run and print fizz and we dont want that
	
;Case 2: tnum is divisible by 2 AND 3
	;will check if divisible by 2, it is, so we jump to div_2, which skips div_3 and the checking of 
	;if tnum is divisible by 3.
	;div_2 prints 'fizz' but we should also print buzz(since tnum is also divisble by 3). That's why
	;we jumped back to a lable that checks to see if ah is 0 when dividing by 3(located under div_2), which it is.
	;this will have us jump to div_3 and print 'buzz' and then jumps to end
	
;Case 3: tnum is divisible by 2
	;will check if tnum is divisble by 2, it is, so jumps to div_2(skipping 'divisible by 3' work)
	;prints 'fizz'
	;next, we checks if divisble by 3, its not, so we dont jump to div_3. We have this just in case 
	;tnum is also divisible by 3 along with 2. Instead we jump to end label dicted by line 65
	;code ends
	
;Case 4: Divisible by neither 3 or 2
	;checks if tnum is divisible by 2, its not, so does not jump
	;checks if tnum is divisble by 3, its not, so does not jump
	;if we are at this point, we jump to the end, ending the program without returning anything

section .data
	tnum db 4
	fizz db "Fizz", 0
	buzz db "Buzz", 10
	
section .text
	global _start
	
_start:
	;here we are checking if tnum is divisble by 2. If it is, we jump to div_2 label to print out fizz
	
	mov al, byte[tnum]	;saving al as the value of tnum
	mov ah, 0		;making sure ah(which we will use as the remainder) is clear
	mov cl, 2		;saving the desired divisor into the cl register which is 2 in this case
	div cl			;dividind al(tnum) by cl(2) and saving quotient to al and remainder to ah
	cmp ah, 0		;compares ah(the remainder after tnum/2) to 0.
				;if ah is 0, that means tnum IS divisble by 2
	je div_2		;je jump to div_2 label if ah and 0 are equal(prev line)
							
	;here we are checking if tnum is divisble by 3. If it is, we jump to div_3 label to print out buzz
	check3:
		mov al, byte[tnum]	;saving al as the value of tnum
		mov ah, 0		;making sure ah(which we will use as the remainder) is clear
		mov cl, 3		;saving the desired divisor into the cl register which is 3 in this case
		div cl			;dividind al(tnum) by cl(3) and saving quotient to al and remainder to ah
		cmp ah, 0		;compares ah(the remainder after tnum/3) to 0.
					;if ah is 0, that means tnum IS divisble by 3
		je div_3		;je div_3 means jump to div_2 label if ah and 0 are equal(prev line)
		jmp end			;jumping to end execution, see above for explantion
		
	
	;here we are printing buzz
	
	div_3:
		mov rax, 1
		mov rdi, 1
		mov rsi, buzz
		mov rdx, 5
		syscall
		jmp end		;see above to why we jump to end
		
		
	;here we are printing fizz
	
	div_2:
		mov rax, 1
		mov rdi, 1
		mov rsi, fizz
		mov rdx, 4
		syscall
		jmp check3

	
	;terminating execution
	
	end:
	
	mov rax, 60
	mov rdi, 0
	syscall
