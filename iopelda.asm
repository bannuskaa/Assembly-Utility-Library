;Bereczki Anna 511 baim2326

; -beolvas egy előjeles 32 bites egész számot 10-es számrendszerben;
; -kiírja a beolvasott értéket 10-es számrendszerben előjeles egészként, komplementer kódbeli ábrázolását 16-os és kettes számrendszerben;
; -beolvas egy 32 bites hexa számot;
; -kiírja a beolvasott értéket 10-es számrendszerben előjeles egészként, komplementer kódbeli ábrázolását 16-os és kettes számrendszerben;
; -beolvas egy 32 bites bináris számot;
; -kiírja a beolvasott értéket 10-es számrendszerben előjeles egészként, komplementer kódbeli ábrázolását 16-os és kettes számrendszerben;
; -kiírja a három beolvasott érték összegét 10-es számrendszerben előjeles egészként, komplementer kódbeli ábrázolását 16-os és kettes számrendszerben;
; -ez előző lépéseket elvégzi 64 bites értékekre is.

%include 'iostr.inc'
%include 'strings.inc'
%include 'ionum.inc' 
%include 'mio.inc'

global main

section .bss



section .data

A 	dd	0
B   dd  0
C   dd  0
A64a dd 0
A64d dd 0
B64a dd 0
B64d dd 0
C64a dd 0
C64d dd 0
osszeg  dd 0
strA  db  "32 bites egesz szam 10es szamrendszerben:  ",0
strB  db  "32 bites hexa szam:  ",0
strC  db  "32 bites binaris szam:  ",0
strA64  db  "64 bites egesz szam 10es szamrendszerben:  ",0
strB64  db  "64 bites hexa szam:  ",0
strC64  db  "64 bites binaris szam:  ",0
str10 db "10-es szamrendszerben: ",0
strhex db "16-os szamrendszerben: ",0
strbin db "2-es szamrendszerben: ",0
strosszeg db "a harom szam osszeg : ",0
Strhiba db "Hiba",0

section .text

main:

; -beolvas egy előjeles 32 bites egész számot 10-es számrendszerben;

.ujra1:

	mov		esi,strA
	call	WriteStr
	call  	ReadInt
	
	jnc		.jo1
	call	hiba
	jmp 	.ujra1
	
.jo1:
	
	mov		[A],eax
	call 	NewLine
	
; -kiírja a beolvasott értéket 10-es számrendszerben előjeles egészként, 
;komplementer kódbeli ábrázolását 16-os és kettes számrendszerben;
	
	mov		esi,str10
	call	WriteStr
	mov		eax,[A]	
	call	WriteInt
	call 	NewLine
	
	mov		esi,strhex
	call	WriteStr
	call	WriteHex
	call 	NewLine

	mov		esi,strbin
	call	WriteStr
	call	WriteBin
	call 	NewLine
	
; -beolvas egy 32 bites hexa számot;

.ujra2:

	mov		esi,strB
	call	WriteStr
	call  	ReadHex
	
	jnc		.jo2
	call	hiba
	jmp 	.ujra2

.jo2:
	
	mov		[B],eax
	call 	NewLine

; -kiírja a beolvasott értéket 10-es számrendszerben előjeles egészként,
; komplementer kódbeli ábrázolását 16-os és kettes számrendszerben;

	mov		eax,[B]
	
	mov		esi,str10
	call	WriteStr
	call	WriteInt
	call 	NewLine
	
	mov		esi,strhex
	call	WriteStr
	call	WriteHex
	call 	NewLine

	mov		esi,strbin
	call	WriteStr
	call	WriteBin
	call 	NewLine
	
; -beolvas egy 32 bites bináris számot;

.ujra3:

	mov		esi,strC
	call	WriteStr
	call  	ReadBin
	
	jnc		.jo3
	call	hiba
	jmp 	.ujra3
	
.jo3:
	
	mov		[C],eax
	call 	NewLine
	
; -kiírja a beolvasott értéket 10-es számrendszerben előjeles egészként, 
;komplementer kódbeli ábrázolását 16-os és kettes számrendszerben;

	mov		eax,[C]
	mov		esi,str10
	call	WriteStr
	call	WriteInt
	call 	NewLine
	
	mov		esi,strhex
	call	WriteStr
	call	WriteHex
	call 	NewLine

	mov		esi,strbin
	call	WriteStr
	call	WriteBin
	call 	NewLine
	
