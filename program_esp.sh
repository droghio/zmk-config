#! /bin/bash

# Script to reprogram the ZMK config using an ESP32.

ESP32_PROGRAMMER_IP="10.0.0.111"
BIN_PATH="build/zephyr/zmk.bin"

curl "http://$ESP32_PROGRAMMER_IP/set_swd?cmd=init" -X POST &&
echo "" &&
curl "http://$ESP32_PROGRAMMER_IP/flash_cmd?cmd=erase_all" -X POST &&
echo "" &&
( curl "http://$ESP32_PROGRAMMER_IP/flash_file_direct" -H "Content-Type: multipart/form-data" -X POST -F "flash_up_file_offset=0" -F "flash_file_direct=@$BIN_PATH" --progress-bar | tee /dev/null ) &&
echo "" &&
curl "http://$ESP32_PROGRAMMER_IP/set_swd?cmd=set_reset" -X POST &&
echo ""
