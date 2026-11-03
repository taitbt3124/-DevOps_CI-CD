#!/bin/bash
# initial-script.sh - Thiet lap moi truong ban dau cho QuickBite

set -e   # Dung script ngay neu co lenh bi loi

# Kiem tra quyen root
if [ "$EUID" -ne 0 ]; then
    echo "Vui long chay script bang sudo: sudo ./initial-script.sh"
    exit 1
fi

echo "===== 1. Cap nhat he thong ====="
sudo apt-get update && sudo apt-get upgrade -y

echo "===== 2. Cai dat goi phan mem ====="
sudo apt-get install -y openjdk-17-jdk git curl

echo "===== 3. Kiem tra va tao group quickbite ====="
if getent group quickbite > /dev/null; then
    echo "Group quickbite da ton tai, bo qua."
else
    sudo groupadd quickbite
    echo "Da tao group quickbite."
fi

echo "===== 4. Tao system user quickbite ====="
if id quickbite &> /dev/null; then
    echo "User quickbite da ton tai, bo qua."
else
    # -r: system user, khong tao home | -g: nhom chinh | -s /bin/false: khoa dang nhap
    sudo useradd -r -g quickbite -s /bin/false quickbite
    echo "Da tao user quickbite."
fi

echo "===== Hoan tat! ====="
java -version
id quickbite
