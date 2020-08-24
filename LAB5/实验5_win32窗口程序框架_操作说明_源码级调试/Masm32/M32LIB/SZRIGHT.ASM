; #########################################################################

    .386
    .model flat, stdcall  ; 32 bit memory model
    option casemap :none  ; case sensitive

    include \masm32\include\masm32.inc

    .code

; ###########################################################################

szRight proc lpszSource:DWORD,lpszTarget:DWORD,ln:DWORD

    LOCAL ln1:DWORD

    invoke StrLen,lpszSource
    mov ln1, eax

    cld

    mov esi, lpszSource
    add esi, ln1
    sub esi, ln
    mov edi, lpszTarget
    mov ecx, ln

    shr ecx, 2
    rep movsd

    mov ecx, ln
    and ecx, 3
    rep movsb

    mov al, 0
    mov [edi], al

    ret

szRight endp

; ###########################################################################

end