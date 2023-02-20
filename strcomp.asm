data segment
    str1 db 20 dup('$')
    str2 db 20 dup('$')
    msg1 db 10,13, "Enter str1: $"
    msg2 db 10,13, "Enter str2: $"
    msg3 db 10,13, "Equal$"
    msg4 db 10,13, "no equal$"
data ends
code segment
assume cs: code, ds: data
start:
    mov ax, data
    mov ds, ax

    mov ah, 09H;input first no
    mov si, offset str1
    lea dx, msg1
    int 21H
    call input

    mov ah, 09h; input 2nd no
    mov si, offset str2
    lea dx, msg2
    int 21H
    call input
    
    mov bl, 13; find str1 length
    mov si, offset str1 + 2
    mov al, 00h
    loop1: cmp [si], bl
    je loop2
    inc si
    inc al
    jmp loop1

    loop2:
    mov si, offset str2 + 2
    mov cl, 00h ; find str2 length
    loop3: cmp [si], bl
    je loop4
    inc si
    inc cl
    jmp loop3

    loop4:
    cmp cl, al;length comparison
    je loop5
    mov ah, 09H;if not equal
    lea dx, msg4
    int 21H
    jmp loop9

    loop5:;if equal
    mov si, offset str1 + 2
    mov di, offset str2 + 2
    loop7: mov cl, [di]
    cmp [si], cl
    jne loop8
    inc si
    inc di
    dec al
    jnz loop7
    mov ah, 09H; if equal
    lea dx, msg3
    int 21h
    jmp loop9
    loop8:
    mov ah, 09H; if not equal
    lea dx, msg4
    int 21h
    loop9:




    
    mov ah, 4ch
    int 21H
input proc near
    mov ah, 0ah
    mov dx, si
    int 21H
    ret
input endp    
code ends
end start