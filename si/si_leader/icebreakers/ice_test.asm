section .data
    text db "Hello, my name is Kenny! I am 23 years old. My favorite game is league.", 10
section .text
  global start
start:
  mov rax, 1
  mov rdi, 1
  mov rsi, text
  mov rdx, 71
  syscall

  mov rax, 60
  mov rdi, 0
  syscall
    
