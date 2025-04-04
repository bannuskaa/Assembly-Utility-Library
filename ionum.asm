;Bereczki Anna 511 baim2326

%include 'iostr.inc'
%include 'mio.inc'

global ReadInt, WriteInt, ReadInt64, WriteInt64 , ReadBin, WriteBin, ReadBin64, WriteBin64, ReadHex, WriteHex, ReadHex64, WriteHex64

section .text 

ReadInt:

	push 	ebx
	push	ecx
	mov 	ebp,esp
	sub		esp,256
	mov		edi,esp
	mov		ecx,256
	call	ReadStr
	
	mov 	edi,ebp
	sub		edi,256
	
	CLC
	
	xor 	eax,eax
	xor		ebx,ebx
	mov		ecx,1
	
	mov		al,[edi]
	cmp		al,'-'
	jne		.nextchar
	mov		ecx,-1
	add		edi,1
	
.nextchar:

	mov		al,[edi]
	cmp 	al,0
	je		.vege
	
;hiba vizsgalas

	cmp 	al,'0'
	jl		.nemszj

	cmp 	al,'9'
	jg		.nemszj
	sub 	al,'0'
	imul	ebx,10
	add		ebx,eax
	add		edi,1
	jmp		.nextchar
	
.nemszj:

	STC
	jmp .vege2
	
.vege:
	
	imul 	ebx,ecx
	mov		eax,ebx
	
.vege2:

	mov 	esp,ebp
	pop		ecx
	pop 	ebx
	
ret

WriteInt:

;valtozok verembe mentese es verem jelolese xel

	push 	ecx
	push	edx
	push	eax
	push	'x'
	mov 	ecx,10

;negativ szam lekezelese

	cmp 	eax,0
	jge		.nextpush
	mov 	edx,eax
	mov 	eax,'-'
	call	mio_writechar
	mov		eax,edx
	imul	eax,-1
	
;szamjegyek verembe mentese
	
.nextpush:

	CDQ
	idiv     ecx
	push	edx
	cmp		eax,0
	jg		.nextpush
	
;kiiras	
	
.nextpop:

	pop		eax
	cmp		eax,'x'
	je		.vege
	add		eax,'0'
	call	mio_writechar
	jmp		.nextpop
	
.vege:
	
	pop     eax
	pop		edx
	pop		ecx
	
ret

ReadInt64:

	push 	ebx
	push	ecx
	push 	esi
	
	mov 	ebp,esp
	sub		esp,256
	mov		edi,esp
	mov		ecx,256
	call	ReadStr
	
	mov 	edi,ebp
	sub		edi,256
	
	CLC
	
	xor 	eax,eax
	xor		ebx,ebx
	xor		edx,edx
	mov		ecx,1
	
	mov		bl,[edi]
	cmp		bl,'-'
	jne		.nextchar
	mov		ecx,0
	add		edi,1
	
.nextchar:

	xor		ebx,ebx
	mov		bl,[edi]
	cmp 	bl,0
	je		.vege
	
;hiba vizsgalas

	cmp 	bl,'0'
	jl		.nemszj

	cmp 	bl,'9'
	jg		.nemszj
	
	sub 	bl,'0'
	push 	ebx
	mov 	ebx,10
	mov 	esi,edx
	imul	esi,10
	xor		edx,edx
	mul		ebx
	add		edx,esi
	
	pop 	ebx
	add		eax,ebx
	adc		edx,0
	add		edi,1
	CLC
	jmp		.nextchar
	
.nemszj:

	STC
	jmp .vege2
	
.vege:
	
	cmp		ecx,0
	jne      .vege2
	not 	eax
	not		edx
	add		eax,1
	adc		edx,0
	CLC
	
.vege2:

	mov 	esp,ebp
	pop		esi
	pop		ecx
	pop 	ebx

ret 

WriteInt64:


	push 	eax
	push 	ebx
	push	ecx
	push	edx
	push	edi
	push	'x'
	mov 	ecx,10

;negativ szam lekezelese

	cmp 	edx,0
	jge		.nextpush
	push 	eax
	
	mov 	eax,'-'
	call	mio_writechar
	
	pop 	eax
	not		eax
	not 	edx
	add		eax,1
	adc		edx,0
	
;szamjegyek verembe mentese
	
.nextpush:

	mov 	ebx,eax
	mov		eax,edx
	xor		edx,edx
	
	div		ecx 	;10
	push	eax
	mov		eax,ebx
	pop		ebx
	div		ecx 	;10
	
	push 	edx
	mov		edx,ebx
	
	cmp		eax,0
	jne		.nextpush
	cmp		edx,0
	jne		.nextpush
	
