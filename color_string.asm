assume cs:code,ds:data,ss:stack
data segment
    db 'Welcome to masm!'
    db  02H,24H,71H
data ends

stack segment
    dw 128 dup(0)
stack ends

code segment
start:
        mov ax,data     ;设置数据段
        mov ds,ax

        mov ax,stack    ;设置栈的大小以及栈顶
        mov ss,ax
        mov sp,128

        mov bx,0        ;控制颜色
        mov ax,0B872H   ;显存位置

        mov cx,3        ;三层数字，循环三层
s3:
        push cx         ;多重循环的处理方法
        push ax         ;保存显存地址

        mov es,ax       ;把显存地址赋给附加段
        mov si,0
        mov di,0
        mov cx,10h
s2:
        mov al,ds:[di]
        mov es:[si],al
        inc di
        add si,2
        loop s2
                        ;复制每个字符至显存高位(偶数位)

        mov si,1
        mov al,10H[BX]
        inc bx
        mov cx,10h
s1:
        mov es:[si],al
        add si,2
        loop s1

        pop ax
        add ax,0ah
        pop cx
        loop s3


        mov ax,4c00h
        int 21h

code ends
end start
