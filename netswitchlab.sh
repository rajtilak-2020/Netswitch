#!/usr/bin/env bash

set -euo pipefail

IP_ADDRESS="${IP_ADDRESS:-10.2.11.80/22}"
GATEWAY="${GATEWAY:-10.2.8.1}"
DNS_SERVER="${DNS_SERVER:-8.8.8.8}"
INTERFACE_NAME="${INTERFACE_NAME:-}"
CONNECTION_NAME="${CONNECTION_NAME:-}"

require_root() {
  if [[ ${EUID} -ne 0 ]]; then
    echo "Please run this script with sudo."
    exit 1
  fi
}

require_nmcli() {
  if ! command -v nmcli >/dev/null 2>&1; then
    echo "nmcli is required but was not found."
    echo "Install NetworkManager, or adapt this script for your network stack."
    exit 1
  fi
}

detect_interface() {
  if [[ -n "${INTERFACE_NAME}" ]]; then
    printf '%s\n' "${INTERFACE_NAME}"
    return
  fi

  local detected
  detected="$(nmcli -t -f DEVICE,TYPE,STATE device status | awk -F: '$2 == "ethernet" && $3 != "unavailable" {print $1; exit}')"

  if [[ -z "${detected}" ]]; then
    echo "No Ethernet interface detected. Set INTERFACE_NAME manually and retry."
    exit 1
  fi

  printf '%s\n' "${detected}"
}

detect_connection() {
  local device="$1"

  if [[ -n "${CONNECTION_NAME}" ]]; then
    printf '%s\n' "${CONNECTION_NAME}"
    return
  fi

  local active_connection
  active_connection="$(nmcli -t -f NAME,DEVICE connection show --active | awk -F: -v dev="${device}" '$2 == dev {print $1; exit}')"

  if [[ -n "${active_connection}" ]]; then
    printf '%s\n' "${active_connection}"
    return
  fi

  local saved_connection
  saved_connection="$(nmcli -t -f NAME,DEVICE connection show | awk -F: -v dev="${device}" '$2 == dev {print $1; exit}')"

  if [[ -z "${saved_connection}" ]]; then
    echo "No NetworkManager connection profile found for interface ${device}."
    echo "Set CONNECTION_NAME manually and retry."
    exit 1
  fi

  printf '%s\n' "${saved_connection}"
}

main() {
  require_root
  require_nmcli

  local device connection
  device="$(detect_interface)"
  connection="$(detect_connection "${device}")"

  echo "Switching to LAB network..."
  echo "Interface: ${device}"
  echo "Connection: ${connection}"

  nmcli connection modify "${connection}" \
    ipv4.method manual \
    ipv4.addresses "${IP_ADDRESS}" \
    ipv4.gateway "${GATEWAY}" \
    ipv4.dns "${DNS_SERVER}" \
    ipv4.ignore-auto-dns yes

  nmcli connection up "${connection}" ifname "${device}"

  echo
  echo "LAB network configured successfully."
  echo "IP: ${IP_ADDRESS}"
  echo "Gateway: ${GATEWAY}"
  echo "DNS: ${DNS_SERVER}"
}

main "$@"