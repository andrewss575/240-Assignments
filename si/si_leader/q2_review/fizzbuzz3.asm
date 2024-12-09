; This assembly program aims to traverse through an array and input those values into other arrays 
; depending on if they are divisible by 3, 5, both, or neither. The number goes in fizz array if divisible by 3, 
; goes into buzz array if divisble by 5, goes into fizzbuzz array if divisble by both, and goes into no array if 
; divisible by neither 3 or 5


;cpp pseudocode. 
; int sum_fizz;
; int sum_buzz;
; int sum_fizzbuzz;
; int fizz[10];
; int buzz[10];
; int fizzbuzz[10];
; int arr[10] = {12, 35, -95, 300, 4, 273, 15, -988, 33, -100};
; int rcx = 10;
; int rsi = 0;
; int rdi = 0;
; int r11 = 0;
; int r12 = 0;

; do{
;	//keep in mind that rsi, rdi, r11, and r12 are all incremented by 1 to get to the next element of an array in c++
;	//but you might have to increment by more in assembly to get to the next element. It dependent of the data size of the array
;	if (arr[rsi] % 3 == 0 && arr[rsi] % 5 != 0){
;		fizz[rdi] = arr[rsi];
;		sum_fizz += arr[rsi];
;		rdi++;		
;		rsi++;
;	}else if (arr[rsi] % 5 == 0 && arr[rsi] % 3 != 0 &&){
;		buzz[r11] = arr[rsi];
;		sum_buzz += arr[rsi];
;		r11++;
;		rsi++;
;	}else if (arr[rsi] % 3 == 0 && arr[rsi] % 5 == 0){
;		fizzbuzz[r12] = arr[rsi]
;		sum_fizzbuzz += arr[rsi];
;		r12++;
;		rsi++;
;	}else{
;		rsi++;
;	}
;	
;	rcx--;
; }while(rcx != 0);




section .data

arr	dw	12, 35, -95, 300, 4, 273, 15, -988, 33, -100		;an array with 10 word-sized elements

; section .bss is where we declare unitialized varibales
; here we create 3 variables that reserve 10 word size spaces. So basically three arrays with uninitialized values which
; we may fill later in this program
section .bss
fizz		resw	10
buzz		resw	10
fizzbuzz	resw	10
sum_fizz	resw	1
sum_buzz	resw	1
sum_fizzbuzz	resw	1

section .text

global _start

_start:

;THIS CODE USES ONLY THE OFFSET TO ITERATE THROUGH ARRAY
	; clearing/initializing the registers we are going to use
	mov rax, 0	; going to be used as the divisor for each element in the arr array
	mov rdx, 0	; is going to be used to access the remainder of the division of each element in arr array
	mov rbx, 0	; is going to be saved as the dividend (either 3 or 5)

	mov rcx, 10	; going to be used as a counter for the arr array. Set to 10 because arr has 10 elements
	mov rsi, 0	; going to be used as the offset of the arr array
	mov rdi, 0	; going to be used as the offset of the fizz array
	mov r11, 0	; going to be used as the offset of the buzz array
	mov r12, 0	; going to be used as the offset of the fizzbuzz array
	
looper:
	mov ax, word[arr + rsi]		; moves current element of arr array into ax
					; we have to continually do this every time we want to access an element 
					; of arr because ax gets changed during division instructions so 
					; we have to revert ax back to an element of arr array. Also because rsi might have been 
					; incremented since last time we used this instruction
					
	mov bx, 3			; manually moving 3 into bx register which will then be used as a divisor
	mov dx, 0			; setting dx to 0 before dividing because remainder will get stored into dx'
					; you need to do this when dividing while looping or else you will use 
					; unwanted values from previous iteration
					
	div bx				; dividing current element by bx(3). quotient gets stored in ax, and remainder in dx
	cmp dx, 0			; comparing remainder(dx) and 0. If dx is 0, that means the current element is divisble by 3
	je div_by_3			; if dx == 0, jump to div_by_3 label
	
	; we reach here if the current element of arr is NOT divisble by 3. Now we are checking if its divisble by 5
	; we have to check if the current element of arr is divisble 
	; by 5 TWICE(2nd time is below) because this label only gets accessed if the current elemnt of arr is NOT divisble by 3. So we need 
	; another check to see if the current element of arr is divisble by 5 when it's ALSO divisble by 3 
	
	mov ax, word[arr + rsi]		; moves current element of arr array into ax
	mov bx, 5			; manually moving 5 into in bx which will then be used as a divisor
	mov dx, 0			; moving dx to 0 before dividing. Look at above comments to see why(line 80)
	div bx				; dividing current element of arr by bx(5). quotient gets stored into ax, ad remainder in dx
	cmp dx, 0			; comparing the remainder(dx) and 0. If dx is 0, that means the current element is divisble by 5
	je div_by_5			; if dx == 0, then jump to div_by_5 label
	
	;we reach here if the current element of arr is neither divisible by 3 or 5
	add rsi, 2			; adding 2 to rsi(offset for arr) so the instruction [arr + rsi] will access the next element 
					; of arr the next time we use it since we are all done with the current one
								
	loop looper			; decrements rcx by 1, compares it with 0, and jumps to looper label if not equal to 0
	jmp end				; we reach here when rcx is 0 aka when we finished parsing through arr array, so we go to end
	
