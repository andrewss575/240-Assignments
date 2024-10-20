; Argument1: the array to access elements
; Argument2: length to access numberof elements
; Argument3: average to input our average into

%macro arr_average 3
	mov	ecx, dword[%2]
	mov	esi, 0
	mov	rax, 0
%%arr_loop:
	add	eax, dword[%1 + esi * 4]
	inc	esi
	loop	%%arr_loop
	
	mov	edx, 0
	div	dword[%2]
	mov	dword[%3], eax
	
%endmacro

section	.data
	array1	dd	125, 975, 82, 308, 50, 23
	length1	dd	6
	array2	dd	13, 121, 88, 100, 145, 54, 19
	length2	dd	7
	
section	.bss
	average1	resd	1
	average2	resd	1
	
	
section	.text
	global	_start
	
_start:
	arr_average	array1, length1, average1
	arr_average	array2, length2, average2

end:
	mov	rax, 60
	mov	edi, 0
	syscall
