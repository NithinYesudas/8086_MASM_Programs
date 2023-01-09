data segment
    num1 db ?
    num2 db ?
    sum dw ?
    msg1 db 10,13, "Enter num1: $"
    msg2 db 10,13, "Enter num2: $"
    msg3 db 10,13, "Sum is: $"
data ends
code segment
assume cs: code, ds: data
start:
    mov ax, data
    mov ds, ax
    lea dx, msg1
    mov ah, 09h
    int 21h
    
    mov num1, al
    lea dx, msg2
    mov ah,09h
    int 21h
input proc near
    mov ah, 01h
    int 21h
    sub al, 30h
    cmp al, 09h
    jle skip
    sub al, 07h
    skip:mov cl, 04h
    rol al, cl    
code ends
end start    


