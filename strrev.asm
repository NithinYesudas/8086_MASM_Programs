data segment
    str1 db 20 dup('$')
    str2 db 20 dup('$')
    msg1 db 10,13,"Enter string: $"
    msg2 db 10,13,"Reversed string: $"
data ends
code segment
assume cs: code, ds: data
start:
    mov ax, data
    mov ds, ax

    mov ah, 09H;input string
    lea dx, msg1
    int 21H
    mov si, offset str1
    call input

    mov bl, 13 ; check length
    mov al, 00h
    mov si, offset str1+2
    loop1: cmp [si], bl
    je loop2
    inc si
    inc al
    jmp loop1
    loop2:;reverse
    
    dec si
    mov di, offset str2 +1
    loop3: mov cl, [si]
    mov [di], cl
    dec si
    inc di
    dec al
    jnz loop3

    mov ah, 09H;print message
    lea dx, msg2
    int 21h

    mov ah, 09H;print string 2
    mov si, offset str2+1
    mov dx, si
    int 21H
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