div_by_3:
	; if we reach this label, this means that the current element of the arr array is divisbile by 3. But before we 
	; add it to the fizz array, we have to make sure it's also not divisble by 5 because if it is, the current 
	; element of arr actually has to be move to fizzbuzz array. So if the current element of arr is divisble by 5 too, 
	; it jumps to div_by_both label. This also means that we have to check if the current element of arr is divisble 
	; by 5 TWICE(1st time is above) because this label only gets accessed if the current element of arr IS divisble by 3. So we need 
	; another check to see if the current element of arr is divisble by 5 when it's NOT divisble by 3 
	
	mov ax, word[arr + rsi]		; moves current element of arr array into ax. (See line 73 for explanation)
	add word[sum_fizz], ax
	mov bx, 5			; manually moving 5 into in bx which will then be used as a divisor
	mov dx, 0			; moving dx to 0 before dividing. Look at above comments to see why(line 80)
	div bx				; dividing current element of arr by bx(5). Quotient gets stored into ax, and remainder in dx
	cmp dx, 0			; comparing the remainder(dx) and 0. If dx is 0, that means the current element is divisble by 5
	je div_by_both			; if dx == 0, then jump to div_by_both label
	
	; if we reach this part it means that the current element of arr is ONLY divisble by 3 and NOT 5 so the element gets 
	; copied into the fizz array
	
	mov ax, word[arr + rsi]		; moves current element of arr array into ax
	mov word[fizz + rdi], ax	; moving ax into first empty spot of fizzbuzz array
	add rsi, 2			; adding 2 to rsi(offset for arr) so the instruction [arr + rsi] will access the next element 
					; of arr the next time we use it since we are all done with the current one
					
	add rdi, 2			; adding 2 to rdi(offset for fizz) so the instruction [fizz + rdi] will access the
					; next element of fizz the next time we use it since we are all done with the current one
					
	loop looper			; decrements rcx by 1, compares it with 0, and jumps to looper label if not equal to 0
	jmp end				; we reach here when rcx is 0 aka when we finished parsing through arr array, so we go to end
	
	; this label get executed if the current element of arr is divisble by BOTH 3 and 5. This gets the current element of arr
	; and copies it to the first open space of fizzbuzz array
div_by_both:
	mov ax, word[arr + rsi]		; moving current element of arr into ax
	add word[sum_fizzbuzz], ax
	mov word[fizzbuzz + r12], ax	; moving ax into first empty spot of fizzbuzz array
	add rsi, 2			; adding 2 to rsi(offset for arr) so the instruction [arr + rsi] will access the next element 
					; of arr the next time we use it since we are all done with the current one
					
	add r12, 2			; adding 2 to r12(offset for fizzbuzz) so the instruction [fizzbuzz + r12] will access the
					; next element of fizzbuzz the next time we use it since we are all done with the current one
	
	; I dont use the 'loop' instruction here because the loop instruction can only jump so far. This technique, although will yield 
	; the same result in other situations, cannot be be used in order to avoid the out-of-range error			
	dec rcx				; decrements rcx cause we are moving to the next element		
	cmp rcx, 0			; compares rcx and 0. The arr array will be completely parsed when rcx is 0
	jne looper			; if rcx != 0, jump back to looper label
	jmp end				; if we reach here, that means we finished parsing the arr array, so we are done and jump to end

; we reach here only if the current element of arr is NOT divisble by 3 but IS divisble by 5. We will add current element of arr
; into buzz array
div_by_5:
	mov ax, word[arr + rsi]		; moving current element of arr into ax
	add word[sum_buzz], ax
	mov word[buzz + r11], ax	; moving ax into first empty spot of buzz array
	add rsi, 2			; adding 2 to rsi(offset for arr) so the instruction [arr + rsi] will access the next element 
					; of arr the next time we use it since we are all done with the current one
					
	add r11, 2			; adding 2 to r11(offset for buzz) so the instruction [buzz + r11] will access the
					; next element of buzz the next time we use it since we are all done with the current one
	
	; I also dont use the 'loop' instruction here because the loop instruction can only jump so far. This technique, although will
	; yield the same result in other situations, cannot be used in order to avoid the out of range error			
	dec rcx				; decrements rcx cause we are moving to the next element		
	cmp rcx, 0			; compares rcx and 0. The arr array will be completely parsed when rcx is 0
	jne looper			; if rcx != 0, jump back to looper label
	
	; if we reach here, that means we have iterated thorugh all elements in arr, so we end the program. No need for 'jmp end'
	; instruction because end label is next line to be executed
end:
	mov rax, 60
	mov rdi, 0
	stscall
