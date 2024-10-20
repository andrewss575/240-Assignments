;using the newly learned macro implmentation, create a program that will multiply a set of numbers by 2

%macro mulBy2 2
	;mov	eax, [%1]
	mov	ecx, [%2]
	
%%loopArray:
	mov	eax, dword[%1 + esi * 4]
	mov	ebx, 2
	mul	ebx
	mov	dword[%1 + esi * 4], eax
	inc	esi
	loop	%%loopArray
	

%endmacro

section	.data
	list		dd	98, 77, 51, 32, 103, 27
	list_length	dd	6
	
section	.text
	global _start
	
_start:
	
	mulBy2	list, list_length
last:
	mov	rax, 60
	mov	rdi, 0
	syscall
