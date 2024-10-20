; This assembly program aims to traverse through an array and input those values into other arrays 
; depending on if they are divisible by 3, 5, both, or neither. The number goes in fizz array if divisible by 3, 
; goes into buzz array if divisble by 5, goes into fizzbuzz array if divisble by both, and goes into no array if 
; divisible by neither 3 or 5


;cpp pseudocode. 
;
; int fizz[10];
; int buzz[10];
; int fizzbuzz[10];
; int arr[10] = {12, 35, 95, 300, 4, 273, 15, 988, 33, 100};
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
;		rdi++;		
;		rsi++;
;	}else if (arr[rsi] % 5 == 0 && arr[rsi] % 3 != 0){
;		buzz[r11] = arr[rsi];
;		r11++;
;		rsi++;
;	}else if (arr[rsi] % 3 == 0 && arr[rsi] % 5 == 0){
;		fizzbuzz[r12] = arr[rsi]
;		r12++;
;		rsi++;
;	}else{
;		rsi++;
;	}
;	
;	rcx--;
; }while(rcx != 0);

