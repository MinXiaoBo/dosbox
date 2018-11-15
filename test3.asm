assume cs:code

code segment

	mov ax,cs
	mov ds,ax
	mov ax,0020H
	mov es,ax
	mov bx,0
	mov cx,17H

copyData:
	
	mov al,ds:[bx]
	mov es:[bx],al
	inc bx
	loop copyData

	mov ax,4c00H
	int 21H

code ends
end