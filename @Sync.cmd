: """
::=========================================================
:: BEGIN BATCH
::=========================================================
@echo off
set PATHEXT=.PY;%PATHEXT%
set PATH=%~dp0\depot_tools;%PATH%
:: DO NOT VERIFY SSL, because git.chromium.org SSL certificate has expired.
set GIT_SSL_NO_VERIFY=true
git submodule update --init
pushd "%~dp0"
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
export GIT_SSL_NO_VERIFY=true
PATH=$PWD/depot_tools:$PATH
chmod 700 $PWD/depot_tools/gclient.py
git submodule update --init
manifest_url=$(cat < ManifestUrl.txt)
cd ".."
gclient.py config --name=manifest $manifest_url
gclient.py sync -j 1
