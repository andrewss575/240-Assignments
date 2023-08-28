; this code will find the summation of a specific number
; use quadword(64-bits) so we could also use larger numbers

section .data

	n	dq	15
	sum	dq	0

section .text
	global _start

_start:
	mov rcx, qword[n]
	mov rax, 0
	
	;NOTE: counters are usually used for rcx
	summation_loop:
		add rax, rcx					;rax = rax + rcx
		dec rcx 					;rcx = rcx - 1
		
		mov qword[sum], rax				;sum = rax
		
		cmp rcx, 0					;does rcx = 0?
		jne summation_loop				;if not, jump to summation_loop label
	
	
	
        mov     rax, 60                                         ;terminate excuting process
        mov     rdi, 0                                          ;exit status
        syscall      