;kiiras	
	
.nextpop:

	pop		eax
	cmp		eax,'x'
	je		.vege
	add		eax,'0'
	call	mio_writechar
	jmp		.nextpop
	
.vege:
	
	pop		edi
	pop     edx
	pop		ecx
	pop		ebx
	pop		eax

ret

ReadBin:

	mov 	ebp,esp
	sub		esp,256
	mov		edi,esp
	mov		ecx,256
	call	ReadStr
	
	mov 	esp,ebp
	sub		esp,256
	mov		edi,esp
	
	CLC
	
	xor 	eax,eax
	xor		ebx,ebx
	
.ujsz:

	mov		al,[edi]
	cmp		al,0
	je		.vege
	cmp		al,'0'
	jl		.nembit
	cmp		al,'1'
	jg		.nembit
	sub		al,'0'
	shl		ebx,1
	add		ebx,eax
	add		edi,1
	jmp 	.ujsz
	
.nembit:

	STC

.vege:
	
	mov		eax,ebx
	mov 	esp,ebp

ret

WriteBin:

	push 	eax
	push 	ebx
	push 	ecx
	push	edx
	
	mov		ebx,eax
	
	CLC
	
	mov		ecx,32
	
.nextbit:
	
	sub 	ecx,1
	push 	ecx

;kiir karakter

	xor 	eax,eax
	xor 	edx,edx
	shl		ebx,1
	adc     eax,edx
	add		eax,'0'
	call	mio_writechar
	
;kiir space

	mov		eax,ecx
	mov 	ecx,4
	CDQ
	idiv	ecx
	cmp		edx,0
	jne		.tovabb
	mov 	eax,' '
	call	mio_writechar
	
.tovabb:
	
	pop 	ecx
	cmp		ecx,0
	jg		.nextbit

	pop 	edx
	pop 	ecx
	pop		ebx
	pop 	eax

ret

ReadBin64:

	mov 	ebp,esp
	sub		esp,256
	mov		edi,esp
	mov		ecx,256
	call	ReadStr
	
	mov 	esp,ebp
	sub		esp,256
	mov		edi,esp
	
	CLC
	
	xor 	eax,eax
	xor		ebx,ebx
	xor 	edx,edx
	
.ujsz:

	mov		al,[edi]
	cmp		al,0
	je		.vege
	cmp		al,'0'
	jl		.nembit
	cmp		al,'1'
	jg		.nembit
	sub		al,'0'
	shl 	edx,1
	shl		ebx,1
	adc		edx,0
	add		ebx,eax
	add		edi,1
	CLC
	jmp 	.ujsz
	
.nembit:

	STC

.vege:
	
	mov		eax,ebx
	mov 	esp,ebp

ret


WriteBin64:

	push 	eax
	push	edx
	
	push 	eax
	mov		eax,edx
	call	WriteBin
	pop 	eax
	call	WriteBin
	
	pop		edx
	pop 	eax

ret

ReadHex:

	mov 	ebp,esp
	sub		esp,256
	mov		edi,esp
	mov		ecx,256
	call	ReadStr
	
	mov 	esp,ebp
	sub		esp,256
	mov		edi,esp
	
	CLC
	
	xor		eax,eax
	xor		ebx,ebx

.nextchar:

	mov		al,[edi]
	cmp 	al,0
	je		.vege

;szamjegy tipus vizsgalasa
	
	cmp 	eax,'0'
	jge		.gezero
	jmp		.nemszj

.gezero:
	
	cmp 	eax,'9'
	jle		.szj
	
.nemszj:

	cmp		eax,'a'
	jge		.gea
	jmp		.nemabc
	
.gea:

	cmp		eax,'f'
	jle		.abc

.nemabc:

	cmp		eax,'A'
	jge		.geA
	jmp		.nemABC
	
.geA:

	cmp		eax,'F'
	jle		.ABC

.nemABC:  ;hiba

	STC
	
	jmp 	.vege
	
;tipusnak megfelelo atalakitasa
	
.szj:

	sub 	eax,'0'
	shl 	ebx,4
	add		ebx,eax
	add		edi,1
	jmp		.nextchar
	
.abc:

	sub 	eax,'a'
	add		eax,10
	shl 	ebx,4
	add		ebx,eax
	add		edi,1
	jmp		.nextchar
	
.ABC:

	sub 	eax,'A'
	add		eax,10
	shl 	ebx,4
	add		ebx,eax
	add		edi,1
	jmp		.nextchar
	
.vege:
	
	mov		eax,ebx
	mov 	esp,ebp
	
	ret

WriteHex:

