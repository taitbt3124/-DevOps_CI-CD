set -e

APP_USER="rikkeilms"
APP_DIR="/opt/rikkei/course-service"

if id "$APP_USER" &>/dev/null; then
    echo "User $APP_USER đã tồn tại, bỏ qua bước tạo user."
else
    sudo useradd -m -s /bin/bash "$APP_USER"
    echo "Đã tạo user $APP_USER."
fi

sudo mkdir -p "$APP_DIR"

sudo chown -R "$APP_USER":"$APP_USER" "$APP_DIR"

sudo chmod 755 "$APP_DIR"

id "$APP_USER"
ls -ld "$APP_DIR"
