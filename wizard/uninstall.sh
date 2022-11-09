#!/bin/bash

# Install LibreCAD Appimage
# 1. Download LibreCad AppImage to this folder
# 2. Run the `install.sh` script in the terminal as root

function main
{
  if [[ `whoami` != "root" ]]; then
    echo "You must be root"
    exit
  fi
  uninstall_binary
  uninstall_file "usr/lib/mime/packages" "librecad"
  uninstall_file "usr/share/applications" "librecad.desktop"
  uninstall_file "usr/share/icons/hicolor/48x48/apps" "librecad.png"
  uninstall_file "usr/share/icons/hicolor/scalable/apps" "librecad.svg"
  uninstall_file "usr/share/mime/packages" "librecad.xml"
  uninstall_file "usr/share/pixmaps" "librecad.xpm"
  echo "Uninstallation completed"
}

# Install or Update LibreCAD AppImage
function uninstall_binary
{
  ABSOLUTEPATH="/usr/bin"
  FILE="librecad"
  # Delete old binary
  if [ -f "${ABSOLUTEPATH}/${FILE}" ]; then
    rm "${ABSOLUTEPATH}/${FILE}"
    if [[ "$?" != "0" ]]; then
      echo "ERROR: Can't delete the file \"${ABSOLUTEPATH}/${FILE}\""
      exit
    fi
  fi
}

# Uninstall file
function uninstall_file
{
  SCHEMEPATH="$1"
  FILE="$2"
  # Delete the file
  if [ -f "/${SCHEMEPATH}/${FILE}" ]; then
    rm "/${SCHEMEPATH}/${FILE}"
    if [[ "$?" != "0" ]]; then
      echo "ERROR: Can't delete the file \"/${SCHEMEPATH}/${FILE}\""
      exit
    fi
  fi
}

main
