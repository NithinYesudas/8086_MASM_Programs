data segment
    str1 db 20 dup("$")
    repc db ? ;char to  be replaced
    repw db ?  ;char to be replaced with
    msg1 db 10,13,"Enter string: $"
    msg2 db 10,13,"Enter the character to be replaced: $"
    msg3 db 10,13,"Enter the character to be replace with: $"
    msg4 db 10,13,"Final string: $"

data ends

code segment
assume cs: code, ds: data
start:
    mov ax, data
    mov ds, ax

    lea dx, msg1;input string
    call output
    mov si, offset str1
    mov ah, 0ah
    mov dx, si
    int 21h

    lea dx, msg2;input char to be replaced
    call output
    call input
    mov repc, al

    lea dx, msg3;input char to be replaced with
    call output
    call input
    mov repw, al

    mov al, 00h;length finder
    mov bl, 13
    mov si, offset str1+2
    loop2: cmp [si], bl
    je loop3
    inc si
    inc al
    jmp loop2

   loop3: mov bl, repc
    mov si, offset str1 +2 
    mov cl, repw
    loop4: cmp [si], bl
    jne loop5
    mov [si], cl
    loop5: inc si
    dec al
    jnz loop4 
    
    
    lea dx, msg4
    call output
    
    mov si, offset str1+2
    mov ah, 09H
    mov dx, si
    int 21h



    
    mov ah, 4ch
    int 21h

input proc near
    mov ah, 01H
    int 21H
    ret
input endp
output proc near
    mov ah, 09h
    int 21h
    ret
output endp    
code ends

end start