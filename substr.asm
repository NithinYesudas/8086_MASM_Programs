data segment
    str1 db 20 dup('$')
    str2 db 20 dup('$')
    count db ?
    msg1 db 10,13,"Enter string: $"
    msg4 db 10,13,"Enter substring: $"
    msg2 db 10,13,"found $"
    msg3 db 10,13,"not found $"
data ends
code segment
assume cs: code, ds: data
start:
    mov ax, data
    mov ds, ax

    mov ah,09H
    lea dx, msg1
    int 21H
    mov si, offset str1
    call input

    mov ah,09H
    lea dx, msg4
    int 21H
    mov si, offset str2 
    call input

    mov cl, 00h
    mov bl, 13
    mov si, offset str1+2
    loop1: cmp [si], bl
    je loop2
    inc si
    inc cl
    jmp loop1

    loop2:mov count, cl
    mov cl, 00h
    mov si, offset str2 + 2
     loop3: cmp [si], bl
    je loop4
    inc si
    inc cl
    jmp loop3
    loop4:

    mov si, offset str1 + 2
    mov di, offset str2 + 2
    loop5: mov al, [di]
    cmp [si], al
    je loop6
    inc si
    dec count
    jnz loop5
    mov ah, 09H
    lea dx, msg3
    int 21H
    jmp loop8

    loop6:
    dec cl
    jz loop7
    inc di
    jmp loop5

    loop7:
    mov ah, 09H
    lea dx, msg2
    int 21h
    loop8:
    mov ah, 4ch
    int 21h





input proc near
    mov ah, 0ah
    mov dx, si
    int 21H
    ret
input endp
code ends
end start