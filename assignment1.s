; Create a program to compute the square of the sum from 1 to n. Specifically,
; compute the sum of integers from 1 to n and then square the value. Use the
; debugger to execute the program and display the final results.
section .data
    SUCCESS equ 0   ; Success exit code
    SYS_exit equ 60 ; Sysexit call code 
    n dq 10  ; Maximum
    total dq 0

section .text
global _start

_start:
    mov rcx, [n]
sumLoop:
    add [total], rcx
    loop sumLoop
computeSquare:
    mov rax, [total]
    mul rax
    mov [total], rax
finish:
    mov rax, SUCCESS
    mov rdi, SYS_exit
    syscall
