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
set name=%~1
cd /d "%third_party_dir%\%name%"
git reset --hard HEAD
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
    cd "$third_party_dir/$name"
    git reset --hard HEAD
  popd > /dev/null
done
