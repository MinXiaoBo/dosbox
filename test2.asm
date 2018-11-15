assume cs:code

code segment
	
	mov ax,0020H
	mov es,ax
	mov ax,0
	mov bx,0
	mov cx,64

copyData:
	mov es:[bx],al
	inc al
	inc bx

	loop copyData

	mov ax,4c00H
	int 21H

code ends
end