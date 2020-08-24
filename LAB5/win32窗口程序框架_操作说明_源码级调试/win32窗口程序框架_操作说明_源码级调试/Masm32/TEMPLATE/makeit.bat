@echo off

if not exist rsrc.rc goto over1
J:\MASM32\BIN\Rc.exe /v rsrc.rc
J:\MASM32\BIN\Cvtres.exe /machine:ix86 rsrc.res
:over1

if exist %1.obj del Template.obj
if exist %1.exe del Template.exe

J:\MASM32\BIN\Ml.exe /c /coff Template.asm
if errorlevel 1 goto errasm

if not exist rsrc.obj goto nores

J:\MASM32\BIN\Link.exe /SUBSYSTEM:WINDOWS Template.obj rsrc.obj
if errorlevel 1 goto errlink

dir Template
goto TheEnd

:nores
J:\MASM32\BIN\Link.exe /SUBSYSTEM:WINDOWS Template.obj
if errorlevel 1 goto errlink
dir %1
goto TheEnd

:errlink
echo _
echo Link error
goto TheEnd

:errasm
echo _
echo Assembly Error
goto TheEnd

:TheEnd

pause

