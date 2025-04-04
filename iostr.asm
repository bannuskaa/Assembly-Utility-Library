;Bereczki Anna 511 baim2326

%include 'mio.inc'

global ReadStr,WriteStr,WriteLnStr,ReadLnStr,WriteLnStr,NewLine

section .text

ReadStr:

	push 	edi
	push 	eax
	push 	ecx
	push 	ebx
	mov		ebx,edi
	add 	ecx,edi
	add		ebx,1
	xor 	eax,eax 
	
.newchar:

	call  	mio_readchar
	cmp 	al,13
	je		.vege
	call	mio_writechar
	mov		[edi],al
	add		edi,1
	cmp     al, 8
    jne     .newchar
    mov     al, ' '
    call    mio_writechar
    mov     al, 8
    call    mio_writechar
	cmp		edi,ebx
	je		.elso
	sub		edi,1
	
.elso:

	sub		edi,1
	jmp		.newchar
	
.vege:

	mov 	ecx,0
	mov 	byte[edi],0
	
	pop		ebx
	pop 	ecx
	pop 	eax
	pop 	edi


ret

WriteStr:

	push 	esi
	push	eax
	xor		eax,eax
	
	
.newchar:

	cmp 	byte[esi],0
	je		.vege
	mov		al,[esi]
	call	mio_writechar
	add		esi,1
	jmp		.newchar
	
.vege:
	pop		eax
	pop		esi
	
ret

ReadLnStr:

	push 	edi
	push 	eax
	push 	ecx
	push	ebx
	mov		ebx,edi
	add		ebx,1
	xor 	eax,eax
	add		ecx,edi
	
.newchar:

	call  	mio_readchar
	cmp 	al,13
	je		.vege
	call	mio_writechar
	mov		[edi],al
	add		edi,1
	cmp     al, 8
    jne     .newchar
    mov     al, ' '
    call    mio_writechar
    mov     al, 8
    call    mio_writechar
	cmp		edi,ebx
	je		.elso
	sub		edi,1
.elso:
	sub		edi,1
	jmp		.newchar
	
.vege:

	mov 	ecx,0
	mov 	al,0
	mov 	[edi],al
	
	pop		ebx
	pop 	ecx
	pop 	eax
	pop 	edi
	call	NewLine

ret

WriteLnStr:

	push 	esi
	push 	eax
	xor 	eax,eax
	
.newchar:

	mov		al,[esi]
	cmp 	eax,0
	je		.vege
	call	mio_writechar
	add		esi,1
	jmp		.newchar
	
.vege:
	
	pop 	eax
	pop		esi
	call	NewLine

ret

NewLine:

	push 	eax
	mov     al, 13              
    call    mio_writechar
    mov     al, 10             
    call    mio_writechar
	pop		eax

ret
