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
    jmp volumeCheckHighest ; Check if the same number is the highest (only useful for the first iteration)
newHighestVolume:
    mov [highestVolume], rax
    jmp tsa ; Jump to calculate TSA
newLowestTSA:
    mov [lowestTSA], rax
    jmp TSACheckHighest ; Check if the same number is the highest (only useful for the first iteration)
newHighestTSA:
    mov [highestTSA], rax
    loop volume ; Jump to restart from volume if rcx more than 0
    jmp averageCalculations ; Start average calculations if rcx reaches 0


_start:
    mov rcx, [size] ; Iteration count
    mov rsi, 0
volume:
    mov rax, [heights+rsi*8] ; Gets the height
    mul qword [widths+rsi*8] ; Multiplies by width
    mul qword [lengths+rsi*8] ; Multiplies by length
    div qword [THREE] ; Divides by 3
    mov [volumes+rsi*8], rax ; Appends to volumes
    add [totalVolume], rax ; Adds to total
    ; Checks if volume is lowest so far
    cmp qword [lowestVolume], 0
    je newLowestVolume
    cmp rax, [lowestVolume]
    jl newLowestVolume
volumeCheckHighest: ; Checks if volume is highest so far
    cmp rax, [highestVolume]
    jg newHighestVolume
tsa:
    mov rax, [heights+rsi*8] ; Moves height
    mul qword [widths+rsi*8] ; Multiplies by width
    mov r8, rax ; Moves result to r8 for later use
    mov rax, [widths+rsi*8] ; Moves width
    mul qword [lengths+rsi*8] ; Multiplies by length
    mov r9, rax ; Moves for later use
    mov rax, [lengths+rsi*8] ; Moves length
    mul qword [heights+rsi*8] ; Multuplies with height
    add rax, r8 ; Unnecessary to move to another register, instead it adds directly
    add rax, r9 ; Adds to achieve final result (the TSA)
    add [totalTSA], rax ; Adds to total
    ; Checks if the TSA is lowest so far
    cmp qword [lowestTSA], 0
    je newLowestTSA
    cmp rax, [lowestTSA]
    jl newLowestTSA
TSACheckHighest: ; Checks if the TSA is highest so far
    cmp rax, [highestTSA]
    jg newHighestTSA
restartLoop: ; Responsible for restarting loop
    inc rsi
    dec ecx
    jnz volume ; Can't use regulat loop because volume is too far away
averageCalculations: ; Start average calculations if the loop is complete
    mov rax, [totalVolume]
    mov rdx, 0 ; Resets rdx so it doesn't interfere with division
    div qword [size]
    mov [averageVolume], rax ; Moves average

    mov rax, [totalTSA]
    mov rdx, 0
    div qword [size]
    mov [averageTSA], rax
finish:
    mov rax, SYS_exit
    mov rdi, SUCCESS
    syscall