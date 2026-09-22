#!/bin/bash

INSTALL_DIR="$HOME/.local/bin"
APP_DIR="$HOME/.local/share/applications"
PASSWORD_FILE="$HOME/.firefox-password"

zenity --question \
    --title="Firefox Secure" \
    --text="Deseja realmente remover o Firefox Secure?" \
    --ok-label="Remover" \
    --cancel-label="Cancelar" \
    --width=400

if [ $? -ne 0 ]; then
    exit 0
fi

rm -f "$INSTALL_DIR/firefox-secure"
rm -f "$APP_DIR/firefox-secure.desktop"
rm -f "$PASSWORD_FILE"

update-desktop-database "$APP_DIR" 2>/dev/null || true

zenity --info \
    --title="Firefox Secure" \
    --text="Firefox Secure foi removido com sucesso." \
    --width=400

exit 0
