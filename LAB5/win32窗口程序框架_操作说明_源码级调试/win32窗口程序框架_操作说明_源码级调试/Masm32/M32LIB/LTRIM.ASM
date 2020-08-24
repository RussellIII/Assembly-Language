; ########################################################################

      .386
      .model flat, stdcall  ; 32 bit memory model
      option casemap :none  ; case sensitive

    .code

; ########################################################################

ltrim proc source:DWORD,dest:DWORD

    push esi
    push edi

    mov esi, source
    mov edi, dest

    cld             ; read forward

    @@:
      lodsb
      cmp al, 0     ; exit on zero
      je ltOut_Label
      cmp al, 32    ; loop if space
      je @B
      cmp al, 9     ; loop if tab
      je @B
      stosb

    @@:
      lodsb
      cmp al, 0     ; exit on zero
      je ltOut_Label
      stosb
      jmp @B

    ltOut_Label:
      stosb         ; write terminating zero

      pop edi
      pop esi

    ret

ltrim endp

; ########################################################################

end