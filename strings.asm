;Bereczki Anna 511 baim2326

global StrLen, StrCat, StrUpper, StrLower, StrCompact

section .txt

StrLen:

	push 	esi
	xor 	eax,eax
	
.ciklus:
	
	cmp 	byte[esi],0
	je		.vege
	add		eax,1
	add		esi,1
	jmp		.ciklus
	
.vege:

	pop 	esi

ret

StrCat:

	push 	edi
	push 	esi
	push	eax
	xor		eax,eax
	
.ciklus1:

	cmp 	byte[edi],0
	je		.ciklus2
	add		edi,1
	jmp 	.ciklus1
	
.ciklus2:
	
	cmp		byte[esi],0
	je		.vege
	mov		al,[esi]
	mov		[edi],al
	add		edi,1
	add		esi,1
	jmp 	.ciklus2
	
.vege:

	mov 	byte[edi],0
	pop 	eax
	pop		esi
	pop		edi

ret

StrUpper: 

	push 	esi
	push	eax
	push 	ebx
	xor		eax,eax
	mov 	bl,'A'
	sub		bl,'a'
	sub		esi,1
	
.ciklus:

	add		esi,1
	mov		al,[esi]
	cmp		al,0
	je		.vege
	cmp		al,'a'
	jl		.ciklus
	cmp		al,'z'
	jg		.ciklus
	add		[esi],bl
	jmp		.ciklus
	
.vege:

	pop 	ebx
	pop		eax
	pop 	esi

ret

StrLower:

	push 	esi
	push	eax
	push 	ebx
	xor		eax,eax
	mov 	bl,'A'
	sub		bl,'a'
	sub		esi,1
	
.ciklus:

	add		esi,1
	mov		al,[esi]
	cmp		al,0
	je		.vege
	cmp		al,'A'
	jl		.ciklus
	cmp		al,'Z'
	jg		.ciklus
	sub		[esi],bl
	jmp		.ciklus
	
.vege:

	pop 	ebx
	pop		eax
	pop 	esi

ret

StrCompact:

	push 	esi
	push 	edi
	push 	eax
	xor		eax,eax
	
.nextchar:

	cmp		byte[esi],0
	je		.vege
	mov		al,[esi]
	add		esi,1
	cmp		al,' '
	je		.nextchar
	cmp		al,9
	je		.nextchar
	cmp		al,13
	je		.nextchar
	cmp		al,10
	je		.nextchar
	mov		[edi],al
	add		edi,1
	jmp		.nextchar
	
.vege:
	
	mov		byte[edi],0
	pop		eax
	pop		edi
	pop		esi
	

ret