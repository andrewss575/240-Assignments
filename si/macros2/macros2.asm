; Argument1: the array to access elements
; Argument2: length to access numberof elements
; Argument3: average to input our average into

%macro arr_average 3
	mov	ecx, dword[%2]
	mov	esi, 0
%%arr_loop:
	add	eax, dword[%1 + esi * 4]
	inc	esi
	loop	%%arr_loop
	
	mov	edx, 0
	div	dword[%2]
	mov	dword[%3], eax
	
%endmacro

section	.data
	array	dd	125, 975, 82, 308, 50
	length	dd	5
	
section	.bss
	average	resd	1
	
section	.text
	global	_start
	
_start:
	arr_average	array, length, average

end:
	mov	rax, 60
	mov	edi, 0
	syscall
