;this program uses different arithmetic to demonstrate how data 
;moves amongst registers and variables


;the varibales defined in this section are the values of varibales BEFORE the 'section .text' is being executed. The reason
;why the hex represntations are in 4 hex digits is because each varibale is declared as a wpord so 16-bits or 4 hex digits
section .data
num1	dw	13		;num1(16-bits) = 0x000D
num2	dw	2		;num2(16-bits) = 0x0002
num3	dw	4		;num3(16-bits) = 0x0004


section .text
	global	_start
_start:
	mov	ax, word[num1]		;ax = num1 = 13
	mov	bx, word[num2]		;bx = num2 = 2
	add	ax, bx			;ax = ax + bx = 13 + 2 = 15
	; when multiplying, the product gets stored into an rax register. Since we are multiplying by a 16-bit regsiter(bx), 
	; the product specifically gets stored in ax. However, if the product becomes bigger than what ax can hold(which 
	; is 65,535 unsiged), the remaining leading bits goes into dx. So for example if the product is 108,489 or 0x1A7C9 
	; in hex, ax will contain 0xA7C9 and dx will contain 0x0001. However, for this probelm we are simply multiplying 
	; 15 * 2, which can comfortably fit in an ax register, therefore dx will have the value 0x0000. That's why we have 
	; to fill in the box for dx as 0 even though it was never shown in the code
	mul	bx			;ax = ax * bx = 15 * 2 = 30		
	sub	ax, bx			;ax = ax - bx = 30 - 2 = 28
	
	mov	word[num3], ax		;sum3 = ax = 28
	
	; At this point of the code is where the professor wants you do give the values of num1, num2, num3, ax, bx, and dx.
	; num1 and num2 where never changed, they were just used to put value into ax and bx registers, so they stay the same 
	; as they were before the program ran (num1 = 0x000D, num2 = 0x0002). num3, on the other hand, was modifyed at the end 
	; of the code where the value of ax was inputed into num3. So num3 gets overriden from 4 to 28. So num3 is 0x001C where
	; num3+0 = 0x1C and num3+1 = 0x00. For ax, bx, and dx, we look at what they last contained. As mentioned above, dx is
	; 0x0000 because the product was not big enough to superceed what ax can contain. ax first had 13 in it, then 2 was added, 
	; then it was multiplyed by 2 then it was subtracted by 2 ((13+2)*2-2), which leads to its final value of 28 or 0x001C
	; in wordsize. bx was used to store num2 which had the value of 2. bx then never changed after that, it was just used 
	; to show how much to add/sub/multiply by, so bx stays as 2 or 0x0002 in hex word-size
	mov rax, 60
	mov rdi, 0
	syscall
	
