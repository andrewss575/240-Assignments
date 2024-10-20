
section .data

O_RDONLY 	equ 	000000q 	; read only

; -----
; Variables/constants for main.
BUFF_SIZE 	equ 	255
fileName 	db 	"url.txt", 0
fileDesc 	dq 	0

section .bss
readBuffer 	resb 	BUFF_SIZE
; -------------------------------------------------------
section .text
global _start
_start:
; -----


openInputFile:
	mov 	rax, 2			; file open
	mov 	rdi, fileName 		; file name string
	mov 	rsi, O_RDONLY 		; read only access
	syscall 			; call the kernel
	
	mov 	qword [fileDesc], rax 	; save descriptor

	mov 	rax, 0
	mov 	rdi, qword [fileDesc]
	mov 	rsi, readBuffer
	mov 	rdx, BUFF_SIZE
	syscall
	

; Close the file.
	mov 	rax, 3
	mov 	rdi, qword [fileDesc]
	syscall
	
;program end
	mov rax, 60
	mov rdi, 0
	syscall	
