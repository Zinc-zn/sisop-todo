@echo off
title Kalkulator Sederhana
color 0A

:menu
cls
echo ================================================
echo            KALKULATOR SEDERHANA
echo ================================================
echo.
echo Pilih operasi yang ingin dilakukan:
echo.
echo [1] Penjumlahan (+)
echo [2] Pengurangan (-)
echo [3] Perkalian (*)
echo [4] Pembagian (/)
echo [0] Keluar
echo.
echo ================================================

set /p pilihan=Masukkan pilihan (0-4): 

if "%pilihan%"=="1" goto penjumlahan
if "%pilihan%"=="2" goto pengurangan
if "%pilihan%"=="3" goto perkalian
if "%pilihan%"=="4" goto pembagian
if "%pilihan%"=="0" goto keluar
goto invalid

:penjumlahan
cls
echo ================================================
echo                PENJUMLAHAN
echo ================================================
echo.
set /p angka1=Masukkan angka pertama: 
set /p angka2=Masukkan angka kedua: 
set /a hasil=%angka1% + %angka2%
echo.
echo Hasil: %angka1% + %angka2% = %hasil%
echo.
pause
goto menu

:pengurangan
cls
echo ================================================
echo                PENGURANGAN
echo ================================================
echo.
set /p angka1=Masukkan angka pertama: 
set /p angka2=Masukkan angka kedua: 
set /a hasil=%angka1% - %angka2%
echo.
echo Hasil: %angka1% - %angka2% = %hasil%
echo.
pause
goto menu

:perkalian
cls
echo ================================================
echo                PERKALIAN
echo ================================================
echo.
set /p angka1=Masukkan angka pertama: 
set /p angka2=Masukkan angka kedua: 
set /a hasil=%angka1% * %angka2%
echo.
echo Hasil: %angka1% * %angka2% = %hasil%
echo.
pause
goto menu

:pembagian
cls
echo ================================================
echo                PEMBAGIAN
echo ================================================
echo.
set /p angka1=Masukkan angka pertama: 
set /p angka2=Masukkan angka kedua: 
if %angka2%==0 (
    echo.
    echo ERROR: Tidak bisa membagi dengan nol!
    echo.
    pause
    goto menu
)
set /a hasil=%angka1% / %angka2%
set /a sisa=%angka1% %% %angka2%
echo.
echo Hasil: %angka1% / %angka2% = %hasil%
if %sisa% neq 0 echo Sisa: %sisa%
echo.
pause
goto menu

:invalid
cls
echo ================================================
echo              PILIHAN TIDAK VALID
echo ================================================
echo.
echo Silakan pilih angka antara 0-4!
echo.
pause
goto menu

:keluar
cls
echo ================================================
echo            TERIMA KASIH!
echo       Telah menggunakan kalkulator ini
echo ================================================
echo.
pause
exit