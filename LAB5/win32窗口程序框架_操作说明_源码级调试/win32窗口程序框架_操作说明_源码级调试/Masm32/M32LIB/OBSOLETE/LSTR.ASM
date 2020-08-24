; #########################################################################

      .386
      .model flat, stdcall  ; 32 bit memory model
      option casemap :none  ; case sensitive

    .code

; ########################################################################

lstr proc lpSource:DWORD, lpDest:DWORD, lnth:DWORD

    push esi
    push edi

    cld                 ; read forward

    mov esi, lpSource
    mov edi, lpDest
    mov ecx, lnth

    rep movsb

    mov al, 0
    stosb

    pop edi
    pop esi

    ret

lstr endp

; ########################################################################

end