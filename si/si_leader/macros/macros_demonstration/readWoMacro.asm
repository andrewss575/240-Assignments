;this program uses macros to output onto the terminal and take in user input frpom the terminal
%macro print 2
	mov rax, 1
	mov rdi, 1
	mov rsi, %1
	mov rdx, %2
	syscall
%endmacro 

%macro input 2
	mov rax, 0
	mov rdi, 0
	mov rsi, %1
	mov rdx, %2
	syscall
%endmacro

section .data
	prompt1 db "Please enter a letter: "
	prompt2 db "Please enter another letter: "
	output	db "You entered: "
	newLine db 10
	
section .bss
	char1 db 2
	char2 db 2

section .text
	global _start
_start:
	print prompt1, 23
	input char1, 2
	print output, 13
	print char1, 2
	
	print newLine, 1
	
	print prompt2, 29
	input char2, 2
	print output, 13
	print char2, 2
	
	mov rax, 60
	mov rdi, 1
	syscall
	
	
