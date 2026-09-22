# 🔐 Firefox Secure Linux

> Ferramenta em Bash para proteger o acesso ao Firefox no Debian/Linux através de autenticação gráfica por senha.

![Bash](https://img.shields.io/badge/Bash-Scripting-121011?logo=gnu-bash&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-Debian-FCC624?logo=linux&logoColor=black)
![Zenity](https://img.shields.io/badge/Zenity-GUI-blue)
![OpenSSL](https://img.shields.io/badge/OpenSSL-SHA--256-721412?logo=openssl&logoColor=white)

## 🎯 Demonstração

Ao tentar abrir o Firefox através do **Firefox Secure**, uma janela gráfica solicita a senha configurada.

**Senha correta:**
- 🟢 Firefox é iniciado

**Senha incorreta:**
- 🔴 Acesso negado
- 🔢 Até 3 tentativas permitidas

## 🚀 Funcionalidades

- 🔐 Proteção do Firefox por senha
- 🖥️ Interface gráfica com Zenity
- 🔑 Hash SHA-256
- 🔒 Arquivo de senha protegido com `chmod 600`
- 🚫 Limite de 3 tentativas
- 🔄 Alteração de senha
- 📦 Instalação automática
- 🗑️ Desinstalação automática
- 🐧 Desenvolvido e testado no Debian/Linux

## 🛠️ Tecnologias

- Bash
- Debian/Linux
- Zenity
- OpenSSL
- SHA-256

## 📂 Estrutura

```text
firefox-secure-linux/
├── firefox-secure.sh
├── install.sh
├── uninstall.sh
├── change-password.sh
├── README.md
└── .gitignore

