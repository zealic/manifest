: """
::=========================================================
:: BEGIN BATCH
::=========================================================
@echo off
pushd "%~dp0\..\third-party"
set third_party_dir=%cd%
popd
pushd patches
  for /f %%i in ('dir /ad /b *') do (
    call :APPLY_DIR %%i
  )
popd
goto :eof

:APPLY_DIR
pushd "%~1"
  for /f %%i in ('dir /b *.patch') do (
    call :APPLY_PATCH "%~1" "%%i"
  )
popd
goto :eof

:APPLY_PATCH
set name=%~1
set full_pfile=%cd%\%~nx2
cd "%third_party_dir%\%name%"
git apply "%full_pfile%"
goto :eof
"""
#!/bin/bash
#=========================================================
# BEGIN SHELL
#=========================================================
third_party_dir=$(pwd)/../third-party
cd patches
for name in */
do
  pushd $name > /dev/null
    for pfile in $( find . -type f -name "*.patch" )
    do
      full_pfile=$(pwd)/$(basename $pfile)
      cd "$third_party_dir/$name"
      git apply "$full_pfile"
    done
  popd > /dev/null
done
