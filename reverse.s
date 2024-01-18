section .data
    SUCCESS equ 0
    SYS_EXIT equ 60

    numbers dq 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    length dq 10

section .text
    global _start

_start:
    mov rcx, [length]
    mov rsi, 0
pushLoop:
    push qword [numbers+rsi*8]
    inc rsi
    loop pushLoop
    mov rcx, [length]
    mov rsi, 0
popLoop:
    pop qword [numbers+rsi*8]
    inc rsi
    loop popLoop
exit:
    mov rax, SYS_EXIT
    mov rdi, SUCCESS
    syscall
