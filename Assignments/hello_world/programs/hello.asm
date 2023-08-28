; ex_hello.asm
; char text[] = "Hello, World!\n"
; cout << text;

; section .data specifies that the following data
; items should be placed in the data section 
; of the program.
section .data 

	; This line defines a variable named text and initializes 
	; it with the string "Hello, World!" followed by a newline 
	; character (represented by the value 10). text can now be 
	; accessed in execution 
	text db "Hello, World!", 10

; This line specifies that the following instructions should 
; be placed in the text (code) section of the program.
section .text
	; This line declares the symbol _start as a global symbol
	; so that it can be accessed from outside the module.
	global _start

; This line defines a label called _start, which marks the
; beginning of the program's execution.
_start:

;-------------------------explanation of lines to first syscall------------------------------

;These instructions write the string stored in the text variable to standard output.
;
; mov rax, 1 sets the system call number for write to 1, indicating that we want to
; write data to a file descriptor (in this case, 1, which is standard output).
;
; mov rdi, 1 sets the first argument of the write system call, which is the file 
; descriptor we want to write to (in this case, standard output).
;
; mov rsi, text sets the second argument of the write system call, which is the 
; address of the buffer containing the data we want to write (in this case, the 
; text variable).
;
; mov rdx, 14 sets the third argument of the write system call, which is the number 
; of bytes we want to write (in this case, 14, which is the length of the string "Hello, 
; World!\n").
;
; syscall performs the system call and writes the string to standard output.
;--------------------------------------------------------------------------------------------

	mov rax, 1
	mov rdi, 1
	mov rsi, text
	mov rdx, 14
	syscall

;-------------------------These instructions exit the program.--------------------------------
; 
; mov rax, 60 sets the system call number for exit to 60.
;
; mov rdi, 0 sets the first argument of the exit system call, which is the exit status of
; the program (in this case, 0, indicating success).
;
; syscall performs the system call and exits the program.
	mov rax, 60
	mov rdi, 0
	syscall
	
