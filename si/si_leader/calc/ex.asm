section .text
    global _start

_start:
    jmp my_label       ; Unconditionally jump to the 'my_label' label

    ; This code will not be executed
    mov eax, 5     
    mov ebx, 10   
    mul ebx	   

my_label:
    ; This code will be executed after the jump
    mov eax, 5         
    mov ebx, 100         
    mul ebx   
    jmp end

another_label:
    ; This label will be reached even though it was not explicitly called
    ; The assembler continues sequentially unless a jump or branch instruction redirects it
    mov eax, 5
    mov ebx, 1000
    mul ebx
    
end:
   mov rax, 60
   mov rdi, 0
   syscall

