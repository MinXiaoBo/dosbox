assume cs:code

code segment

    mov ax,1000H
    add ax,ax
    mov bx,2000H
    add bx,bx
    mov ax,4C00H
    int 21H

code ends
end
