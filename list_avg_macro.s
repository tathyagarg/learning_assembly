; avg <items> <length> <location>
%macro avg 3
    mov rax, 0
    mov rcx, [%2]
    mov rsi, 0
    lea rdx, [%1]
    %%addLoop:
        add rax, [rdx+rsi*8]
        inc rsi
        loop %%addLoop
        jmp %%findAverage
    %%findAverage:
        mov rdx, 0
        div qword [%2]
        mov [%3], rax
%endmacro

section .data
    SUCCESS equ 0
    SYS_EXIT equ 60

    nums dq 1, 2, 3
    length dq 3
    curr_avg dq 0
section .text
    global _start
_start:
    avg nums, length, curr_avg
    mov rax, [curr_avg]
exit:
    mov rax, SYS_EXIT
    mov rdi, SUCCESS
    syscall