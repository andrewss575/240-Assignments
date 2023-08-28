; Assignment 8
; Utilize macros to develop a program that counts up to a user-inputed number and print it

; #begin define print(string, numOfChar)
; 	rax = 1;
; 	rdi = 1;
; 	rsi = &string;
; 	rdx = numOfChar;
; 	syscall;
; #end
; #begin define scan(buffer, numOfChar)
;	rax = 1;
;	rdi = 1;
;	rsi = &buffer;
;	rdx = numOfChar;
;	syscall;
; #end

; char buffer[4];
; long n;
; short sumN;
; char msg1[26] = "Input a number (100~255): ";
; char msg2[16] = "1 + 2 + 3 +...+ ";
; char msg3[4] = " = ";
; char ascii[6] = "00000\n";
;
; print(msg1, 26);
; scan(buffer, 4);
; n = atoi(buffer);
; rsi = 0;
;do {
;    sumN += rsi;
; } while(rsi >= 0);
; ascii = itoa(sumN);
; print(msg2, 20);
; print(buffer, 3);
; print(msg3, 3);
; print(ascii, 6);


%macro	print 	2
        mov     rax, 1					;SYS_write
        mov     rdi, 1					;standard output device
        mov     rsi, %1					;output string address
        mov     rdx, %2					;number of character
        syscall						;calling system services
%endmacro

%macro	scan 	2
        mov     rax, 0					;SYS_read
        mov     rdi, 0					;standard input device
        mov     rsi, %1					;input buffer address
        mov     rdx, %2					;number of character
        syscall						;calling system services
%endmacro

section .bss
buffer		resb	4
n		resq	1
sumN		resw    1

section .data
msg1		db	"Input a number (100~255): "
msg2		db      "1 + 2 + 3 +...+"
msg3		db	" = "
ascii		db      "00000", 10

section .text
        global _start
_start:
;-------------------------------------------------------------------------------------------------------------------
; When user input is given, it is represented in ascii so the following code gets every ascii 
; digit that was user inputed and indivdually changes them into a decimal number. We prompted 
; the user to enter a three digit numbr so we will be converted asccii into decimal three different times
;
;
; HOW IT WORKS(for example we have '111' as user input): changes the first char input into decimal and saves that into 
; al:ah(1), multiplies that that number by 10 (10), changes the second char input into decimal and adds 
; that to al:ah(11), multiplies by 10 again (110), changes the third char input into decimal and adds that 
; to al:ah(111), and then moves that whole number into n.

	print	msg1, 26				;cout << msg1
	scan	buffer, 4				;cin >> buffer
	
	;printing msg2, buffer, and msg3 before we modify buffer 
	print	msg2, 16				;cout << msg2
	print	buffer, 3				;cout << ascii_input
	print	msg3, 3					;cout << msg3
	
	mov	ax, 0					;clear ax
	mov	bx, 10					;bx = 10
	mov	rsi, 0					;counter = 0
next0:
	and	byte[buffer+rsi], 0fh			;convert ascii to number
	add	al, byte[buffer+rsi]			;al = number
	adc	ah, 0					;ah = 0
	cmp	rsi, 2					;compare rsi with 2
	je	skip0					;if rsi=2 goto skip0
	mul	bx					;dx:ax = ax * bx
skip0:
	inc	rsi					;rsi++
	cmp	rsi, 3					;compare rsi with 3
	jl	next0					;if rsi<3 goto next0
	mov	word[n], ax				;n = ax
;-----------------------------------------------------------------------------------------------------------------------
	; calculates 1+2+3+...+N
	;if user inputs 140-255, the 
	
	mov	cx, 0					;cx = 0
next1:
	add	word[sumN], cx				;sumN += cx
	inc	cx					;cx++
	cmp	cx, word[n]				;compare cx with n
	jbe	next1					;if(cx<=100) goto next1
;------------------------------------------------------------------------------------------------------------------------
	; converts sumN into ascii
	; Depending on the inputed number, sumN may be 4 or 5 digits. Therefore, we will set up ascii to hold 5 digits.
	; But if sumN ends up being 4 digits, ascii will add an extra 0 to the beginning of the number
	
	mov	rdi, 4					;counter = 4
	mov	ax, word[sumN]				;ax = sumN
next2:
	mov	dx, 0					;dx = 0
	mov	bx, 10					;bx = 10
	div	bx					;dx=(dx:ax)%10, ax=(dx:ax)/10
	add     byte[ascii+rdi], dl			;ascii+rdi = al + 30h
	dec	rdi					;rdx--
	cmp	rdi, 0					;compare rdx with 0
	jge	next2					;if rd  x>=0 goto next2

;----------------------------------------------------------------------------------------------------------------------------
	; printing results
	print	ascii, 6				;cout << ascii
	
	
	
        mov     rax, 60					;terminate program
        mov     rdi, 0					;exit status
        syscall						;calling system services
