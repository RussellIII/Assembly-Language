; ########################################################################

    .386
    .model flat, stdcall  ; 32 bit memory model
    option casemap :none  ; case sensitive

    include \masm32\include\masm32.inc

    .code

; ########################################################################

revstr proc lpszSource:DWORD,lpszDest:DWORD

    LOCAL ln:DWORD

    invoke lnstr,lpszSource
    mov ln, eax

    mov esi, lpszSource
    mov edx, esi        ; put in edx for comparison
    dec edx
    add esi, ln         ; add len to source address
    dec esi
    mov edi, lpszDest

  @@:
    mov al, [esi]
    dec esi
    mov [edi], al
    inc edi
    cmp esi, edx
    jne @B

    mov al, 0
    mov [edi], al       ; write terminator

    ret

revstr endp

; ########################################################################

end