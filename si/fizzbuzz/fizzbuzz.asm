; This program prints out fizz if test number is divisble by 3, buzz if divisible by 5, and
; fizzbuzz if divisible by both

; Assembly code reads top to bottom, but what if we have code we don't want to run(like if statements)
; IN that case, we use jmp command to jump to a different lines and skips one we dont want to execute
; In this programs, we have 4 possible cases as to what tnum can be: divisible by 5, divisible by 3, 
; divisible by both 5 and 3, divisible by niether 5 and 3
; The code is assembled in a way that lets all of these possibilities occur without distrubing each other
;

;Case 1: tnum is divisble by 5
	;will check if divisble by 3, it is not, so jmp div_3 will do nothing
	;next up, will check if tnum is divisble by 5, it is, so it will jump to div_5 with line 'je div_5'
	;prints 'buzz' and jumps to the end because we already we already check if divisible by 3
	;if we dont jump to the end, the div_3 label will run and print fizz and we dont want that
	
;Case 2: tnum is divisible by 3 AND 5
	;will check if divisible by 3, it is, so we jump to div_3, which skips div_5 and the checking of 
	;if tnum is divisible by 5.
	;div_3 prints 'fizz' but we should also print buzz(since tnum is also divisble by 5). That's why
	;we have repeated code of checking if tnum is divisbible by 5(located under div_3), which it is.
	;this will have us jump to div_5 and print 'buzz' and then jumps to end
	
;Case 3: tnum is divisible by 3
	;will check if tnum is divisble by 3, it is, so jumps to div_3(skipping 'divisible by 5' work)
	;prints 'fizz'
	;next, we checks if divisble by 5, its not, so we dont jump to div_5. We have this just in case 
	;tnum is also divisible by 5 along with 3
	;code ends
	
;Case 4: Divisible by neither 5 or 3
	;checks if tnum is divisible by 3, its not, so does not jump
	;checks if tnum is divisble by 5, its not, so does not jump
	;if we are at this point, we jump to the end, ending the program without returning anything

section .data
	tnum dw 15
	fizz db "Fizz", 0
	buzz db "Buzz", 10
	
section .text
	global _start
	
_start:
	;here we are checking if tnum is divisble by 3. If it is, we jump to div_3 label to print out fizz
	
	mov ax, word[tnum]	;saving ax as the value of tnum
	mov dx, 0		;making sure dx(which we will use as the remainder) is clear
	mov cx, 3		;saving the desired divisor int cx register which is 3 in this case
	div cx			;dividind ax(tnum) by cx(3) and saving it to ax
	cmp dx, 0		;compares dx(the remainder after tnum/3) to 0.
				;if dx is 0, that means tnum IS divisble by 3
	je div_3		;je jump to div_3 label if the two dx and 0 are equal(prev line)
				
				
	;here we are checking if tnum is divisble by 5. If it is, we jump to div_5 label to print out buzz
	
	mov ax, word[tnum]
	mov ax, word[tnum]	;saving ax as the value of tnum
	mov dx, 0		;making sure dx(which we will use as the remainder) is clear
	mov cx, 5		;saving the desired divisor int cx register which is 5 in this case
	div cx			;dividind ax(tnum) by cx(5) and saving it to ax
	cmp dx, 0		;compares dx(the remainder after tnum/5) to 0.
				;if dx is 0, that means tnum IS divisble by 5
	je div_5		;je div_5 means jump to div_3 label if dx and 0 are equal(prev line)
	jmp end			;jumping to end execution, see above for explantion
	
	
	;here we are printing buzz
	
	div_5:
		mov rax, 1
		mov rdi, 1
		mov rsi, buzz
		mov rdx, 5
		syscall
		jmp end		;see above to why we jump to end
		
		
	;here we are printing fizz
	
	div_3:
		mov rax, 1
		mov rdi, 1
		mov rsi, fizz
		mov rdx, 4
		syscall
	
	
	;checking if tnum is divisble by 5 AGAIN. See above for explantion
	
	mov ax, word[tnum]
	mov dx, 0
	mov cx, 5
	div cx
	cmp dx, 0
	je div_5
	
	
	;terminating execution
	
	end:
	
	mov rax, 60
	mov rdi, 0
	syscall
