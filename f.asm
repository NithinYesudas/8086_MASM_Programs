data segment
limit db ?

msg1 db 10,13, "Enter the limit: $"
msg2 db 10,13, "The series is: $"
data ends
code segment
assume cs: code, ds: data
start: 
    mov ax, data
    mov ds, ax
    lea dx, msg1
    mov ah, 09H
    int 21H
    mov ah, 01h
    int 21H
    sub al, 30h
    cmp al, 09H
    jle skip1
    sub al, 07h
    skip1: mov cl, al
    mov al, 01h
    call output
    mov al, 01h
    call output
    mov al, 01h
    skip: 
    mov bl, al
    add al, bl
    mov dl, a
    call output
    mov al, dl
    dec cl
    jnz skip

    mov ah, 4ch
    int 21h
    

output proc near
    add al, 30h
    cmp al, 39h
    jle skip2
    add al, 07h
    skip2: mov dl, al
    mov ah, 02h
    int 21H
    ret
output endp    

code ends
end start
    