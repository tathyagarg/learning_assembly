; The equivalent code in C:
; =========================
; int main() {
;     int maximum = 5;
;     int total = 0;
;     int helper = 0; // Represents the value in the RAX register
;     summation(&helper, &total, &maximum);
;     printf("%d\n", total); // Debug statement
;     finish();
; }
; void summation(int *helper, int *total, int *maximum) {
;     *helper = *maximum;
;     *helper = *helper * *helper;
;     *total += *helper;
;     *maximum -= 1;
;     if (*maximum == 0) return;
;     summation(helper, total, maximum);
; }
; void finish() { /*  Random exiting code */ }
; =========================

section .data
    SUCCESS equ 0
    SYS_exit equ 60
    maximum dq 5
    total dq 0

section .text
    global _start
    _start:
        mov rcx, [maximum]
    summation:
        mov rax, rcx
        mul rax
        add [total], rax
        loop summation
    finish:
        mov rax, SUCCESS
        mov rdi, SYS_exit
        syscall
