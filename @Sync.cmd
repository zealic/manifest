: """
::=========================================================
:: BEGIN BATCH
::=========================================================
@echo off
git pull
if %errorlevel% neq 0 exit /b 1
set PATHEXT=.PY;%PATHEXT%
set PATH=%~dp0\depot_tools;%PATH%
:: DO NOT VERIFY SSL, because git.chromium.org SSL certificate has expired.
set GIT_SSL_NO_VERIFY=true
git submodule update --init
pushd "%~dp0"
if not exist ManifestUrl.txt (
  echo Please switch to another branch, Don't be master branch!
  exit /b 1
)
for /f %%i in (ManifestUrl.txt) do set manifest_url=%%i
popd
pushd "%~dp0\.."
gclient config --name=manifest %manifest_url%
gclient sync -j 1
popd

@goto :eof
"""
#!/bin/bash
#=========================================================
# BEGIN SHELL
#=========================================================
git pull
if [ $? != 0 ] ; then
  exit 1
fi
export GIT_SSL_NO_VERIFY=true
PATH=$PWD/depot_tools:$PATH
git submodule update --init
chmod 700 "$PWD/depot_tools/gclient.py"
if [ ! -f ManifestUrl.txt ] ; then
  echo "Please switch to another branch, Don't be master branch!"
  exit 1
fi
manifest_url=$(cat < ManifestUrl.txt)
cd ".."
gclient.py config --name=manifest $manifest_url
gclient.py sync -j 1
