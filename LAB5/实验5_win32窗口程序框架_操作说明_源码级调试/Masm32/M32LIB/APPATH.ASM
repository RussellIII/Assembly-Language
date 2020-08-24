; #########################################################################

      .386
      .model flat, stdcall  ; 32 bit memory model
      option casemap :none  ; case sensitive

    include masm32.inc
    include \masm32\include\kernel32.inc

    .code

; ########################################################################

GetAppPath proc lpPathBuffer:DWORD

    LOCAL buffer[128]:BYTE

    push esi
    push edi

    invoke GetModuleFileName,0,ADDR buffer,128

    lea esi, buffer
    xor edx, edx
    xor ecx, ecx

    cld             ; read forward

  @@:
    lodsb
    inc ecx         ; count bytes
    cmp al, 0
    je @F
    cmp al, "\"
    jne @B
    mov edx, ecx    ; put count of each "\" in edx
    jmp @B
  @@:

    invoke lstr,ADDR buffer,lpPathBuffer,edx

    pop edi
    pop esi

    ret

GetAppPath endp

; ########################################################################

end