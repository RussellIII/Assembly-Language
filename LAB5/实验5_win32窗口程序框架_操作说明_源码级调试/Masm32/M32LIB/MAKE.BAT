@echo off

echo        Assembling library modules.
echo.
\masm32\bin\ml /c /coff *.asm
\masm32\bin\lib *.obj /out:masm32.lib

: The following line works as well
: \masm32\bin\link -lib "*.obj" "/out:masm32.lib"

echo.
del *.obj
copy        masm32.lib \masm32\lib\masm32.lib
copy        masm32.inc \masm32\include\masm32.inc
echo.
echo        MASM32.LIB & MASM32.INC have been copied
echo        to the LIB & INCLUDE directories.
echo.
pause
@echo off
