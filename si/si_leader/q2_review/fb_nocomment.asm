; This assembly program aims to traverse through an array and input those values into other arrays 
; depending on if they are divisible by 3, 5, both, or neither. The number goes in fizz array if divisible by 3, 
; goes into buzz array if divisble by 5, goes into fizzbuzz array if divisble by both, and goes into no array if 
; divisible by neither 3 or 5


;cpp pseudocode. 
; signed int sum_fizz;
; signed int sum_buzz;
; signed int sum_fizzbuzz;
; signed short fizz[10];
; signed short buzz[10];
; signed short fizzbuzz[10];
; signed short arr[10] = {12, 35, -95, 300, 4, 273, 15, -988, 33, -100};
; register long rcx = 10;
; register long rsi = 0;
; register long rdi = 0;
; register long r11 = 0;
; register long r12 = 0;

; do{
;	//keep in mind that rsi, rdi, r11, and r12 are all incremented by 1 to get to the next element of an array in c++
;	//but you might have to increment by more in assembly to get to the next element. It dependent of the data size of the array
;	if (arr[rsi] % 3 == 0 && arr[rsi] % 5 != 0){
;		fizz[rdi] = int(arr[rsi]);
;		sum_fizz += arr[rsi];
;		rdi++;		
;		rsi++;
;	}else if (arr[rsi] % 5 == 0 && arr[rsi] % 3 != 0 &&){
;		buzz[r11] = arr[rsi];
;		sum_buzz += int(arr[rsi]);
;		rsi++;
;	}else if (arr[rsi] % 3 == 0 && arr[rsi] % 5 == 0){
;		fizzbuzz[r12] = arr[rsi]
;		sum_fizzbuzz += int(arr[rsi]);;
;		r12++;
;		rsi++;
;	}else{
;		rsi++;
;	}
;	
;	rcx--;
; }while(rcx != 0);

section .data

arr	dw	12, 35, -95, 300, 4, 273, 15, -903, 33, -100

section .bss
fizz		resd	10
buzz		resd	10
fizzbuzz	resd	10
sum_fizz	resw	1
sum_buzz	resw	1
sum_fizzbuzz	resw	1

section .text

global _start

_start:

	mov rax, 0
	mov rdx, 0
	mov rbx, 0

	mov rcx, 10
	mov rsi, 0
	mov rdi, 0
	mov r11, 0
	mov r12, 0
	
looper:
	mov ax, word[arr + rsi]
	mov bx, 3
	cwd					
	idiv bx
	cmp dx, 0
	je div_by_3
	
	mov ax, word[arr + rsi]
	mov bx, 5
	cwd
	idiv bx
	cmp dx, 0
	je div_by_5
	
	add rsi, 2
	loop looper
	jmp end
	
div_by_3:
	mov ax, word[arr + rsi]
	mov bx, 5
	cwd
	idiv bx
	cmp dx, 0
	je div_by_both
	
	mov ax, word[arr + rsi]
	movsx eax, ax
	add dword[sum_fizz], eax
	mov word[fizz + rdi], ax
	add rsi, 2
	add rdi, 2
	loop looper
	jmp end
	
div_by_both:
	mov ax, word[arr + rsi]
	movsx eax, ax
	add dword[sum_fizzbuzz], eax
	mov word[fizzbuzz + r12], ax
	add rsi, 2
	add r12, 2
	dec rcx
	cmp rcx, 0
	jne looper
	jmp end

div_by_5:
	mov ax, word[arr + rsi]
	movsx eax, ax
	add dword[sum_buzz], eax
	mov word[buzz + r11], ax
	add rsi, 2
	add r11, 2
	dec rcx
	cmp rcx, 0
	jne looper
	
end:
	mov rax, 60
	mov rdi, 0
	stscall

