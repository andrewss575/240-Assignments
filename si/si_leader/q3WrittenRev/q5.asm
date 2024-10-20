;this problem deals with the stack to demonstrate how a stack reacts when pushing and popping an array

;value of variables BEFORE execution
section .data
array	db	"vwxyz" 	;array+0='v'=0x76, array+1='w'=0x77, array+2='x'=0x78, array+3='y'=0x79, array+4='z'=0x7A
len	dq	5		;(64-bits) = 0x0000 0000 0000 0005


section .text
	global	_start
_start:
	mov	rcx, qword[len]		;rcx = 5 = 0x0000 0000 0000 0005
	mov	r12, 0			;r12(64-bits) = 0x0000 0000 0000 0000
	
	;this loop will push all characters in 'array' onto the stack where rsp(pointer to the top of the stack)
	;points to 'z' because that was the last element being pushed. It will increment r12 one at a time because 
	;it is used as the offset for 'array' so that we can iterate through all elements
pushLoop:
	mov	rax, 0				;clearing rax register
	mov	al, byte[array + r12]		;storing current element of 'array' into al (al bc each character is byte-sized)
	push	rax				;pushing rax into stack, we push rax instead of al because when we push, 
						;it has to be 64-bits. rax is the same value as al but in a bigger form
	inc	r12				;r12++ used as offset and needs to increment by 1 after every iteration
	loop	pushLoop			;loop does 3 things: it decrements rcx by 1, compares rcx with 0, and jumps if rcx !=0
						;since rcx is 5, it will loop 5 times, which is the exact number of elements in 'array'


	mov	rcx, qword[len]			;reseting rcx as length of array so that we can pop all elemetns out of stack
	mov	r12, 0				;reseting r12 as offset of 0 so that we can pop all elemetns out of stack 
						;and insert it back into 'array', starting from 'z' in the stack.
	
	;this loop will pop all characters from the stack one at a time and insert it back into 'array', when you do this, this 
	;inserts the elements in reverse into 'array'
popLoop:
	pop	rax				;popping top of stack and inserting into rax register
	mov	byte[array + r12], al		;inserting whatever is in rax register into current index
	inc	r12				;r12++, used as an offset to insert element into current index
	loop	popLoop				;loop does 3 things: it decrements rcx by 1, compares rcx with 0, and jumps if rcx !=0
						;since rcx is 5, it will loop 5 times, which is the exact number of spaces in 'array'

;at this point is where record all registers/variables. At then end of the code, we effectively reversed the array from 'vwxyz' to 'zyxwv'
;or array+0='z'=0x7A, array+1='y'=0x79, array+2='x'=0x78, array+3='w'=0x77, array+4='v'=0x76. length was never changed, it was just
;used to set the value of rcx, so len remains as 5 or 0x0000 0000 0000 0005.

;now on to the registers. The last thing we did that involved rax is pop the final element in the stack to rax, which is 'v' so rax is 
;0x0000 0000 0000 0076. we used rcx as a counter and waited until it reached 0 so rcx ends up being 0 or 0x0000 0000 0000 0000
;r12 started as 0 and incremented after every iteration until rcx was 0, which makes r12=5 or 0x0000 0000 0000 0005

;end of program
last:
	mov	rax, 60
	mov	rdi, 0
	syscall

