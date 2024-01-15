; Program to find the sum of values in a list

section .data
    SUCCESS equ 0
    SYS_exit equ 60

    lst dq 100, 192, 64, 221 ; The list
    length dq 4 ; Length of the list
    total dq 0 ; Sum

section .text
global _start
_start:
    mov ecx, dword [length] ; ecx can hold datatype of dword
sumLoop:
    mov eax, dword [lst+((ecx-1)*8)] ; We use ecx-1 because ecx cannot reach 0 (loop will break when ecx is 0). 
                                     ; Multiply by 8 due to dq datatype
    add [total], eax
    loop sumLoop
finish:
    mov rax, SUCCESS
    mov rdi, SYS_exit
    syscall
