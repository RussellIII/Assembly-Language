; ###########################################################################
;
;                         Support macros for MASM32
;
; ###########################################################################

    ; --------------------------------------------------
    ; Two macros for allocating and freeing OLE memory.
    ; stralloc returns the handle/address of the string
    ; memory in eax. strfree uses the handle to free
    ; memory after use.
    ; NOTE that you must use the following INCLUDE &
    ; LIB files with these two macros.
    ;
    ;       include \MASM32\include\oleaut32.inc
    ;       includelib \MASM32\LIB\oleaut32.lib
    ;
    ; --------------------------------------------------
      stralloc MACRO ln
        invoke SysAllocStringByteLen,0,ln
      ENDM

      strfree MACRO strhandle
        invoke SysFreeString,strhandle
      ENDM

    ; -----------------------------------------
    ; Encapsulate a non-changing piece of code
    ; -----------------------------------------
      DisplayWindow MACRO hndl
        invoke ShowWindow,hndl,SW_SHOWNORMAL
        invoke UpdateWindow,hndl
      ENDM

    ; ---------------------------------------
    ; Append literal string to end of buffer
    ; ---------------------------------------
      Append MACRO buffer,text
        LOCAL szTxt
        .data
          szTxt db text,0
        .code
        invoke szCatStr,ADDR buffer,ADDR szTxt
      ENDM

    ; ---------------------------
    ; Put ascii zero at 1st byte
    ; ---------------------------
      zero1 MACRO membuf
        mov membuf[0], 0
      ENDM

    ; -------------------------
    ; Application startup code
    ; -------------------------
      AppStart MACRO
        .code
        start:
        invoke GetModuleHandle, NULL
        mov hInstance, eax

        invoke GetCommandLine
        mov CommandLine, eax

        invoke InitCommonControls

        invoke WinMain,hInstance,NULL,CommandLine,SW_SHOWDEFAULT
        invoke ExitProcess,eax
      ENDM

    ; --------------------------------------------------------------
    ; Specifies processor, memory model & case sensitive option.
    ; The parameter "Processor" should be in the form ".386" etc..
    ; EXAMPLE : AppModel .586
    ; --------------------------------------------------------------
      AppModel MACRO Processor
        Processor             ;; Processor type
        .model flat, stdcall  ;; 32 bit memory model
        option casemap :none  ;; case sensitive
      ENDM

    ; --------------------------------------------
    ; The following two macros must be used as a
    ; pair and can only be used once in a module.
    ; Additional code for processing within the
    ; message loop can be placed between them.
    ;
    ; The single parameter passed to both macros
    ; is the name of the MSG structure and must be
    ; the same in both macros.
    ; --------------------------------------------

      BeginMessageLoop MACRO mStruct
        MessageLoopStart:
          invoke GetMessage,ADDR mStruct,NULL,0,0
          cmp eax, 0
          je MessageLoopExit
      ENDM

      EndMessageLoop MACRO mStruct
          invoke TranslateMessage, ADDR mStruct
          invoke DispatchMessage,  ADDR mStruct
          jmp MessageLoopStart
        MessageLoopExit:
      ENDM

    ; --------------------------------------------------------
    ; MsgBox macro takes 2 parameters, both can be either
    ; literal text in quotes or addresses of zero terminated
    ; strings passed with "ADDR szString" where szString is
    ; a zero terminated string. Note that ADDR is uppercase.
    ;
    ; example : MsgBox "Greetings all",ADDR szTitle
    ;           MsgBox ADDR szMessage,"Result"
    ;
    ; --------------------------------------------------------

      MsgBox MACRO handl, TxtMsg, TxtTitle, styl

        LOCAL Msg1
        LOCAL Titl

        If @InStr(1,<TxtMsg>,<ADDR>) eq 0
          If @InStr(1,<TxtTitle>,<ADDR>) eq 0
          .data
            Msg1 db TxtMsg,0
            Titl db TxtTitle,0
          .code
            invoke MessageBox,handl,ADDR Msg1,ADDR Titl,styl
            EXITM
          EndIf
        EndIf

        If @InStr(1,<TxtMsg>,<ADDR>) gt 0
          If @InStr(1,<TxtTitle>,<ADDR>) eq 0
          .data
            Titl db TxtTitle,0
          .code
            invoke MessageBox,handl,TxtMsg,ADDR Titl,styl
            EXITM
          EndIf
        EndIf

        If @InStr(1,<TxtMsg>,<ADDR>) eq 0
          If @InStr(1,<TxtTitle>,<ADDR>) gt 0
          .data
            Msg1 db TxtMsg,0
          .code
            invoke MessageBox,handl,ADDR Msg1,TxtTitle,styl
            EXITM
          EndIf
        EndIf

        If @InStr(1,<TxtMsg>,<ADDR>) gt 0
          If @InStr(1,<TxtTitle>,<ADDR>) gt 0
            invoke MessageBox,handl,TxtMsg,TxtTitle,styl
            EXITM
          EndIf
        EndIf

      ENDM

    ; -------------------------------------------
    ; put zero terminated string in .data section
    ; alternative to the szText MACRO
    ; -------------------------------------------
      dsText MACRO Name, Text:VARARG
      .data
        Name db Text,0
      .code
      ENDM

    ; -------------------------------
    ; make 2 WORD values into a DWORD
    ; result in eax
    ; -------------------------------
      MAKEDWORD MACRO LoWord,HiWord
        mov ax, HiWord
        ror eax, 16
        mov ax, LoWord
      ENDM

    ; -----------------------------
    ; return IMMEDIATE value in eax
    ; -----------------------------
      retval MACRO var
        IF var EQ 0
          xor eax, eax  ;; slightly more efficient for zero
        ELSE
          mov eax, var  ;; place value in eax
        ENDIF
      ENDM

    ; ------------------------
    ; inline memory copy macro
    ; ------------------------
      Mcopy MACRO lpSource,lpDest,len
        mov esi, lpSource
        mov edi, lpDest
        mov ecx, len
        rep movsb
      ENDM

    ;; -----------------------------------
    ;; INPUT red, green & blue BYTE values
    ;; OUTPUT DWORD COLORREF value in eax
    ;; -----------------------------------
      RGB MACRO red, green, blue
        xor eax, eax
        mov al, blue    ; blue
        rol eax, 8
        mov al, green   ; green
        rol eax, 8
        mov al, red     ; red
      ENDM

    ; ------------------------------------------------
    ; The following macro were written by Ron Thomas
    ; ------------------------------------------------
    ; Retrieves the low word from double word argument
    ; ------------------------------------------------
      LOWORD MACRO bigword  
        mov  eax,bigword
        and  eax,0FFFFh     ;; Set to low word 
      ENDM

    ; ----------------------
    ; fast lodsb replacement
    ; ----------------------
      lob MACRO
        mov al, [esi]
        inc esi
      ENDM

    ; ----------------------
    ; fast stosb replacement
    ; ----------------------
      stb MACRO
        mov [edi], al
        inc edi
      ENDM

    ; -------------------------------
    ; pascal calling convention macro
    ; left to right push
    ; -------------------------------
      Pcall MACRO name:REQ,items:VARARG
        LOCAL arg
        FOR arg,<items>
          push arg
        ENDM
          call name
      ENDM

    ; --------------------------------
    ; STDCALL calling convention macro
    ; right to left push
    ; --------------------------------
      Scall MACRO name:REQ,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12, \
                           p13,p14,p15,p16,p17,p18,p19,p20,p21,p22
        IF p22
          push p22
        ENDIF

        IF p21
          push p21
        ENDIF

        IF p20
          push p20
        ENDIF

        IF p19
          push p19
        ENDIF

        IF p18
          push p18
        ENDIF

        IF p17
          push p17
        ENDIF

        IF p16
          push p16
        ENDIF

        IF p15
          push p15
        ENDIF

        IF p14
          push p14
        ENDIF

        IF p13
          push p13
        ENDIF

        IF p12
          push p12
        ENDIF

        IF p11
          push p11
        ENDIF

        IF p10
          push p10
        ENDIF

        IF p9
          push p9
        ENDIF

        IF p8
          push p8
        ENDIF

        IF p7
          push p7
        ENDIF

        IF p6
          push p6
        ENDIF

        IF p5
          push p5
        ENDIF

        IF p4
          push p4
        ENDIF

        IF p3
          push p3
        ENDIF

        IF p2
          push p2
        ENDIF

        IF p1
          push p1
        ENDIF

        call name

      ENDM
