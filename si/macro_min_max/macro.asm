; Given an array, this program finds the min and max value of that array using Macros!
; see arr_minmax.asm file for min and max explanation
; It compiles but doesnt work yet! work on it. UPDATE: FIXED IT

; Argument1: the array to access elements
; Argument2: length to access numberof elements
;changes max to current element, loops back. If loop itearions are over, goes to end
; Argument3: max
; Argument4: min

%macro arr_max_min 4
	mov	rax, 0
	mov	ecx, dword[%2]
	mov	esi, 0
	mov 	eax, dword[%1 + esi]
	mov	dword[%3], eax
	mov	dword[%4], eax

%%arr_loop:
	add	esi, 4
	mov	eax, dword[%1 + esi]
	
	;compares if current element is greater than max. If so, goes to max_found label
	cmp	eax, dword[%3]
	jg	%%max_found
	
	;compares if current element is less than min. If so, goes to min_found label
	cmp	eax, dword[%4]
	jl	%%min_found
	
	;goes here if neither >max nor <min. If iterations are over, jmps to end label
	loop 	%%arr_loop
	jmp	%%end
	
;changes min to current element, loops back. If loop itearions are over, jumps to end
%%min_found:
	mov	dword[%4], eax
	loop 	%%arr_loop
	jmp 	%%end

;changes max to current element, loops back. If loop itearions are over, goes to end
%%max_found:
	mov	dword[%3], eax
	loop 	%%arr_loop
%%end:	
%endmacro

section .data
	array1	dd	4, 5, 2, 3, 1, -2
	array2	dd	2, 6, 3, -2, 1, 8, 19
	
section	.bss
	length	resd	1
	min	resd	1
	max	resd	1
	
section .text
	global _start
	
_start:
	mov	dword[length], 6
	arr_max_min	array1, length, max, min
	mov	dword[length], 7
	arr_max_min	array2, length, max, min
	
	
end:
	mov	rax, 60
	mov	rdi, 0
	syscall
