; Example program to demonstrate file I/O. This example
; will open/create a file, write some information to the
; file, and close the file. Note, the file name and
; write message are hard-coded for the example.

section .data
 		; read and write
S_IRUSR 	equ 	00400q
S_IWUSR 	equ 	00200q


; -----
; Variables for main.
fileName 	db 	"url.txt", 0
url 		db 	"http://www.giggle.com"
len 		dq 	$-url-1
fileDesc 	dq 	0

;--------------------------------------------------------

section .text
	global _start

_start:


openInputFile:
	mov 	rax, 85				; file open/create
	mov 	rdi, fileName 			; file name string
	mov 	rsi, S_IRUSR | S_IWUSR 		; allow read/write
	syscall 				; call the kernel
	mov 	qword [fileDesc], rax 		; save descriptor
	
	;write to file
	mov 	rax, 1
	mov 	rdi, qword[fileDesc]
	mov 	rsi, url
	mov 	rdx, qword [len]
	syscall

; -----
; Close the file.
; System Service - close
; rax = SYS_close
; rdi = file descriptor

	mov 	rax, 2
	mov 	rdi, qword [fileDesc]
	syscall


	mov 	rax, 60
	mov 	rdi, 0
	syscall

