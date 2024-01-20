; Program to convert an integer into a string (more like a list)
; The debugger script to verify proper execution is:
; =============================================
; b debugger
; run
; set logging file out.txt
; set logging overwrite
; set logging on
; echo -----------------------\n
; while (1)
;     stepi
;     print $rax
;     c
; end
; echo \n\n
; set logging off
; quit
; =============================================

section .data
    SUCCESS equ 0
    SYS_EXIT equ 60

    DEBUG dq 1
    number dq 1379  ; Number to convert to a null-terminated string
    digit_count dq 4
section .bss
    stringed resq 10
section .text
    global _start
preDivideLoop:
    mov [number], rax
    jmp divideLoop
_start:
    mov rbx, 10
    mov rsi, 1
divideLoop:
    mov rax, qword [number]
    mov rdx, 0
    div rbx
    push rdx  ; Pushes the digits from the right into stack
    cmp qword [number], 0
    je prePopLoop  ; Exits the loop if number is exhausted
    inc rsi
    jmp preDivideLoop
prePopLoop:
    mov rcx, rsi
    mov rsi, 0
    pop rax ; Remove trailing something idk
popLoop:
    pop rax ; Move left-most digit into rax
    mov [stringed+rsi*8], rax  ; Move rax into the left-most digit of the string
    inc rsi
    loop popLoop
    cmp qword [DEBUG], 0
    je exit  ; Exit if we don't want to debug
    mov rcx, qword [digit_count]  ; Continue from here if we're going to debug
    mov rsi, 0
debugger:
    mov rax, [stringed+rsi*8]
    inc rsi
    loop debugger
exit:
    mov rax, SYS_EXIT
    mov rdi, SUCCESS
    syscall