section .text
	global arr_min_max
	
arr_min_max:

	mov	rax, 0
	mov	r10, rsi
	mov	r11, 0
	mov 	eax, dword[rdi + r11]
	mov	dword[rcx], eax
	mov	dword[rdx], eax

arr_loop:
	add	r11, 4
	mov	eax, dword[rdi + r11]
	
	;compares if current element is greater than max. If so, goes to max_found label
	cmp	eax, dword[rcx]
	jg	max_found
	
	;compares if current element is less than min. If so, goes to min_found label
	cmp	eax, dword[rdx]
	jl	min_found
	
	;goes here if neither >max nor <min. If iterations are over, jmps to end label
	dec	r10
	cmp	r10, 1
	jne 	arr_loop
	jmp	end
	
;changes min to current element, loops back. If loop itearions are over, jumps to end
min_found:
	mov	dword[rdx], eax
	dec	r10
	cmp	r10, 1
	jne	arr_loop
	jmp 	end

;changes max to current element, loops back. If loop itearions are over, goes to end
max_found:
	mov	dword[rcx], eax
	dec	r10
	cmp	r10, 1
	jne	arr_loop
	
end:
	ret
