; ##########################################################################

    .386
    .model flat, stdcall
    option casemap :none   ; case sensitive

    .code

; ##########################################################################

StrLen proc item:DWORD

  ; -------------------------------------------------------------
  ; This procedure has been adapted from an algorithm written by
  ; Agner Fog. It has the unusual characteristic of reading up to
  ; three bytes past the end of the buffer as it uses DWORD size
  ; reads. It is measurably faster than a classic byte scanner on
  ; large linear reads and has its place where linear read speeds
  ; are important.
  ; -------------------------------------------------------------

    push    ebx
    mov     eax,item               ; get pointer to string
    lea     edx,[eax+3]            ; pointer+3 used in the end
  @@:     
    mov     ebx,[eax]              ; read first 4 bytes
    add     eax,4                  ; increment pointer
    lea     ecx,[ebx-01010101h]    ; subtract 1 from each byte
    not     ebx                    ; invert all bytes
    and     ecx,ebx                ; and these two
    and     ecx,80808080h    
    jz      @B                     ; no zero bytes, continue loop
    test    ecx,00008080h          ; test first two bytes
    jnz     @F
    shr     ecx,16                 ; not in the first 2 bytes
    add     eax,2
  @@:
    shl     cl,1                   ; use carry flag to avoid branch
    sbb     eax,edx                ; compute length
    pop     ebx

    ret

StrLen endp

; ##########################################################################

end