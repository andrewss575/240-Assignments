;this is a macro definition. It is similar to functions that when you call a macro in 'section .text', it'll refer to the definition
;defined below where %1 is the first argument and %2 is the second argument
;So this macro is used to print a string variable to the terminal without having to retype everything
%macro	print	2
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, %1
	mov	rdx, %2
	syscall
%endmacro

;this is the value of variables BEFORE execution
section .data
str1	db	"abc", 10  	;this string is aka as an array of characters so str1 + 1 = 'a', str1 + 2 = 'b', 
				;str1 + 3 = , 'c', str1 + 4 = '/n'
str2	db	"123"	   	;also a string of characters so str2 + 0 = '1', str2 + 1 = '2', str2 + 2 = '3'


section .text
	global	_start
_start:
	;here we are calling the macros with specifies arguments
	
	;printing str1 to terminal
	print	str1, 4		;calling print macro with argument #1 being the pointer to 'a' in str1 and arguument #2 being
				;the number of characters in str1
	;printing str2 to terminal
	print	str2, 3		;calling print macro with argument #1 being the pointer to '1' in str2 and arguument #2 being
				;the number of characters in str2

;at this point is where we get the values of all registers/variable. With rax, and rdi, we can see that in the macro definition,
;it is always one when we call the macro. The last thing we did was call a macro on str2 so rax and rdi are both
;0x0000 0000 0000 0001 because they are 64-bit registers. rsi and rdx are different because they vary based on the last macro was called
;the last macro was used on the str2 where rsi is set to str2 and rdx is set to 3. SInce str2 is a pointer to '1', you can just say
;that rsi is some address pointing to the first element of str1. rdx was set to 3 so it is 0x0000 0000 0000 0003 in hex

;for the variables, str1 and str2 were accessed but never changed so they stay the same as they were before the code executed



	;exiting program
	mov rax, 60
	mov rdi, 0
	syscall
