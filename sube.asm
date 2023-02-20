data segment
    num1 db ?
    num2 db ?
    carry db 00h
    diff db ?
    msg1 db 10,13, "Enter first no: $"
    msg2 db 10,13, "Enter second no: $"
    msg3 db 10,13, "difference is: $"
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
    mov num2, al
    
    mov al, num1
    sub al, num2;subtraction
    daa
    jnc skip1
    inc carry
    skip1:
    mov diff, al

    lea dx, msg3
    mov ah, 09H
    int 21h

    lea si, carry;printing
    call output
    lea si, diff
    call output

    mov ah, 4ch
    int 21h
input proc near
    mov ah, 01H;msb
    int 21H
    sub al, 30h
    cmp al, 09H
    jle skip2
    sub al, 09H
    skip2:
    mov cl, 04h
    rol al, cl
    mov ch, al

    mov ah, 01h;lsb
    int 21h
    sub al, 30h
    cmp al, 09H
    jle skip3
    sub al, 09H
    skip3:
    add al, ch
    ret
input endp

output proc near
    mov al, [si];print msb
    and al, 0f0h
    mov cl, 04h
    ror al, cl
    add al, 30h
    cmp al, 39h
    jle skip5
    add al, 07h
    skip5:
    mov ah, 02h
    mov dl, al
    int 21H

    mov al, [si];print lsb
    and al, 0fh
    add al, 30h
    cmp al, 39h
    jle skip4
    add al, 07h
    skip4:
    mov ah, 02h
    mov dl, al
    int 21H
    ret
output endp
code ends
end start

