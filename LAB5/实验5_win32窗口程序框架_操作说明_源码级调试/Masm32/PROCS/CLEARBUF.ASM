; ########################################################################

FillBuffer proc lpBuffer:DWORD,lnBuffer:DWORD,TheChar:BYTE

    ; FillBuffer PROTO :DWORD,:DWORD,:BYTE
    ; invoke FillBuffer,ADDR szFileName,length szFileName,0

    mov edi, lpBuffer   ; address of buffer
    mov ecx, lnBuffer   ; buffer length
    mov  al, TheChar    ; load al with character
    rep stosb           ; write character to buffer until ecx = 0

    ret

FillBuffer endp

; ########################################################################
