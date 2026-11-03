set -e

if [ "$EUID" -ne 0 ]; then
    echo "Vui long chay bang sudo: sudo ./setup-dirs.sh"
    exit 1
fi

# Can user/group quickbite tu bai exercise_03
if ! id quickbite &> /dev/null; then
    echo "Chua co user quickbite. Hay chay initial-script.sh truoc."
    exit 1
fi

echo "===== 1. Tao thu muc ung dung ====="
mkdir -p /opt/quickbite/user-service

echo "===== 2. Doi chu so huu (de quy) ====="
chown -R quickbite:quickbite /opt/quickbite

echo "===== 3. Phan quyen 750 ====="
chmod 750 /opt/quickbite
chmod 750 /opt/quickbite/user-service

echo "===== Kiem tra ====="
ls -la /opt
