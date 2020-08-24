; #########################################################################

    .386
    .model flat, stdcall  ; 32 bit memory model
    option casemap :none  ; case sensitive

    .code

; ########################################################################

lnstr proc lpszString:DWORD

  ; ---------------------------
  ; put length of string in eax
  ; EXCLUDING terminating zero
  ; ---------------------------
      mov eax, lpszString

    @@:
      mov dl, [eax]         ;  1
      inc eax               ;  1
      cmp dl, 0             ;  1
      jne @B                ;  3 when jmp taken

      sub eax, lpszString
      dec eax               ;  correct count
 
      ret

lnstr endp

; ########################################################################

end