; #########################################################################

      .386
      .model flat, stdcall  ; 32 bit memory model
      option casemap :none  ; case sensitive

    .code

; ###########################################################################

szMid proc lpszSource:DWORD,lpszTarget:DWORD,stPos:DWORD,ln:DWORD

    cld

    mov esi, lpszSource
    mov edi, lpszTarget
    add esi, stPos
    mov ecx, ln

    shr ecx, 2
    rep movsd

    mov ecx, ln
    and ecx, 3
    rep movsb

    mov al, 0
    mov [edi], al

    ret

szMid endp

; ###########################################################################

end