; ########################################################################

    .486
    .model flat, stdcall
    option casemap :none

    include \masm32\include\masm32.inc

    .code

; ########################################################################

szCatStr proc lpszSource:DWORD, lpszAdd:DWORD

    LOCAL ln1:DWORD

    invoke StrLen,lpszSource
    mov ln1, eax

    mov esi, lpszAdd
    mov edi, lpszSource
    add edi, ln1

  @@:
    mov al, [esi]
    inc esi
    mov [edi], al
    inc edi
    test al, al       ; test for zero
    jne @B

    ret

szCatStr endp

; ########################################################################

end