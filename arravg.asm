data segment
    count db ?
    sum db 00h
    avg db ?
    msg1 db 10,13,"Enter the size of the array: $"
    msg2 db 10,13,"Enter the array: $"
    msg3 db 10,13,"Average is: $"
    next db 10,13,"  $"
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
    mov count, al
    
    mov ah, 09H
    lea dx, msg2
    int 21H

    

    mov cl, count
    loop1: call input;make sum
    add sum, al
    daa
    mov ah, 09H
    lea dx, next
    int 21h
    dec count 
    jnz loop1
    
    mov ah, 09H
    lea dx, msg3
    int 21h

    mov ax, 0000h;div
    mov al, sum
    
    div cl
    
    mov avg, al
    lea si, avg
    
    call output

    mov ah, 4ch
    int 21h

input proc near
    mov ah, 01H
    int 21H
    sub al, 30h
    cmp al, 09H
    jle skip1
    sub al, 07h
    skip1:
    mov cl, 04h
    rol al, cl
    mov ch, al

    mov ah, 01H
    int 21H
    sub al, 30h
    cmp al, 09H
    jle skip2
    sub al, 07h
    skip2:add al, ch
    ret
input endp 

output proc near
    mov al, [si]
    and al, 0f0h
    mov cl, 04h
    ror al, cl
    add al, 30h
    cmp al, 39h
    jle skip3
    skip3: mov ah, 02h
    mov dl, al
    int 21H

    mov al, [si]
    and al, 0fh
    add al, 30h
    cmp al, 39h
    jle skip4
    add al, 07h
    skip4:
    mov ah, 02h
    mov dl, al
    int 21h
    ret
output endp
code ends
end start 

