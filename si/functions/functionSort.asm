;Sort the element from least to greatest
;arraySort(arr&, len, small)

section	.data
	array	dq	55, 95, 25, 75, 10
	length	dq	5

section	.bss
	small	resq	1
	
section	.text
	global	_start
	
_start:
	mov	rdi, array
	mov	rsi, qword[length]
	mov	small, qword[array]		;assignning the first value of the array to the smallest num(dont techincally 
						;need since we are doing it again in the function itself)
	mov	rdx, qword[small]
	call	arraySort
	
;**********FUNCTION****************************************

global arraySort

arraySort:

	push	rbp			;prologue(keep track of pushes)
	mov	rbp, rsp		;making sure rpb and rsp are at the start of the stack fram

	mov	r10, 0			;"i"
	mov	r11, 0			;"j"
	
	push	12			;need more arguments for "index" so we use r12(r12 must be pushed onto the stack to use)
	push	r13
	
; iloop begin
iLoop:
	mov	rdx, qword[rdi + r10 * 8]	;rdx(small) = array[i]
	mov	r12, r10			;index = j
	mov	r11, r10			;j = i for jloop

;jloop begin
jLoop:
	cmp	qword[rdi+r11*8], rdx
	jl	sortSmall
afterSort:
	inc	r11
	cmp	r11, rsi
	jne	jLoop
;jloop end
	mov	r13, qword[rdi+r10*8]
	mov	qword[rdi+r12*8], r13
	mov	qword[rdi+r10*8], rdx
	inc	r10
	cmp	r10, rsi
	jne	iLoop
	
;iloop end
jmp funcEnd
sortSmall:
	mov	rdx, qword[rdi+r11*8]
	mov	r12, r11
	jmp	afterSort
funcEnd:
	pop	r13
	pop	r12
	mov 	rsp, rbp
	pop	rbp			
	ret

