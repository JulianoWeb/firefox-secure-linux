#!/bin/bash

PASSWORD_FILE="$HOME/.firefox-password"

if [ ! -f "$PASSWORD_FILE" ]; then
    zenity --error \
        --title="Firefox Secure" \
        --text="Nenhuma senha configurada." \
        --width=350
    exit 1
fi

OLD_PASSWORD=$(zenity --password \
    --title="Firefox Secure" \
    --text="Digite sua senha atual:" \
    --width=400)

if [ $? -ne 0 ]; then
    exit 0
fi

OLD_HASH=$(printf '%s' "$OLD_PASSWORD" | sha256sum | awk '{print $1}')
unset OLD_PASSWORD

if [ "$OLD_HASH" != "$(cat "$PASSWORD_FILE")" ]; then
    zenity --error \
        --title="Firefox Secure" \
        --text="Senha atual incorreta." \
        --width=350
    exit 1
fi

while true; do

    NEW_PASSWORD=$(zenity --password \
        --title="Firefox Secure" \
        --text="Digite sua nova senha:" \
        --width=400)

    if [ $? -ne 0 ]; then
        exit 0
    fi

    CONFIRM_PASSWORD=$(zenity --password \
        --title="Firefox Secure" \
        --text="Digite novamente a nova senha:" \
        --width=400)

    if [ $? -ne 0 ]; then
        exit 0
    fi

    if [ -z "$NEW_PASSWORD" ]; then
        zenity --error \
            --title="Firefox Secure" \
            --text="A senha não pode estar vazia." \
            --width=350
        continue
    fi

    if [ "$NEW_PASSWORD" != "$CONFIRM_PASSWORD" ]; then
        unset NEW_PASSWORD
        unset CONFIRM_PASSWORD

        zenity --error \
            --title="Firefox Secure" \
            --text="As senhas não coincidem." \
            --width=350
        continue
    fi

    break
done

printf '%s' "$NEW_PASSWORD" | sha256sum | awk '{print $1}' > "$PASSWORD_FILE"

unset NEW_PASSWORD
unset CONFIRM_PASSWORD

chmod 600 "$PASSWORD_FILE"

zenity --info \
    --title="Firefox Secure" \
    --text="Senha alterada com sucesso." \
    --width=350

exit 0

