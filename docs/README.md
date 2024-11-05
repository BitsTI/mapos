# Map-OS: Documentação

- Autor: [Lucas Fogolin](https://github.com/fogolin)
- Última revisão: 2024-11-04

---

Esta pasta visa organizar e facilitar a consulta de documentação, guias e recursos do projeto **Map-OS**, de forma que você possa facilmente localizar informações relevantes para a sua instalação.

## Estrutura de pastas

```structure
mapos
├── docs/
│   ├── assets/
│   │   ├── imagens.{jpg|png}
│   │   └── [...]
│   ├── db/
│   │   ├── modelagem.mwb
│   │   └── modelagem.mwb.bak
│   ├── scripts/
│   │   ├── install.bat
│   │   └── install.sh
│   ├── CHANGELOG.md
│   ├── CODE_OF_CONDUCT.md
│   ├── {nome_do_guia}.md
│   ├── install_{*}.md
│   ├── README.md
│   └── setup_{*}.md
└── [...]
```

A estrutura de pastas desta seção de documentação visa facilitar o acesso e gerenciamento do conteúdo.

## Nomenclatura e Organização

A nomnclatura dos documentos de apoio, guias e seus anexos, é organizada de tal forma que facilite sua identificação e atualização quando necessário.

### Convenção

O formato de nome do guia também facilita sua identificação, assim, atualmente são utilizadas as seguintes convenções:

- **Guias de instalação**: os guias que estão relacionados a como instalar o sistema estão iniciados pelo nome `install_`;
- **Guias de configuração**: os documentos que auxiliam usuários no uso de recursos específicos ou na configuração da ferramenta são iniciados por `setup_`.

### Relacionamento

O nome de arquivo é bastante explicativo e, na pasta `./assets` você pode encontrar imagens relacionadas ao guia por utilizarem a mesma estrutura de nome. Exemplo:

- O guia se chama `install_windows_xampp.md`;
- As imagens deste guia se chamarão `install_windows_xampp_img{00}.{jpg|png}`.

## Índice de Guias

Nesta seção você encontrará os guias atualmente disponíveis na plataforma.

### Instalação

Seção destinada aos guias e documentos relacionados à instalação do sistema:

- [Instalação por meio de _scripts_](./install_automated_scripts.md): compatível com **Windows** e **Linux**
- Instalação via **Docker**
  - [Processo legado](./install_docker_legacy.md)
  - [Processo atualizado/revisado](./install_docker.md)
- [Instalação em **WebServer** Linux](./install_webserver.md)
- [Instalação via **Windows** com **XAMPP**](./install_windows_xampp.md)

### Configuração

Seção destinada aos guias e documentos relacionados à configuração e aplicações de recursos práticos na utilização do sistema:

- [Configuração de **CronJobs** para disparo de e-mails no **Windows**](./setup_emails_cronjobs_windows.md)

## Changelog

Você pode consultar todas as atualizações e mudanças promovidas no sistema acessando o documento de _log_ de mudanças. [Clique aqui!](./CHANGELOG.md)
