#!/bin/bash
set -e

echo "SFTP with Kubernetes Secret users"

USERS_FILE="/users.conf"

addgroup -S web || true

if [ ! -f "$USERS_FILE" ]; then
  echo "ERROR: users.conf not found"
  exit 1
fi

while IFS=: read -r user uid pass; do
  echo "Creating user $user ($uid)"

  adduser -D -h /var/www/html -u "$uid" "$user"

  echo "$user:$pass" | chpasswd

  addgroup "$user" web || true

done < "$USERS_FILE"

chown -R root:web /var/www/html
chmod -R 2775 /var/www/html

/usr/sbin/sshd -D -e
