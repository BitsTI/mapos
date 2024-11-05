# Map-OS: Instalação via _script_ automatizado

- Autor: [Barreto](https://github.com/barretowiisk)
- Revisor: [Lucas Fogolin](https://github.com/fogolin)
- Última revisão: 2024-11-04

---

## Requisitos

> [!WARNING]
> Este é um passo a passo desenhado e pensado para usuários de sistemas operacionais **Windows** ou **Linux** que utilizam **XAMPP**, com a dependência do **composer** instalada corretamente.

## Introdução

Este é um guia para que você possa utilizar scripts facilitadores na instalação do seu **Map-OS** utilizando as plataformas **Windows** ou **Linux**. Este guia acompanha um vídeo instrutivo:

[![Youtube Video](https://img.youtube.com/vi/aZE-LW_YOE4/0.jpg)](https://www.youtube.com/watch?v=aZE-LW_YOE4)

### Instalação Interativa

Tanto para usuários de sistemas operacionais **Windows** como **Linux**, você será capaz de encontrar arquivos prontos para facilitar a instalação da plataforma no seu servidor ou computador.

```structure
mapos
├── docs
│   ├── assets
│   ├── db
│   ├── scripts
│   │   ├── install.bat
│   │   └── install.sh
│   └── [...]
└── [...]
```

#### Windows 10/11

O arquivo com extensão `.bat` é um executável com instruções para realizar todos os procedimentos necessários em um sistema operacional Windows.

1. Execute o `Prompt de Comando` ou `PowerShell` como Administrador, clicando com o botão direito sobre o atalho e escolhendo esta opção;
2. Execute o comando: `PowerShell -command "& { iwr https://raw.githubusercontent.com/RamonSilva20/mapos/docs/scripts/install.bat -OutFile MapOS_Install.bat }; .\MapOS_Install.bat"`
3. Siga as instrunções em tela para poder concluir a instalação.

#### Linux (Ubuntu/Debian)

O arquivo responsável pelas instruções automatizadas no **Linux** é `.sh`, e ele precisa ser transformado em arquivo executável antes de poder instalar o sistema no seu dispositivo.

1. Abra o `Terminal` ou acesse seu servidor via `SSH`;
2. Eleve o privilégio aplicando `sudo su` (Recomendado);
3. Execute o comando: `curl -o MapOS_Install.sh -L https://raw.githubusercontent.com/RamonSilva20/mapos/master/install.sh`
4. Altere as permissões do arquivo para que ele possa ser executado, com o comando `chmod +x MapOS_Install.sh && ./MapOS_Install.sh`
5. Siga as instruções em tela para poder concluir a instalação.
