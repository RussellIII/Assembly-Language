; #########################################################################

    .386
    .model flat, stdcall  ; 32 bit memory model
    option casemap :none  ; case sensitive

    .code

; ########################################################################

szLeft proc lpszSource:DWORD,lpszTarget:DWORD,ln:DWORD

    push esi
    push edi

    cld

    mov esi, lpszSource
    mov edi, lpszTarget
    mov ecx, ln

    shr ecx, 2
    rep movsd

    mov ecx, ln
    and ecx, 3
    rep movsb

    mov al, 0
    mov [edi], al

    pop edi
    pop esi

    ret

szLeft endp

; ###########################################################################

end