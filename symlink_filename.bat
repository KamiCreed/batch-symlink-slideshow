@ECHO OFF
REM symlink images onto image.jpg based on text file contents

setlocal enabledelayedexpansion

SET "tmpImg1=image.jpg"
SET "tmpImg2=image_other.jpg"
SET "toDel=%tmpImg1%"

SET "textpath=%1"
SET "linuxpath=%textpath:\=/%"
SET onImg1=1

:BEGINLOOP
bash -cxe "cat '%linuxpath%' | shuf > tmp.txt; mv tmp.txt '%linuxpath%'"
FOR /F "tokens=*" %%I IN (%textpath%) DO (
    ECHO %%I:
    ECHO  creating link...

    SET /A "onImg1 ^= 1"
    if !onImg1! EQU 1 (
        if exist "%tmpImg2%" (
            DEL %tmpImg2%
        )
        mklink "%tmpImg2%" "%%I"
        echo [%%~nI] > img2.txt
    ) else (
        if exist "%tmpImg1%" (
            DEL %tmpImg1%
        )
        mklink "%tmpImg1%" "%%I"
        SET "toDel=%tmpImg2%"
        echo [%%~nI] > img1.txt
    )
    ECHO  created!
    ECHO  sleeping...
    timeout 8
    ping 127.0.0.1 -n 1 -w 400> nul
)

GOTO BEGINLOOP
endlocal
