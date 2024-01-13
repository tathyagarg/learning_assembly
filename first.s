section .data
    num1 db 100
    num2 db 12
    ans db 0

; We need to perform ans = num1 + num2
section .text
    mov al, byte [num1]
    add al, byte [num2]
    mov byte [ans], al