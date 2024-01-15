section .data
    SYS_exit equ 60
    SUCCESS  equ  0
    THREE     dq  3

    heights dq 10, 20, 19, 35, 13,  1,  6, 19,  7, 34
    widths  dq  7, 43, 21, 10, 31, 29, 34, 49,  5,  5
    lengths dq 47, 44,  5, 23, 34, 15, 21, 40, 14, 47
    size    dq 10 ; Number of pyramids

    ; Volume formula: V = (lwh)/3
    ; TSA formula: lw + wh + hl

    lowestVolume  dq 0
    highestVolume dq 0
    totalVolume   dq 0
    averageVolume dq 0
    lowestTSA     dq 0
    highestTSA    dq 0
    totalTSA      dq 0
    averageTSA    dq 0

section .bss
    volumes resd 10
    tsas    resd 10

section .text
global _start
; Functions
newLowestVolume:
    mov [lowestVolume], rax
    inc rsi
    jmp tsa
newHighestVolume:
    mov [highestVolume], rax
    inc rsi
    jmp tsa
newLowestTSA:
    mov [lowestTSA], rax
    inc rsi
    loop volume
    jmp averageCalculations
newHighestTSA:
    mov [highestTSA], rax
    inc rsi
    loop volume
    jmp averageCalculations


_start:
    mov rcx, [size]
    mov rsi, 0
volume:
    mov rax, [heights+rsi*8]
    mul qword [widths+rsi*8]
    mul qword [lengths+rsi*8]
    div qword [THREE]
    mov [volumes+rsi*8], rax
    add [totalVolume], rax
    cmp qword [lowestVolume], 0
    je newLowestVolume
    cmp rax, [lowestVolume]
    jl newLowestVolume
    cmp rax, [highestVolume]
    jg newHighestVolume
tsa:
    mov rax, [heights+rsi*8]
    mul qword [widths+rsi*8]
    mov r8, rax
    mov rax, [widths+rsi*8]
    mul qword [lengths+rsi*8]
    mov r9, rax
    mov rax, [lengths+rsi*8]
    mul qword [heights+rsi*8]
    add rax, r8
    add rax, r9
    add [totalTSA], rax
    cmp qword [lowestTSA], 0
    je newLowestTSA
    cmp rax, [lowestTSA]
    jl newLowestTSA
    cmp rax, [highestTSA]
    jg newHighestTSA
    
    inc rsi
    dec ecx
    jnz volume
    jmp averageCalculations
averageCalculations:
    mov rax, [totalVolume]
    mov rdx, 0
    div qword [size]
    mov [averageVolume], rax

    mov rax, [totalTSA]
    mov rdx, 0
    div qword [size]
    mov [averageTSA], rax
finish:
    mov rax, SYS_exit
    mov rdi, SUCCESS
    syscall