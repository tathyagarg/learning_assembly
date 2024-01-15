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
    jmp checkHighest ; Jumps to check if the same number is the highest (only useful for the first iteration)
newHighest:
    mov [highest], rax
    jmp restartLoop ; Jumps to code responsibe for restarting the loop

_start:
    mov rcx, [length] ; Looping variable
    mov rsi, 0 
    mov rax, [numbers+(rsi*8)] ; Multiplying by 8 due to dq data type
stats:
    mov rax, [numbers+(rsi*8)]
    add [total], rax ; Adds to total
    cmp word [lowest], 0
    je newLowest ; Sets current number as lowest if lowest is currently 0
    cmp rax, [lowest]
    jl newLowest ; Sets current number as lowest if its lower than the current lowest
checkHighest:
    cmp rax, [highest]
    jg newHighest ; Sets current number as highest if its higher than the current highest
restartLoop:
    inc rsi ; Move to next item
    loop stats ; Restart loop
findAverage:
    ; Finds the average by dividing the total by length
    mov rax, [total]
    mov rdx, 0 ; Resets rdx so it doesn't interfere with the division (just in case)
    div dword [length]
    mov [average], rax
exit:
    ; Exit
    mov rax, SYS_exit
    mov rdi, SUCCESS
    syscall
