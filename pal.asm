data segment
    str1 db 20 dup('$')
    msg1 db 10,13,"Enter the string: $"
    msg2 db 10,13,"Palindrome: $"
    msg3 db 10,13,"Not palindrome: $"
data ends
code segment 
assume cs:code, ds: data
start:
    mov ax, data
    mov ds, ax

    mov ah, 09H;input string
    lea dx, msg1
    int 21h    
    mov si, offset str1
    call input

    mov al, 00h;length finder
    mov bl, 13
    mov si, offset str1 +2
    loop1: cmp [si], bl
    je loop2
    inc si
    inc al
    jmp loop1
    loop2:

    dec si;palindrome cheking
    mov di, offset str1 +2
    loop3: mov cl, [si]
    cmp [di], cl
    jne loop4
    inc di
    dec si
    dec al
    jnz loop3
    jmp loop5
    
    loop4: 
    mov ah, 09H;pring not palindrome
    lea dx, msg3
    int 21h
    jmp loop6
    loop5:;print palindrome
    mov ah, 09H
    lea dx, msg2
    int 21H
    loop6: 
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