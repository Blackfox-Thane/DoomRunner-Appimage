#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(wget -qO- https://api.github.com/repos/Youda008/DoomRunner/releases/latest | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/128x128/apps/DoomRunner.png
# export DEPLOY_OPENGL=1
# export DEPLOY_VULKAN=1

# Deploy dependencies
quick-sharun /usr/bin/DoomRunner
#  /usr/lib/qt6/plugins/platformthemes/libqt6ct.so \
#  /usr/lib/qt6/plugins/platformthemes/libqtlxqt.so \
#  /usr/lib/qt6/plugins/styles/libkvantum.so

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the test fails due to the app
# having issues running in the CI use --simple-test instead
# quick-sharun --test ./dist/*.AppImage
