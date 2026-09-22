#!/bin/bash

set -e

INSTALL_DIR="$HOME/.local/bin"
APP_DIR="$HOME/.local/share/applications"
PASSWORD_FILE="$HOME/.firefox-password"

echo "================================"
echo "       FIREFOX SECURE"
echo "================================"
echo

if ! command -v zenity >/dev/null 2>&1 || ! command -v openssl >/dev/null 2>&1; then
    echo "[*] Instalando dependências..."
    sudo apt update
    sudo apt install zenity openssl -y
fi

mkdir -p "$INSTALL_DIR"
mkdir -p "$APP_DIR"

echo "[*] Configurando senha..."

while true; do

    PASSWORD=$(zenity --password \
        --title="Firefox Secure" \
        --text="Crie a senha do Firefox:" \
        --width=400)

    if [ $? -ne 0 ]; then
        echo "Instalação cancelada."
        exit 1
    fi

    CONFIRM=$(zenity --password \
        --title="Firefox Secure" \
        --text="Digite novamente a senha:" \
        --width=400)

    if [ $? -ne 0 ]; then
        echo "Instalação cancelada."
        exit 1
    fi

    if [ "$PASSWORD" != "$CONFIRM" ]; then
        unset PASSWORD
        unset CONFIRM

        zenity --error \
            --title="Firefox Secure" \
            --text="As senhas não coincidem." \
            --width=350

        continue
    fi

    if [ -z "$PASSWORD" ]; then
        unset PASSWORD
        unset CONFIRM

        zenity --error \
            --title="Firefox Secure" \
            --text="A senha não pode estar vazia." \
            --width=350

        continue
    fi

    break
done

printf '%s' "$PASSWORD" | sha256sum | awk '{print $1}' > "$PASSWORD_FILE"

unset PASSWORD
unset CONFIRM

chmod 600 "$PASSWORD_FILE"

cp firefox-secure.sh "$INSTALL_DIR/firefox-secure"
chmod +x "$INSTALL_DIR/firefox-secure"

cat > "$APP_DIR/firefox-secure.desktop" <<EOF
[Desktop Entry]
Name=Firefox Secure
Comment=Firefox protegido por senha
Exec=$INSTALL_DIR/firefox-secure
Icon=firefox
Terminal=false
Type=Application
Categories=Network;WebBrowser;
StartupNotify=true
EOF

chmod +x "$APP_DIR/firefox-secure.desktop"

update-desktop-database "$APP_DIR" 2>/dev/null || true

echo
echo "================================"
echo "    INSTALAÇÃO CONCLUÍDA"
echo "================================"
echo
echo "Firefox Secure foi instalado."
echo
echo "Procure por 'Firefox Secure' no menu do sistema."
echo
