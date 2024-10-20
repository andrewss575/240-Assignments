;This program will help you with adding and subtracting in assembly
;
;PART1
;Our goal is to calculate the perimeter of a large 4-sided garden, with
;the value of sides as follows: 23,654 ft, 10,340 ft, 15,120 ft, and 19,345 ft
;
;PART2
;A student wants to find the difference between the fourth side(19,345) minus the first side(23,654)
;Find the difference for them and store it into a variable




;TODO: In section .data, initialize all the needed variables for the problem. Initialize your difference variable between
;side 4 and 1 as a double-word
section .data
	side1		dw	23654
	side2		dw	10340
	side3		dw	15120
	side4		dw	19345
	perimeter	dd	0
	
	diff		dd	0
	

section .text
	global _start
	
_start:
	
	;TODO: add all sides of the garden to find the Perimeter and store it in some variable
	mov 	ax, word[side1]
	add 	ax, word[side2]
	add 	ax, word[side3]
	
	add 	ax, word[side4]
	adc 	dx, 0
	
	mov	word[perimeter + 0], ax
	mov	word[perimeter + 2], dx
	
	
	;TODO: subtract the requested sides from the student. YOu're result should be negative. 
	;Make sure to clear the registers you used before starting
	mov	rax, 0
	mov	rdx, 0
	
	mov	ax, word[side4]
	sub	ax, word[side1]
	sbb	dx, 0
	
	mov	word[diff + 0], ax
	mov	word[diff + 2], dx
	
	
	;TODO: enter calls to terminate your program
	mov	rax, 60
	mov	rdi, 0
	syscall
