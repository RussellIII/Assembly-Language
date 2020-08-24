; #########################################################################

    .386
    .model flat, stdcall  ; 32 bit memory model
    option casemap :none  ; case sensitive

    include masm32.inc

    .code

; #########################################################################

InString proc StartPos:DWORD, lpszString:DWORD, lpszSubStr:DWORD

  ; ------------------------------------------------------------------
  ; InString searches for a substring in a larger string and if it is
  ; found, it returns its position in eax. 
  ;
  ; It uses a one (1) based character index (1st character is 1,
  ; 2nd is 2 etc...) for both the "StartPos" parameter and the returned
  ; character position.
  ;
  ; Return Values.
  ; If the function succeeds, it returns the 1 based index of the start
  ; of the substring.
  ;  0 = no match found
  ; -1 = substring same length or longer than main string
  ; -2 = "StartPos" parameter out of range (less than 1 or longer than
  ; main string)
  ; ------------------------------------------------------------------

    LOCAL lnStrng :DWORD
    LOCAL lnSubSt :DWORD
    LOCAL reg1    :DWORD
    LOCAL reg2    :DWORD
    LOCAL Byte1   :BYTE

    push esi
    push edi
    push ebx

    .if StartPos < 1
      mov eax, -2               ; set eax -2
      jmp Get_Outa_Here         ; exit if less than 1
    .endif

    dec StartPos                ; correct to 0 based index

    invoke lnstr,lpszString     ; main string length
    mov lnStrng, eax
    push eax

    invoke lnstr,lpszSubStr     ; sub string length
    mov lnSubSt, eax

    pop eax
    sub eax, lnSubSt            ; subtract substr len from main string
    dec eax                     ; for following comparison

    .if StartPos >= eax
      mov eax, -2               ; set eax -2
      jmp Get_Outa_Here         ; exit if greater than lnStrng
    .endif

    .if eax >= lnStrng
      mov eax, -1               ; set eax -1
      jmp Get_Outa_Here         ; exit if not shorter
    .endif

    mov esi, lpszSubStr         ; get 1st byte in substring
    lodsb
    mov bl, al                  ; put comparison byte in bl

  ; -------------------------------------------------------
  ; set maximum count as main string length minus substring
  ; -------------------------------------------------------
    mov ecx, lnStrng
    sub ecx, lnSubSt

  ; **************************************

    inc ecx     ;<< modified here

  ; **************************************

    push lpszString             ; save string address for later comparison

    add ecx, lpszString         ; add it to lnStrng

    mov esi, lpszString         ; main string address
    add esi, StartPos           ; add starting position to esi

    cld                         ; read forward

    lpSt:                       ; 8 cycles on no 1st char match
      mov al, [esi]             ; 1
      inc esi                   ; 1
      cmp al, bl                ; 1     find 1st substring byte
      je @F                     ; 1 - 3 compare subsequent bytes to
      cmp esi, ecx              ; 1
      jne lpSt                  ; 3 - 1
      
      mov eax, 0                ; return zero and exit if
      jmp Get_Outa_Here         ; match not found in string

  ; ------------------------------------------------
  ; do the comparison, main string is already in esi
  ; ------------------------------------------------

    @@:

    mov reg1, ecx               ; 1
    mov reg2, esi               ; 1

    mov ecx, lnSubSt            ; sub string length
    inc ecx                     ; compare correct number of bytes
    dec esi                     ; back one to compare correct bytes
    mov edi, lpszSubStr

    repe cmpsb                  ; 9 if strings match, ecx will be 0

    cmp ecx, 0                  ; did the two strings match ??
    jne @F
      pop eax                   ; pop the value put in esi at start
      sub esi, eax              ; subtract it from esi current value
      sub esi, lnSubSt          ; subtract the search string length

      mov eax, esi              ; put count in eax
      add eax, StartPos         ; add starting pos to get correct count

      mov ecx, reg1             ; if yes, restore registers
      mov esi, reg2
      jmp Get_Outa_Here
    @@:

    mov ecx, reg1               ; 1
    mov esi, reg2               ; 1
    jmp lpSt                    ; try again for match

    Get_Outa_Here:

    pop ebx
    pop edi
    pop esi

    ret

InString endp

; #########################################################################

    end