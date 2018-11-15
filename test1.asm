assume cs:code

code segment

    mov ax,0
    mov cx,123
    mov bx,0

addNumber:
    add ax,236
    inc bx
    loop addNumber

code ends
end

