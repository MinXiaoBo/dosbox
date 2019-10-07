assume cs:code,ds:data,ss:stack

data segment
    ;db 128 dup(0)
    db 'my name is minbo',0
data ends

stack segment stack
    db 128 dup(0)
stack ends

code segment
start:
        mov ax, stack
        mov ss, ax
        mov sp, 128

        mov ax, data
        mov ds, ax
        mov di, 0

        mov bx, 0B800H
        mov es, bx
        mov si, 160*10 + 32*2

        mov bx, 02H

show_string:
        mov al, ds:[di]
        cmp al, 0
        je show_string_ret
        mov es:[si], al
        mov es:[si+1],bx
        add si, 2
        inc di
        jmp show_string

show_string_ret:
        mov ax, 4C00H
        int 21H

code ends
end start

