section .data
    SUCCESS equ 0
    FAILURE equ 1
    SYS_EXIT equ 60
    
    string dq "TURTLES"
    length dq 7
section .text
    global _start
_start:
    mov rcx, [length]
    mov rsi, 0
pushLoop:
    push qword [string+rsi*8] ; Pushes first item to bottom, and last to top
    inc rsi
    loop pushLoop
    mov rcx, [length] ; After loop is complete, reset variables for next iteration
    mov rsi, 0
popLoop:
    pop rax
    mov rdx, qword [string+rsi*8]
    cmp rax, rdx  ; Compare first item of stack with first item of string
    jne fail
    inc rsi
    loop popLoop
success:
    mov rdi, SUCCESS  ; Exit with success
    jmp exit
fail:
    mov rdi, FAILURE  ; Exit with error
exit:
    mov rax, SYS_EXIT
    syscall

