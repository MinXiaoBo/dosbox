assume cs:code,ds:data,ss:stack

data segment
    db 128 dup(0)
    ;db 'divide error',0
data ends

stack segment stack
    db 128 dup(0)
stack ends

code segment
start:
        mov ax, stack
        mov ss, ax
        mov sp, 128

        call copy_int
        call set_new_int

        mov ax, 0
        mov dx, 1
        mov bx, 1
        div bx

        mov ax, 4C00H
        int 21H

set_new_int:
        mov bx, 0
        mov es, bx
        mov word ptr es:[0*4], 7E00H
        mov word ptr es:[0*4+2], 0
        ret

;===============中断服务例程===================
new_int_head:
        jmp new_int

string_data:
        db 'divide error',0

new_int:
        mov bx, 0B800H
        mov es, bx

        mov bx, 0
        mov ds, bx

        mov di, 160*10 + 30*2
        mov si, OFFSET string_data - new_int_head + 7E00H

show_error:
        mov dl, ds:[si]
        cmp dl, 0
        je show_error_ret
        mov es:[di], dl
        add di, 2
        inc si
        jmp show_error

show_error_ret:
        mov ax, 4C00H
        int 21H

new_int_end:
        nop

;===============中断服务例程===================

;============拷贝中断服务例程到7E00H===========
copy_int:
        mov bx, cs
        mov ds, bx
        mov si, OFFSET new_int_head

        mov bx, 0
        mov es, bx
        mov di, 7E00H

        mov cx, OFFSET new_int_end -new_int_head
        cld
        rep movsb
        ret

code ends
end start
