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
  install_binary
  install_file "usr/lib/mime/packages" "librecad"
  install_file "usr/share/applications" "librecad.desktop"
  install_file "usr/share/icons/hicolor/48x48/apps" "librecad.png"
  install_file "usr/share/icons/hicolor/scalable/apps" "librecad.svg"
  install_file "usr/share/mime/packages" "librecad.xml"
  install_file "usr/share/pixmaps" "librecad.xpm"
  echo "Installation completed"
}

# Install or Update LibreCAD AppImage
function install_binary
{
  ABSOLUTEPATH="/usr/bin"
  FILE="librecad"
  APPIMAGE="$(ls -1 "${SCRIPT_PATH}" | grep -m 1 -i "${FILE}" | grep -i ".appimage")"
  if [[ "$?" == "0" ]]; then
    # Delete old binary
    if [ -f "${ABSOLUTEPATH}/${FILE}" ]; then
      rm "${ABSOLUTEPATH}/${FILE}"
      if [[ "$?" != "0" ]]; then
        echo "ERROR: Can't delete the file \"${ABSOLUTEPATH}/${FILE}\""
        exit
      fi
    fi
    # Install librecad binary
    mv "${SCRIPT_PATH}/${APPIMAGE}" "${ABSOLUTEPATH}/${FILE}"
    if [[ "$?" != "0" ]]; then
      echo "ERROR: Can't move the file \"${SCRIPT_PATH}/${FILE}\" to \"${ABSOLUTEPATH}/${FILE}\""
      exit
    fi
    chmod +x "${ABSOLUTEPATH}/${FILE}"
    if [[ "$?" != "0" ]]; then
      echo "ERROR: Can't make executable \"${ABSOLUTEPATH}/${FILE}\""
      exit
    fi
  else
    echo "WARNING: Unable to find the LibreCAD AppImage file"
    exit
  fi
}

# Install file
function install_file
{
  SCHEMEPATH="$1"
  FILE="$2"
  # Delete the previous file
  if [ -f "/${SCHEMEPATH}/${FILE}" ]; then
    rm "/${SCHEMEPATH}/${FILE}"
    if [[ "$?" != "0" ]]; then
      echo "ERROR: Can't delete the file \"/${SCHEMEPATH}/${FILE}\""
      exit
    fi
  fi
  # Install the new file
  cp "${SCRIPT_PATH}/${SCHEMEPATH}/${FILE}" "/${SCHEMEPATH}/${FILE}"
  if [[ "$?" != "0" ]]; then
    echo "ERROR: Can't write the file \"/${SCHEMEPATH}/${FILE}\""
    exit
  fi
}

SCRIPT_PATH="$(realpath "$0" | rev | cut -f2- -d '/' | rev)" # Starts with '/' ends without '/'

main
