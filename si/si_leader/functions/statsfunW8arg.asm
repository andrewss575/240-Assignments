;this program creates a function that finds the average and sum of an array of quad-word numbers. This
;program is similar to avgfuncWlocal.asm but this time, we want to run the function on three different arrays
; which requires 8 arguments. 

;stats(arr1&, len1, arr2&, len2, arr3&, len3, avg&, sum&)

section .data
	arr1	dq	10, 20, 30, 40, 50, 60
	len1	dq	6
	arr2	dq	70, 80, 90, 100
	len2	dq	4
	arr3	dq	110, 120, 130
	len3	dq	3

section .bss	
	avg	resq	1
	sum	resq	1
	
section .text
	global _start
_start:
	
	mov rcx, 3	;counter
	
	;we want rax to remain 5 after function runs even though rax is being changed within the function
	;we use a epilogue and prologue to reserve the value 5 for rax
	mov rax, 5

arrLoop:	
	
	
	push rcx		;we push rcx becasue we use it as a counter but its changing to an 
				;argument so we need to save its original value into the stack and 
				; then pop it back to rcx after function is funished running

	;the 4 arguments go in rdi, rsi, rdx, and rcx respectively
	mov rdi, arr1
	mov rsi, qword[len1]
	mov rdx, arr2
	mov rcx, qword[len2]
	mov r8, arr3
	mov r9, qword[len3]
	push avg
	push sum
	
	call stats
	
	add rsp, 16
	pop rcx
	
	
	
	loop arrLoop
	
	mov rax, 60
	mov rdi, 0
	syscall
	
global stats

stats:

	;prologue - reserves the previous value of rax in the stack befor enessing with the register
	;as well as reserve a base pointer to the call/stack frame
	
	;we need to push rbp to save and then mov rsp into rbp to create a stack frame that is specific
	;to the function itself. See the slides on functions for extra help
	push rbp
	mov rbp, rsp
	
	push rax		
			
	mov rax, 0	
	
	mov r10, 0		;offset
	mov r11, 0		;will be used for 7th and 8th argument
arr1Loop:
	add rax, qword[rdi + r10 * 8]
	inc r10
	
	cmp r10, rsi
	jne arr1Loop
	
	mov r10, 0
arr2Loop:
	add rax, qword[rdx + r10 * 8]
	inc r10
	
	cmp r10, rcx
	jne arr2Loop
	
	mov r10, 0
arr3Loop:
	add rax, qword[r8 + r10 * 8]
	inc r10
	
	cmp r10, r9
	jne arr3Loop
	
	;storing sum in sum variable
	mov r11, qword[rbp + 24]
	mov qword[r11], rax
	
	;mov qword[rbp + 24], rax -will not work
	
	;finding summation of length between all arrays and using to find average of all arrays
	mov rbx, 0
	add rbx, rsi
	add rbx, rcx
	add rbx, r9
	
	mov rdx, 0
	div rbx
	;storing average in average variable
	mov r11, qword[rbp + 16]
	mov qword[r11], rax
	
	pop	rax	;epilogue - returns rax to its previous value by popping from stack before exiting functions
	pop	rbp
	ret
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		
