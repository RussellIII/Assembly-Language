rem 请根据VC的安装目录修改VCDir！
@echo off
set Masm32Dir=
set VCDir=C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\bin
set path=%PATH%;%Masm32Dir%\Bin;%Masm32Dir%;%VCDir%
set Masm32Dir=d:\Masm32
set include=%Masm32Dir%\Include;%include%
set lib=%Masm32Dir%\lib;%lib%
set Masm32Dir=
echo on