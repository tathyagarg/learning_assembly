section .data
    NULL equ 0
    SYS_EXIT equ 60
    SUCCESS equ 0

    number dq 1928190
section .bss
    stringNumber resb 10
section .text
global _start
_start:
    mov rcx, 0
    mov rsi, 0
    mov rbx, 10
divideLoop:
    mov rax, [number]
    mov rdx, 0
    div rbx
    inc rcx
    mov [number], rax
    push rdx
    cmp rax, 0
    jne divideLoop
prePopLoop:
    mov rbx, stringNumber
popLoop:
    pop rax
    add al, "0" ; No idea why
    mov byte [rbx+rsi], al
    inc rsi
    loop popLoop
    mov byte [rbx+rsi], NULL
exit:
    mov rax, SYS_EXIT
    mov rdi, SUCCESS
    syscall
