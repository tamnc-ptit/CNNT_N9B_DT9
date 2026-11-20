#!/bin/bash
# Script sao lưu dịch vụ Web Nginx - Đề tài 09
BACKUP_DIR="/backup"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/company_web_$DATE.tar.gz"

echo "=== BẮT ĐẦU QUÁ TRÌNH SAO LƯU DỮ LIỆU ==="
tar -czvf "$BACKUP_FILE" /var/www/ /etc/nginx/sites-available/

if [ $? -eq 0 ]; then
    echo "=> Sao lưu thành công: $BACKUP_FILE"
    ls -lh "$BACKUP_FILE"
else
    echo "=> LỖI: Sao lưu thất bại!"
fi
