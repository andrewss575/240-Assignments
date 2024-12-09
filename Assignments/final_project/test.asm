%macro print 2
    mov rax, 1
    mov rdi, 1
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

%macro scan 2
    mov rax, 0
    mov rdi, 0
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

section .data
    msg1 db "Input a number (004~999): " ;26
    msg2 db "1 + 2 + 3 +...+ "           ;16
    msg3 db " = "                        ;3

section .bss
    buffer resb 4
    n resd 1
    sumN resd 1
    ascii resb 10

section .text
    global _start

_start:
    print msg1, 26
    scan buffer, 4

    mov al, byte[buffer]
    and al, 0fh
    mov bl, 10
    mul bl

    mov cl, byte[buffer+1]
    and cl, 0fh
    add al, cl
    adc ah, 0
    mul bl

    mov cl, byte[buffer+2]
    and cl, 0fh
    add al, cl
    adc ah, 0
    mov word[n], ax
    
    mov esi, dword[n]
doloop:
    add dword[sumN], esi
    dec esi
    cmp esi, 0
    jge doloop

    mov rcx, 9
    mov ebx, 10
    mov eax, dword[sumN]
divloop:
    mov edx, 0
    div ebx
    add dl, '0'
    add byte[ascii+rcx], dl

    dec rcx
    cmp rcx, 0
    jge divloop

    print msg2, 16
    print buffer, 3
    print msg3, 3
    print ascii, 7

    mov rax, 60
    mov rdi, 0
    syscall
