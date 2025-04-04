;Bereczki Anna 511 baim2326

;A stringek olvasását egyszerre lehet bemutatni a stringeken végzett műveletekkel.  
;Mindkét stringnek kiírjuk a hosszát, kompaktált formáját, majd a kompaktált formát 
;kis betűkre alakítva és nagy betűkre alakítva. Végül hozzáfűzzük az első string 
;nagybetűs verziójához a második string kisbetűs verzióját és kiírjuk a hosszával együtt.

; -megfelelő üzenet kiíratása után beolvasunk egy stringet;
; -kiírjuk a hosszát;
; -kiírjuk a tömörített formáját;
; -kiírjuk a tömörített formáját kisbetűkre alakítva;
; -megfelelő üzenet kiíratása után beolvasunk egy második stringet;
; -kiírjuk a hosszát;
; -kiírjuk a tömörített formáját;
; -kiírjuk a tömörített formáját nagybetűkre alakítva;
; -létrehozunk a memóriában egy új stringet: az első string nagybetűs verziójához hozzáfűzzük a második string kisbetűs verzióját;
; -kiírjuk a létrehozott stringet;
; -kiírjuk a létrehozott string hosszát;
; -befejezzük a programot.

%include 'iostr.inc'
%include 'strings.inc'
%include 'ionum.inc'
%include 'mio.inc'

global main

section .bss

strA  	resb 	255
strAcompact	resb 255
strB  	resb 	255
strBcompact	resb	255
ujstr	resb	500

section .data

uzenetA		db 	"elso string:  ",0
uzenet1		db  "string hossza: ",0
uzenetB		db	"masodik string:  ",0
uzenet2		db	"tomoritett string: ",0
uzenet3		db  "nagybetus string: ",0
uzenet4		db	"kisbetus string: ",0
uzenetuj	db  "osszefuzott string: ",0

section .text

main:

; -megfelelő üzenet kiíratása után beolvasunk egy stringet;

	mov		esi,uzenetA
	call	WriteStr
	mov		ecx,255
	mov 	edi,strA
	call 	ReadLnStr
	
; -kiírjuk a hosszát;

	mov		esi,uzenet1
	call	WriteStr
	mov 	esi,strA
	call	StrLen
	call	WriteInt
	call	NewLine
	
; -kiírjuk a tömörített formáját;

	mov		esi,uzenet2
	call	WriteStr
	mov		esi,strA
	mov		edi,strAcompact
	call	StrCompact
	mov		esi,strAcompact
	call	WriteLnStr
	
; -kiírjuk a tömörített formáját kisbetűkre alakítva;

	mov		esi,uzenet4
	call	WriteStr
	mov		esi,strAcompact
	call	StrLower
	mov		esi,strAcompact
	call	WriteLnStr
	
; -megfelelő üzenet kiíratása után beolvasunk egy második stringet;
	
	mov		esi,uzenetB
	call	WriteStr
	mov		ecx,255
	mov		edi,strB
	call	ReadLnStr
	
; -kiírjuk a hosszát;
	
	mov		esi,uzenet1
	call	WriteStr
	mov 	esi,strB
	call	StrLen
	call	WriteInt
	call	NewLine
	
; -kiírjuk a tömörített formáját;
	
	mov		esi,uzenet2
	call	WriteStr
	mov		esi,strB
	mov		edi,strBcompact
	call	StrCompact
	mov		esi,strBcompact
	call	WriteLnStr
	
; -kiírjuk a tömörített formáját nagybetűkre alakítva;
	
	mov		esi,uzenet3
	call	WriteStr
	mov 	esi,strBcompact
	call	StrUpper
	mov		esi,strBcompact
	call	WriteLnStr
	
; -létrehozunk a memóriában egy új stringet: az első string nagybetűs verziójához hozzáfűzzük a második string kisbetűs verzióját;
	
	mov 	esi,strAcompact
	call	StrUpper	
	mov		esi,strBcompact
	call	StrLower
	
	mov		edi,ujstr
	mov		byte[edi],0
	mov		esi,strAcompact
	call	StrCat
	
	mov		edi,ujstr
	mov		esi,strBcompact
	call	StrCat
	
	mov		esi,uzenet1
	call	WriteStr
	mov 	esi,ujstr
	call	StrLen
	call	WriteInt
	call	NewLine
	
; -kiírjuk a létrehozott stringet;

	mov		esi,uzenetuj
	call	WriteStr
	mov 	esi,ujstr
	call 	WriteStr

ret