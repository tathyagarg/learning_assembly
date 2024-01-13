section .text
    global _start
    _start:
; The equivalent code in C:
; =========================
; int main() {
;     int MAXIMUM = 20;
;     int total = 0;
;     for (int i=MAXMIMUM, i>0,i--) {
;         total += i*i;
;      }
; }
; =========================
        mov ax, 0 ; Will help hold i^2
        mov cl, 5 ; i
    sumLoop:
        movzx ax, cl
        mul ax
        add bx, ax
        loop sumLoop
    last:
        mov rax, 1 ; Mark as success
        mov rdi, 60
        syscall ; Exit