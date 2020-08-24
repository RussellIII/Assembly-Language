; #########################################################################

      .386
      .model flat, stdcall  ; 32 bit memory model
      option casemap :none  ; case sensitive

    .code

; ########################################################################

midstr proc source:DWORD, substring:DWORD, stPos:DWORD, ln:DWORD

    push esi
    push edi

    cld                 ; read forward

    mov esi, source     ; source string address
    mov edi, substring  ; sub string buffer address
    add esi, stPos      ; add starting position to esi
    mov ecx, ln         ; put length in ecx
    rep movsb           ; write ln bytes to sub string buffer

    mov al, 0           ; add terminator
    stosb

    pop edi
    pop esi

    ret

midstr endp

; ########################################################################

end