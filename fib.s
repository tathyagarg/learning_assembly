section .data
    SUCCESS equ 0
    SYS_exit equ 60
    n dq 5 ; actually represents n+2, the +2 will be negated afterwards.
           ; The +2 offset comes from setting x = 0 (rax = 0), and y = 1 (rbx = 1)
    total dq 1 ; z

section .text
global _start
_start:
    mov rcx, [n] ; Setting rcx to be the counter
    sub rcx, 2 ; Offset of -2 to get the nth fibonacci number.
    mov rax, 0 ; x
    mov rbx, 1 ; y
fib:
    mov rax, rbx ; x = y
    mov rbx, [total] ; y = z
    mov [total], rax ; z = x
    add [total], rbx ; z += y
        ; Performing z = x, followed by z += y is equivalent to doing z = x + y
    loop fib
finish:
    mov rax, SUCCESS
    mov rdi, SYS_exit
    syscall
