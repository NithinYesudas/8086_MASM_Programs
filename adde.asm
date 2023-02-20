data segment
    num1 db ?
    num2 db ?
    carry db 00h
    sum db ?
    msg1 db 10,13, "Enter first no: $"
    msg2 db 10,13, "Enter second no: $"
    msg3 db 10,13, "sum is: $"
data ends

code segment
assume cs: code, ds: data
start:
    mov ax, data
    mov ds, ax

    mov ah, 09H
    lea dx, msg1
    int 21H
    call input
    mov num1, al

    mov ah, 09H
    lea dx, msg2
    int 21H
    call input
    add al, num1
    daa
    jnc skip3
    inc carry

    skip3:
    mov sum, al
    mov ah, 09H
    lea dx, msg3
    int 21h
    lea si, carry
    call output
    lea si, sum
    call output

    mov ah, 4ch
    int 21h



input proc near
    mov ah, 01h;enter msb
    int 21H
    sub al, 30h
    cmp al, 09h
    jle skip1
    sub al, 07h
    skip1: mov cl, 04h
    rol al, cl
    mov ch, al
    
    mov ah, 01h;enter lsb
    int 21H
    sub al, 30h
    cmp al, 09H
    jle skip2
    sub al, 07h
    skip2: add al, ch
    ret
input endp  

output proc near
    mov al, [si]
    and al, 0f0h
    mov cl, 04h
    ror al, cl
    add al, 30h
    cmp al, 39h
    jle skip4
    add al, 07h
    skip4:
    mov ah, 02h
    mov dl, al
    int 21h

    mov al, [si]
    and al, 0fh
    add al, 30h
    cmp al, 39h
    jle skip5
    add al, 07h
    skip5:
    mov ah, 02h
    mov dl, al
    int 21H
    ret
output endp
code ends
end start