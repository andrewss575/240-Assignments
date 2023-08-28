; Given an array, this program finds the min and max value of that array

section .data
	array	dw	1000, 750, 500, 250, 1250, 1500, 350
	min	dw	0
	max	dw	0
	
section .text
	global _start
	
_start:

;sets the min and max to the first element of the array. I did this so it could have some value 
;to check if its greater than or lress than the next element of the array
	mov 	rax, 0
	mov 	rcx, 6
	mov 	rsi, 0
	mov 	ax, word[array + rsi]
	mov	word[max], ax
	mov	word[min], ax

arr_loop:
	;moves ax to the next element of the array
	add	rsi, 2
	mov	ax, word[array + rsi]
	
	;compares if current element is greater than max. If so, goes to max_found label
	cmp	ax, word[max]
	jg	max_found
	
	;compares if current element is less than min. If so, goes to min_found label
	cmp	ax, word[min]
	jl	min_found
	
	;goes here if neither >max nor <min. If iterations are over, jmps to end label
	loop 	arr_loop
	jmp	end
	
;changes min to current element, loops back. If loop itearions are over, jumps to end
min_found:
	mov	word[min], ax
	loop 	arr_loop
	jmp 	end

;changes max to current element, loops back. If loop itearions are over, goes to end
max_found:
	mov	word[max], ax
	loop 	arr_loop
	
end:
	mov	rax, 60
	mov	rdi, 0
	syscall
