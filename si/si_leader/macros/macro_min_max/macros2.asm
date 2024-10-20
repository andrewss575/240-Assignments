%macro mul2 2
	mov rcx, [%1] 
	mov rsi, 0
	
%%listLoop
	mov eax, dword[%2 + rsi * 4]
	mov ebx, 2
	
	mul ebx
	
	mov dword[%2 + rsi * 4], eax
	inc rsi
	
	dec rcx
	cmp rcx, 0
	jne %%listLoop
	
%endmacro


section .data
	list 	dd	98, 77, 51, 32, 103, 27
	length	dd	6
	
section .text
	global _start
_start:

	mul2 length, list
	
	
	mov rax, 60
	mov rdi, 0
	syscall
	
