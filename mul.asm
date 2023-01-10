
data segment
num1 db ?
num2 db ?
product db ?
carry db 00h
msg1 db 10,13, "Enter first no: $"
msg2 db 10,13, "Enter second no: $"
msg3 db 10,13, "product is: $"
data ends
code segment
assume cs: code, ds: data
start:
    mov ax, data
    mov ds, ax
    ;input first numberr
    lea dx, msg1
    mov ah, 09h
    int 21h
    call input
    mov num1, al
    ;input second number
    lea dx, msg2
    mov ah, 09h
    int 21h
    call input
    mov num2, al
    ;display result message
    lea dx, msg3
    mov ah, 09h
    int 21h
    ;multiply two numbers
    mov al, num1
    mul num2
    daa
    mov product, al
    
   
    
    ;print product
    lea si, product
    call output
    mov ah, 4ch
    int 21h
;function for taking input
input proc near
    mov ah, 01h
    int 21h
    ;ascii to hex conv 
    ;input msb
    sub al, 30h
    cmp al, 09h
    jle skip1
    sub al, 07h
    skip1: mov cl, 04h
    rol al, cl
    mov ch, al
   ;input lsb
    mov ah, 01h
    int 21h
    sub al, 30h
    cmp al, 09h
    jle skip2
    sub al, 07h
    skip2: add al, ch
    ret
input endp 
output proc near
;function output
    mov al, [si]
    and al, 0f0h
    mov cl, 04h
    ror al, cl
    add al, 30h
    cmp al, 39h
    jle skip4
    add al, 07h
    skip4: mov dl, al
    mov ah, 02h
    int 21h
;output lsb
    mov al, [si]
    and al, 0fh
    add al, 30h
    cmp al, 39h
    jle skip5
    add al, 07h
    skip5: mov dl, al
    mov ah, 02h
    int 21h
    ret
output endp    
code ends
end start    