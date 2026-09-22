#!/bin/bash

PASSWORD_FILE="$HOME/.firefox-password"
MAX_ATTEMPTS=3
ATTEMPTS=0

if ! command -v zenity >/dev/null 2>&1; then
    zenity --error \
        --title="Firefox Secure" \
        --text="O Zenity não está instalado." \
        --width=350
    exit 1
fi

if [ ! -f "$PASSWORD_FILE" ]; then
    zenity --error \
        --title="Firefox Secure" \
        --text="Senha não configurada.\nExecute o instalador primeiro." \
        --width=350
    exit 1
fi

while [ $ATTEMPTS -lt $MAX_ATTEMPTS ]; do

    PASSWORD=$(zenity --password \
        --title="Firefox Secure" \
        --text="Digite a senha para acessar o Firefox:" \
        --width=400)

    if [ $? -ne 0 ]; then
        exit 0
    fi

    HASH=$(printf '%s' "$PASSWORD" | sha256sum | awk '{print $1}')
    unset PASSWORD

    if [ "$HASH" = "$(cat "$PASSWORD_FILE")" ]; then
        firefox "$@" >/dev/null 2>&1 &
        exit 0
    fi

    ATTEMPTS=$((ATTEMPTS + 1))
    REMAINING=$((MAX_ATTEMPTS - ATTEMPTS))

    if [ $REMAINING -gt 0 ]; then
        zenity --error \
            --title="Acesso negado" \
            --text="Senha incorreta.\nTentativas restantes: $REMAINING" \
            --width=350
    fi

done

zenity --error \
    --title="Firefox Secure" \
    --text="Número máximo de tentativas atingido.\nO Firefox não será iniciado." \
    --width=400

exit 1
