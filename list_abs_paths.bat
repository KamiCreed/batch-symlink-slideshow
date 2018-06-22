@echo off
for /r %%a in (%1\*.jpg,%1\*.png) do echo %%~fa
