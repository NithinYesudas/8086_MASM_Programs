data segment
    str1 db 20 dup('$')
    str2 db 20 dup('$')
    msg1 db 10,13, "Enter string1: $"
    msg2 db 10,13, "Enter string2: $"
    msg3 db 10,13, "Result: $"
data ends
code segment
assume cs: code, ds:data
start:
    mov ax, data
    mov ds, ax

    mov ah, 09h;print msg1
    lea dx, msg1
    int 21H
    mov si, offset str1;input 1st str
    call input

    mov ah, 09h;pring msg2
    lea dx, msg2
    int 21h
    mov si, offset str2; input 2nd str
    call input

    mov si, offset str1+2; find length of str1
    mov bl, 13
    
   loop4: cmp [si], bl
    je loop1
    
    inc si
    jmp loop4
    loop1:
    mov di, offset str2+2
    
    loop2:
    cmp [di], bl
    je loop3
    mov cl, [di]
    mov [si], cl
    inc si 
    inc di
    jmp loop2
    loop3: 
    mov ah, 09H
    lea dx, msg3
    int 21h
    mov si, offset str1+2;output
    mov ah, 09h
    mov dx, si
    int 21h
   


    mov ah, 4CH
    int 21h

input proc near
    mov ah, 0ah
    mov dx,si
    int 21h
    ret
input endp    
code ends
end start   
