#!/usr/bin/env bash
set -e

##############################################################################
# name: iso2usb.sh
#
# Author: Cody Lane
# Date 2024-05
#
# Description:
#  Attempted platform agnostic utility to convert iso -> usb
#  The USB drive becomes bootable
#
# Supported OS:
#   MacOS
#   Linux
#
# Example:
#
# On MacOS
#   ./iso2usb.sh ~/Downloads/linuxmint-21.3-cinnamon-64bit-edge.iso disk2
#
#
# On Linux
#   ./iso2usb.sh ~/Downloads/linuxmint-21.3-cinnamon-64bit-edge.iso sdc
#
##############################################################################


# global variables
ISO="${1}"
DISK="${2}"
USB="/dev/${DISK}"
OS_TYPE=$(uname -s | tr [:upper:] [:lower:])


err()
{
  echo "ERR: $*. Exitting" >&2
  exit 1
}


dd_osx()
{
  hdiutil convert -format UDRW -o "${IMG_NAME}" "${ISO}"
  echo

	diskutil unmountdisk "${USB}"

  mv -f "${IMG_NAME}.dmg" "${IMG_NAME}.img"

	USB="/dev/r${DISK}"
  sudo dd if="${IMG_NAME}.img" of="${USB}" bs=1M status=progress
}


dd_linux()
{
  sudo dd if="${ISO}" of="${USB}" bs=1M status=progress
}


main()
{
echo
echo "ISO='${ISO}'"
echo "IMG_NAME='${IMG_NAME}'"
echo "DISK='${DISK}'"
echo

case "${OS_TYPE}" in

  darwin*)
    dd_osx
  ;;

  linux*)
    dd_linux
  ;;

  *)
    err "un-supported OS type '${OS_TYPE}'"
  ;;

esac
}


[ -z "${ISO}" ] && err "Please pass a full path to an iso file." || true
[ -f "${ISO}" ] || err "The iso file. '${ISO}' does not exist."
[ -z "${DISK}" ] && err "Please pass the USB drive. Ex. 'disk2' or 'sdc'" || true

IMG_NAME=$(echo "${ISO##*/}" | sed -e 's/\.iso$//')

echo
echo "#########################################################################"
echo " INFO: This script requires sudo so you may be asked for your password. #"
echo "#########################################################################"
echo

main
exit $?