;valtozok elmetese es verem jelolese x-el

	push	ecx
	push 	eax
	push 	ebx
	push 	edx
	push	'x'
	mov 	edx,8
	mov   	ecx,15
	
;szmjegyek verembe helyezese

.nextpush:

	mov 	ebx,eax
	and		ebx,ecx
	shr		eax,4
	push	ebx
	sub		edx,1
	cmp		edx,0
	jg		.nextpush
	
	mov 	eax,'0'
	call	mio_writechar
	mov		eax,'x'
	call	mio_writechar
	

;kiiras

.nextpop:

	pop		eax
	cmp		eax,'x'
	je		.vege
	cmp		eax,9
	jg		.abc
	add		eax,'0'
	call	mio_writechar
	jmp		.nextpop
	
.abc:
		
	add		eax,'A'
	sub		eax,10
	call	mio_writechar
	jmp 	.nextpop
	
.vege:

;valtozok verembol visszanyerese

	pop		edx
	pop 	ebx
	pop 	eax
	pop		ecx

ret

ReadHex64:

	mov 	ebp,esp
	sub		esp,256
	mov		edi,esp
	mov		ecx,256
	call	ReadStr
	
	mov 	esp,ebp
	sub		esp,256
	mov		edi,esp
	
	CLC
	
	xor		eax,eax
	xor		ebx,ebx
	xor		edx,edx

.nextchar:

	mov		al,[edi]
	cmp 	al,0
	je		.vege

;szamjegy tipus vizsgalasa
	
	cmp 	eax,'0'
	jge		.gezero
	jmp		.nemszj

.gezero:
	
	cmp 	eax,'9'
	jle		.szj
	
.nemszj:

	cmp		eax,'a'
	jge		.gea
	jmp		.nemabc
	
.gea:

	cmp		eax,'f'
	jle		.abc

.nemabc:

	cmp		eax,'A'
	jge		.geA
	jmp		.nemABC
	
.geA:

	cmp		eax,'F'
	jle		.ABC

.nemABC:  ;hiba

	STC
	
	jmp 	.vege
	
;tipusnak megfelelo atalakitasa
	
.szj:

	sub 	eax,'0'
	
	shl 	edx,1
	shl 	ebx,1
	adc		edx,0
	
	shl 	edx,1
	shl 	ebx,1
	adc		edx,0
	
	shl 	edx,1
	shl 	ebx,1
	adc		edx,0
	
	shl 	edx,1
	shl 	ebx,1
	adc		edx,0
	
	add		ebx,eax
	add		edi,1
	jmp		.nextchar
	
.abc:

	sub 	eax,'a'
	add		eax,10
	
	shl 	edx,1
	shl 	ebx,1
	adc		edx,0
	
	shl 	edx,1
	shl 	ebx,1
	adc		edx,0
	
	shl 	edx,1
	shl 	ebx,1
	adc		edx,0
	
	shl 	edx,1
	shl 	ebx,1
	adc		edx,0
	add		ebx,eax
	add		edi,1
	jmp		.nextchar
	
.ABC:

	sub 	eax,'A'
	add		eax,10
	
	shl 	edx,1
	shl 	ebx,1
	adc		edx,0
	
	shl 	edx,1
	shl 	ebx,1
	adc		edx,0
	
	shl 	edx,1
	shl 	ebx,1
	adc		edx,0
	
	shl 	edx,1
	shl 	ebx,1
	adc		edx,0
	add		ebx,eax
	add		edi,1
	jmp		.nextchar
	
.vege:
	
	mov		eax,ebx
	mov 	esp,ebp	

ret

WriteHex64:

	push 	eax
	push	edx
	
	push 	eax
	
	mov 	eax,edx
	call	WriteHex
	
	pop 	eax
	
	;valtozok elmetese es verem jelolese x-el

	push	ecx
	push 	ebx
	push 	edx
	push	'x'
	mov 	edx,8
	mov   	ecx,15
	
;szmjegyek verembe helyezese

.nextpush:

	mov 	ebx,eax
	and		ebx,ecx
	shr		eax,4
	push	ebx
	sub		edx,1
	cmp		edx,0
	jg		.nextpush
	
;kiiras

.nextpop:

	pop		eax
	cmp		eax,'x'
	je		.vege
	cmp		eax,9
	jg		.abc
	add		eax,'0'
	call	mio_writechar
	jmp		.nextpop
	
.abc:
		
	add		eax,'A'
	sub		eax,10
	call	mio_writechar
	jmp 	.nextpop
	
.vege:

;valtozok verembol visszanyerese

	pop		edx
	pop 	ebx
	pop		ecx
	
	pop		edx
	pop		eax
ret