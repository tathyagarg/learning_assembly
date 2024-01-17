; Program to find:
; Minimum, maximum, sum, average of a list of numbers
; Sum, count, average of negative numbers of the same list
; Same, but with only numbers divisible by 3 of the same list

section .data
    SUCCESS  equ  0
    SYS_EXIT equ 60

    numbers dq  -44, 22, -22, 81, -90, 49, 29, 2, -59, -99, 79, 9, -55, 76, -32, 22, -75, 87, 69, -86, -90, 66, 44, -23, -33, 54, -31, 13, 2, 9
    size    dq  30
    TWO     dq  2
    THREE   dq  3

    ; Variables related to all numbers
    all_min dq 0
    all_max dq 0
    all_mid dq 0
    all_sum dq 0
    all_avg dq 0

    ; Variables related to negative numbers only
    neg_sum dq 0
    neg_cnt dq 0
    neg_avg dq 0

    ; Variables related to 3-divisible numbers only (Alas, the unformity must end at some point)
    three_sum dq 0
    three_cnt dq 0
    three_avg dq 0
section .text
global _start
; Functions
negative:
    add [neg_sum], rax
    inc qword [neg_cnt]
    neg r8
    jmp computeThree

three_divisible:
    add [three_sum], rbx
    inc qword [three_cnt]
    jmp lowest

newLowest:
    mov [all_min], rax
    jmp highest

newHighest:
    mov [all_max], rax
    jmp restartLoop

_start:
    mov rcx, [size]
    mov rsi, 0
statsLoop:
    mov rax, [numbers+rsi*8]
    mov r8, rax
    add [all_sum], rax
computeNegatives:
    cmp rax, 0
    jl negative
computeThree:
    mov rbx, rax
    mov rax, r8
    mov rdx, 0
    div dword [THREE]
    cmp rdx, 0
    je three_divisible
lowest:
    mov rax, [numbers+rsi*8]
    cmp qword [all_min], 0
    je newLowest
    cmp rax, [all_min]
    jl newLowest
highest:
    cmp rax, [all_max]
    jg newHighest
restartLoop:
    inc rsi
    dec rcx
    jnz statsLoop
averages:
    mov rax, qword [all_sum]
    mov rdx, 0
    cmp rax, 0
    jl a_setrcx
    mov rcx, 1
    jmp a_div
a_setrcx:
    neg rax
    mov rcx, 0
a_div:
    div qword [size]
    cmp rcx, 0
    je a_negate
    jmp a_movAverage
a_negate:
    neg rax
a_movAverage:
    mov [all_avg], rax
negAverage:
    mov rax, qword [neg_sum]
    mov rdx, 0
    cmp rax, 0
    jl n_setrcx
    mov rcx, 1
    jmp n_div
n_setrcx:
    neg rax
    mov rcx, 0
n_div:
    div qword [neg_cnt]
    cmp rcx, 0
    je n_negate
    jmp n_movAverage
n_negate:
    neg rax
n_movAverage:
    mov [neg_avg], rax
threeAverage:
    mov rax, qword [three_sum]
    mov rdx, 0
    cmp rax, 0
    jl t_setrcx
    mov rcx, 1
    jmp t_div
t_setrcx:
    neg rax
    mov rcx, 0
t_div:
    div qword [three_cnt]
    cmp rcx, 0
    je t_negate
    jmp t_movAverage
t_negate:
    neg rax
t_movAverage:
    mov [three_avg], rax
exit:
    mov rax, SYS_EXIT
    mov rdi,  SUCCESS
    syscall

