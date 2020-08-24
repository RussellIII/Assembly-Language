; #########################################################################

    ; -----------------------------------------
    ; This procedure was written by Tim Roberts
    ; -----------------------------------------

      .386
      .model flat, stdcall  ; 32 bit memory model
      option casemap :none  ; case sensitive

    .code

; #########################################################################

atodw proc uses edi esi String:PTR BYTE

      ;----------------------------------------
      ; Convert decimal string into dword value
      ; return value in eax
      ;----------------------------------------

      xor eax, eax
      mov esi, [String]
      xor ecx, ecx
      xor edx, edx
      mov al, [esi]
      inc esi
      .if al == '-'
        mov edx, -1
	mov al, [esi]
	inc esi
      .endif
      .while al != 0
	sub al, '0'	; convert to bcd
	lea ecx, [ecx+ecx*4]	; ecx = ecx * 5
	lea ecx, [eax+ecx*2]	; ecx = eax + old ecx * 10
	mov al, [esi]
	inc esi
      .endw

      lea eax, [ecx+edx]	; move to eax and negate
      xor eax, edx

      ret

atodw endp

; #########################################################################

end
