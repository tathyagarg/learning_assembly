; Program to find maximum, minimum, and average of a list of numbers
section .data
    SUCCESS equ 0
    SYS_exit equ 60

    numbers dq 10, 20, 15, 6, 59
    length dq 5

    lowest dq 0
    highest dq 0
    total dq 0
    average dq 0
section .text
global _start
newLowest:
    mov [lowest], rax
    jmp checkHighest
newHighest:
    mov [highest], rax
    jmp restartLoop

_start:
    mov rcx, [length]
    mov rsi, 0
    mov rax, [numbers+(rsi*8)]
stats:
    mov rax, [numbers+(rsi*8)]
    add [total], rax
    cmp word [lowest], 0
    je newLowest
    cmp rax, [lowest]
    jl newLowest
checkHighest:
    cmp rax, [highest]
    jg newHighest
restartLoop:
    inc rsi
    loop stats
last:
    mov rax, [total]
    div dword [length]
    mov [average], rax
exit:
    mov rax, SYS_exit
    mov rdi, SUCCESS
    syscall
