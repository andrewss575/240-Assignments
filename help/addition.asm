section .data
SYS_exit    equ    60
EXIT_SUCCESS    equ    0

a    dw    3        
b    dw    1           
c    dw    1     
d    dw    3        
e    dw    2          
f    dw    4
x    dw    0
y    dw    0        

section .text
global _start
_start:

mov ax, word[a]
imul word[f]
mov bx, word[c]
imul word[d]
sub ax, bx
mov bx, word[a]
imul word[e]
sub ax, bx
mov cx, ax
mov ax, word[a]
imul word[f]
mov bx, word[c]
imul word[e]
sub ax, bx
mov bx, word[b]
imul word[d]
sub ax, bx
idiv cx
mov word[x], ax

mov ax, word[c]
imul word[e]
mov bx, word[b]
imul word[f]
sub ax, bx
mov bx, word[a]
imul word[e]
sub ax, bx
mov cx, ax
mov ax, word[c]
imul word[e]
mov bx, word[b]
imul word[d]
sub ax, bx
idiv cx
mov word[y], ax

mov	rax, 60
mov	rdi, 0
syscall

