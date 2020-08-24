; #########################################################################

; Prototypes

; CopyMemB PROTO :DWORD,:DWORD,:DWORD
; CopyMemD PROTO :DWORD,:DWORD,:DWORD

; #########################################################################

CopyMemB proc source:DWORD,dest:DWORD,len:DWORD

        mov ecx, len
        mov esi, source
        mov edi, dest

        rep movsb

        ret

CopyMemB endp

; #########################################################################

CopyMemD proc source:DWORD,dest:DWORD,len:DWORD

        cmp  len, 4        ; if < DWORD size
        jl  @@@1           ; copy as BYTE
        
        mov  esi, source
        mov  edi, dest
        mov  ecx, len

        push ecx           ; copy ecx
        shr  ecx, 2        ; integer divide by 4
        shl  ecx, 2        ; multiply by 4 for dividend
        pop  edx
        sub  edx, ecx      ; remainder in edx
        shr  ecx           ; div by 4 for DWORD

        rep  movsd         ; copy as DWORD
        mov  ecx, edx      ; put remainder in counter
        jmp  @@@2

      @@@1:
        mov  ecx, len
      @@@2:
        rep  movsb         ; copy as BYTE

        ret

CopyMemD endp

; #########################################################################