; -kiírja a három beolvasott érték összegét 10-es számrendszerben előjeles egészként, 
;komplementer kódbeli ábrázolását 16-os és kettes számrendszerben;

	mov 	eax,[A]
	add		eax,[B]
	add		eax,[C]
	mov		[osszeg],eax
	
	mov 	esi,strosszeg
	
	call	WriteLnStr
	
	mov		esi,str10
	call	WriteStr
	mov		eax,[osszeg]	
	call	WriteInt
	call 	NewLine
	
	mov		esi,strhex
	call	WriteStr
	call	WriteHex
	call 	NewLine

	mov		esi,strbin
	call	WriteStr
	call	WriteBin
	call 	NewLine
	
; -beolvas egy előjeles 64 bites egész számot 10-es számrendszerben;
	
	xor 	edx,edx

.ujra11:

	mov		esi,strA64
	call	WriteStr
	call  	ReadInt64
	
	jnc		.jo11
	call	hiba
	jmp 	.ujra11
	
.jo11:
	
	mov		[A64a],eax
	mov 	[A64d],edx
	call 	NewLine
	
; -kiírja a beolvasott értéket 10-es számrendszerben előjeles egészként, 
;komplementer kódbeli ábrázolását 16-os és kettes számrendszerben;
	
	mov		esi,str10
	call	WriteStr
	call	WriteInt64
	call 	NewLine
	
	mov		esi,strhex
	call	WriteStr
	call	WriteHex64
	call 	NewLine

	mov		esi,strbin
	call	WriteStr
	call	WriteBin64
	call 	NewLine
	
; -beolvas egy 64 bites hexa számot;

.ujra22:

	mov		esi,strB64
	call	WriteStr
	call  	ReadHex64
	
	jnc		.jo22
	call	hiba
	jmp 	.ujra22

.jo22:
	
	mov		[B64a],eax
	mov 	[B64d],edx
	call 	NewLine

; -kiírja a beolvasott értéket 10-es számrendszerben előjeles egészként,
; komplementer kódbeli ábrázolását 16-os és kettes számrendszerben;

	
	mov		esi,str10
	call	WriteStr
	call	WriteInt64
	call 	NewLine
	
	mov		esi,strhex
	call	WriteStr
	call	WriteHex64
	call 	NewLine

	mov		esi,strbin
	call	WriteStr
	call	WriteBin64
	call 	NewLine
	
; -beolvas egy 32 bites bináris számot;

.ujra33:

	mov		esi,strC64
	call	WriteStr
	call  	ReadBin64
	
	jnc		.jo33
	call	hiba
	jmp 	.ujra33
	
.jo33:
	
	mov		[C64a],eax
	mov 	[C64d],edx
	call 	NewLine
	
; -kiírja a beolvasott értéket 10-es számrendszerben előjeles egészként, 
;komplementer kódbeli ábrázolását 16-os és kettes számrendszerben;

	mov		esi,str10
	call	WriteStr
	call	WriteInt64
	call 	NewLine
	
	mov		esi,strhex
	call	WriteStr
	call	WriteHex64
	call 	NewLine

	mov		esi,strbin
	call	WriteStr
	call	WriteBin64
	call 	NewLine
	
; -kiírja a három beolvasott érték összegét 10-es számrendszerben előjeles egészként, 
;komplementer kódbeli ábrázolását 16-os és kettes számrendszerben;

	mov 	eax,[A64a]
	mov		edx,[A64d]
	add		eax,[B64a]
	adc		edx,[B64d]
	add		eax,[C64a]
	adc		edx,[C64d]
	
	mov 	esi,strosszeg
	call	WriteLnStr
	
	mov		esi,str10
	call	WriteStr
	call	WriteInt64
	call 	NewLine
	
	mov		esi,strhex
	call	WriteStr
	call	WriteHex64
	call 	NewLine

	mov		esi,strbin
	call	WriteStr
	call	WriteBin64
	call 	NewLine
	
ret

hiba:

	push   	esi
	
	call	NewLine
	mov 	esi,Strhiba
	call	WriteLnStr
	
	pop 	esi

ret