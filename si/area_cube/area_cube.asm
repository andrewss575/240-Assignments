; This code will find the surface area of a cube (surface area = 6a^2)

section .data

	six dw 6
	side dw 10
	s_area dw 0
	
section .text
	global _start

_start:
	mov	ax, word[side]
	mul	word[side]
	mul	word[six]
	mov	word[s_area], ax
	
	mov	rax, 60
	mov	rdi, 0
	syscall
