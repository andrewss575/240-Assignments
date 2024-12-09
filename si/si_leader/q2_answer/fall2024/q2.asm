; signed short shortArr[10] = {-3012, 624, 1234, -2345, 3456, -90, 6231, -235, 12357, -7890};
; //16-bit short integer array
; signed short posMul3[10]; //16-bit non-initial short array
; signed short negMul5[10]; //16-bit non-initial short array
; register long rbx = 0 //64-bit register
; register long rsi = 0 //64-bit register
; register long rdi = 0 //64-bit register
; register long rcx = 10 //64-bit register
; do {
; if(shortArr[rbx] > 0 && shortArr[rbx]%3 == 0) { //if positive and multiple of 3
; posMul3[rsi] = shortArr[rbx]; //move to posMul3 array
; rsi++; //rsi = rsi + 1
; } else if(shortArr[rbx] < 0 && shortArr[rbx]%5 == 0) { //if negative and multiple of 5
; negMul5[rdi] = shortArr[rbx]; //move to negMul5 array
; rdi++; //rdi = rdi + 1
; }
; rbx++; //rbx = rbx + 1
; rcx--; //rcx = rcx - 1
; } while(rcx != 0); //if rcx != 0 do loop again

section .data
	shortArr	dw	-3012, 624, 1234, -2345, 3456, -90, 6321, -235, 12357, -7890
	
section .bss
	posMul3		resw	10
	negMul5		resw	10
	
section .text
	global _start
	
_start:
	mov rbx, 0
	mov rsi, 0
	mov rdi, 0
	mov rcx, 10
	
loop_label:
	;moving current element of array into ax
	mov ax, word[shortArr + rbx * 2]
	
	;checking if currentl element is positive, if not, go to negCheckLabel
	cmp ax, 0
	jl negCheck
	
	;if we go here, ceuurent element is positive, so lets check if its divisible by 3 
	;by dividing by 3 and checking the remainder (dx)
	mov r11w, 3
	cwd		;using cwd to extend ax(16 bits) to dx:ax(32 bits). This is needed for dividing by negative numbers
	idiv r11w	;dividing by 3
	
	;moving current element back into ax because the dividing changed 
	;ax and all we care now about the divsiion is te remaider dx
	mov ax, word[shortArr + rbx * 2] 
	
	inc rbx		;increment rbx so that we can access next element in next iteration
	
	cmp dx, 0
	jne else	;if jump here, the number is positive but not divsible by 3 so we dont add this element to any array
			; so we just jump to else label that starts next iteration
	
	;we reach here if current element is postive and divisible by 3 so we add to the posMul3 array
	mov word[posMul3 + rsi * 2], ax
	inc rsi			;posMul3 offset
	
	loop loop_label		;dec rcx -> cmp rcx, 0 -> jne loop_label
	jmp end			;reach here when no more elements in array (rcx = 0)
	
negCheck:

	;if we go here, the current element is negative but we have to check if its divisble by 5 to see if we add it
	;to the negMul5 array
	mov r11w, 5
	cwd		;using cwd to extend ax(16 bits) to dx:ax(32 bits). This is needed for dividing by negative numbers
	idiv r11w	;dividing by 5
	
	;moving current element back into ax because the dividing changed 
	;ax and all we care now about the divsiion is te remaider dx
	mov ax, word[shortArr + rbx * 2]
	
	inc rbx		;increment rbx so that we can access next element in next iteration
	
	cmp dx, 0
	jne else	;if jump here, the number is negative but not divsible by 5 so we dont add this element to any array
			; so we just jump to else label that starts next iteration
	
	;we reach here if current element is negative and divisible by 5 so we add to the negMul5 array
	mov word[negMul5 + rdi * 2], ax
	inc rdi		;offset for negMul5 array
	
	loop loop_label		;dec rcx -> cmp rcx, 0 -> jne loop_label
	jmp end			;reach here when no more elements in array (rcx = 0)
	
; we reach here if current element meets none of the requirements for being inserted into a new array
; so we just simply iterate to check upcoming element
else:
	loop loop_label
	
end:
	mov rax, 0
	mov rdi, 0
	syscall
	
	
	
	






