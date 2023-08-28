;STILL NEEDS WORK

; Sort the element from least to greatest
; arraySort(arr&, len, small);

section .data
	array	dq	55, 95, 25, 75, 10
	length	dq	5
	min	dq	0
	max	dq	0
	med1	dq	0
	med2	dq	0

section .bss
	small	resq	1
	

section .text
global _start
_start:
	
	; Sort Array Function
	mov	rdi, array
	mov	rsi, qword[length]
	mov 	rdx, small
	call	arraySort
	mov	rdx, min
	mov	rcx, max
	mov	r8, med1
	mov	r9, med2
	call	sort
	
end_prog:
	mov 	rax, 60
	mov 	rdi, 0
	syscall


;***********************************************************************

global arraySort
arraySort:
	push	rbp					; prologue
	mov	rbp, rsp
	mov	r10, 0					; "i"
	mov	r11, 0					; "j"
	push	r12					; "index"
	push	r13
	
; iLoop begin
iLoop:
	mov 	rdx, qword[rdi+r10*8]			; small = array[i]
	mov	r12, r10				; index = i
	mov	r11, r10				; j = i

; jloop begin
jLoop:
	cmp	qword[rdi+r11*8], rdx			; if array[j] < small 
	jl	sortSmall				; jump to sortSmall
afterSort:
	inc	r11					; j++
	cmp	r11, rsi				; loop if j != length
	jne	jLoop
; jloop end
	mov	r13, qword[rdi+r10*8]			; r13 = array[i]
	mov	qword[rdi+r12*8], r13			; array[index] = array[i]
	mov	qword[rdi+r10*8], rdx			; array[i] = small
	inc	r10					; i++
	cmp	r10, rsi				; loop if i != length
	jne	iLoop
; iLoop end
jmp funcEnd

sortSmall:
	mov 	rdx, qword[rdi+r11*8]			; small = array[j]
	mov 	r12, r11				; index that has smallest = j
	jmp	afterSort
	
funcEnd:
	pop 	r13					; epilogue
	pop 	r12
	mov 	rsp, rbp
	pop 	rbp
	ret
;*****************************Stats Function**********************************************
global sort

sort:
mov	rdx, qword[rdi]
mov	rcx, qword[rdi + rsi*8]

mov	rdx, 0
push	rbp
mov	rbp, 2
mov	rax, rsi
div	rbp

cmp	rdx, 0
je	even

odd:
	mov	r8, qword[rdi + rax *8]
	mov	r9, 0
	jmp	funcEnd1
even:
	mov	r8, qword[rdi + rax *8]
	mov	r9, qword[rdi + rax+1 *8]
	
funcEnd1:
	pop rbp
	ret
