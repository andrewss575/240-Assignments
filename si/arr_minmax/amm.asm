; Given an array, this program finds the min and max value of that array
;the array is made of of word sized numbers so you must add 2 in order to get to next element

section .data
	array	dw	1000, 750, 500, 250, 1250, 1500, 350
	min	dw	0
	max	dw	0
	
section .bss
	
	
section .text
	global _start
	
_start:

;sets the min and max to the first element of the array. I did this so it could have some value 
;to check if its greater than or lress than the next element of the array
	mov 	rax, 0
	mov 	rcx, 6			;counter register
					;There are 7 elements in the array so I set counter to 6
	mov 	rsi, 0			;offset register to offset the array
	mov 	ax, word[array + rsi]	;ax = array[0] = 1000
	mov	word[max], ax		;max = 1000
	mov	word[min], ax		;min = 1000

arr_loop:
	;moves ax to the next element of the array by adding 2 to the offset.
	;Adding 2(bytes) bc array is a word(2-bytes or 16 bits)
	add	rsi, 2
	mov	ax, word[array + rsi]
	
	;compares if current element is greater than max. If so, goes to max_found label
	cmp	ax, word[max]
	jg	max_found
	
	;compares if current element is less than min. If so, goes to min_found label
	cmp	ax, word[min]
	jl	min_found
	
	;goes here if neither >max nor <min. If iterations are over, jmps to end label
	loop 	arr_loop		;dec rcx, cmp rcx, 0, jne arr_loop
	jmp	end			;reach here when rcx is 0, so no more elements in array
	
;changes min to current element, loops back. If loop itearions are over, jumps to end
min_found:
	mov	word[min], ax		;min = ax = current element in array
	loop 	arr_loop		;dec rcx, cmp rcx, 0, jne arr_loop
	jmp 	end			;reach here when rcx is 0, so no more elements in array

;changes max to current element, loops back. If loop itearions are over, goes to end
max_found:
	mov	word[max], ax		;max = ax = current element in array
	loop 	arr_loop		;dec rcx, cmp rcx, 0, jne arr_loop
					;if rcx == 0, will skip loop and go straight to end label
	
end:
	mov	rax, 60
	mov	rdi, 0
	syscall
