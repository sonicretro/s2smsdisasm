@echo off
echo Assembling...
wla_dx_binaries_latest\wla-z80 -vo src\s2.asm s2.o> build_report.txt
if %ERRORLEVEL% neq 0 goto assemble_fail

echo Linking...
wla_dx_binaries_latest\wlalink -rs link.txt s2.sms
if %ERRORLEVEL% neq 0 goto link_fail

echo ==========================
echo   Build Success.
echo ==========================

rem	Use fcomp to compare with original ROM
echo Comparing with original:
fcomp s2.sms "Sonic the Hedgehog 2 (UE) [!].sms"

goto end

:assemble_fail
echo Error while assembling.
goto fail
:link_fail
echo Error while linking.
:fail

echo ==========================
echo   Build failure."
echo ==========================

:end
pause