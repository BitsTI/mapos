# Map-OS

![MapOS](./assets/img/logo.png)

![version](https://img.shields.io/badge/version-4.47.0-blue.svg?longCache=true&style=flat-square)
![license](https://img.shields.io/badge/license-MIT-green.svg?longCache=true&style=flat-square)
![theme](https://img.shields.io/badge/theme-Matrix--Admin-lightgrey.svg?longCache=true&style=flat-square)
![issues](https://img.shields.io/github/issues/RamonSilva20/mapos.svg?longCache=true&style=flat-square)
![contributors](https://img.shields.io/github/contributors/RamonSilva20/mapos.svg?longCache=true&style=flat-square)

Vote ou sugira melhorias: [Feedback](https://github.com/RamonSilva20/mapos/discussions)
Contato: [contato@mapos.com.br](mailto:contato@mapos.com.br)

![Map-OS](./docs/assets/dashboard.png)

## Sobre o Map-OS

Um Sistema de Gestão e Controle de Ordens de Serviço completo que lhe ajudara a manter o sua empresa organizada de uma forma simples e intuitiva.

## Instalação

O sistema é pensado de forma a ser facilmente instalado tnato em soluções de serviços locais como em VPS na nuvem. Siga o guia mais adequado para o seu cenário de infraestrutura:

- Básico ([Servidor Web](./docs/install_webserver.md))
- Windows ([Utilizando o XAMPP](./docs/install_windows_xampp.md))
- Docker:
  - [Instalação legada](./docs/install_docker_legacy.md)
  - [Instalação revisada](./docs/install_docker.md)
- [Scripts automatizados](./docs/install_automated_scripts.md)

Cada guia está acompanhado de instruções específicas para o seu cenário. Acompanhe atentamente as instruções para que você consiga instalar e utilizar com sucesso o ssitema. Confira todos os itens na [documentação](./docs/README.md).

## Atualizações

O Map-OS conta com um sistema de atualizações embutido no painel de adminstração, de fácil acesso e utilização. Você pode acompanhar todas as mudanças no sistema pelo [`changelog`](./docs/CHANGELOG.md). Para uma atualização segura, acompanhe os passos a seguir.

> [!WARNING]
> Antes de uma atualização, é sempre recomendado fazer baclup dos seus dados e arquivos, assim você garante que há como restabelecer o serviço se houver algum problema durante a atualização.

### Servidor de Arquivos

1. Faça o backup dos arquivos e do banco de dados:
   1. Logado como **administrador** vá em `configurações > backup`.
2. Dentro da pasta `Assets`, copie as pastas `anexos`, `arquivos`, `uploads`, `userimage`, além de qualquer personalização feita dentro da pasta `img`.
3. Dentro da pasta `application` copie o arquivo `.env`.
4. Substitua os arquivos na pasta do sistema pelos da nova pelos da nova versão, descompactando e substituindo todos os dados.
5. Rode o comando `composer install --no-dev` a partir da raiz do projeto (no caso de instalações com **Windows** e **XAMPP**, ela fica em `C:\xampp\htdocs\mapos`)
6. Restaure os backups para seus locais devidos.
7. Logue no sistema como **administrador** e navegue até `Configurações > Sistema` e clique no botão `Atualizar Banco de Dados` (Obs.: Também é possível atualizar o banco de dados via terminal rodando o comando `php index.php tools migrate` a partir da raiz do projeto).
8. Pronto, sua atualização está concluída!

### Container Docker

1. Pare o Docker com o comando `docker compose down`
2. Faça o backup dos arquivos e do banco de dados:
   1. Logado como administrador vá em `configurações > backup`.
3. Dentro da pasta `Assets` copie as pastas `anexos`, `arquivos`, `uploads`, `userimage` e qualquer personalização feita dentro da pasta `img`.
4. Dentro da pasta `application` copie o arquivo `.env`.
5. Substitua os arquivos pelos da nova versão.
6. Entre na pasta `docker` no seu terminal e rode o comando `docker compose up --force-recreate -d`.
7. Logue no sistema como administrador e navegue até `Configurações > Sistema` e clique no botão `Atualizar Banco de Dados` para atualizar seu banco de dados (Obs.: Também é possível atualizar o banco de dados via terminal rodando o comando `php index.php tools migrate` a partir da raiz do projeto).
8. Restaure os backups para seus locais devidos;
9. Pronto, sua atualização está concluída;

### Atualização via sistema

1. Primeiro é necessário atualizar manualmente o sistema para a versão `v4.4.0`;
2. Quando estiver nessa versão é possível atualizar o sistema clicando no botão `Atualizar Mapos` em `Sistema > Configurações`;
3. Serão baixados e atualizados todos os arquivos exceto: `config.php`, `database.php` e `email.php`;

## Comandos de terminal

Para listar todos os comandos de terminal disponíveis, basta executar o comando `php index.php tools` a partir da raiz do projeto, após feita todo o processo de instalação.

## Hospedagem Parceira

Em parceria com o Projeto Map-OS a SysGO oferece hospedagem de qualidade e suporte personalizado para usuários dos Map-OS com custo justo e confiabilidade.
Solicite sua hospedagem agora [Clique Aqui!](https://sysgo.com.br/mapos)

<img src="https://sysgo.com.br/img-externo/mapos-github.jpg" alt="SysGO - MAP-OS Cloud Hosting" style="width:50%;">

## Frameworks/Bibliotecas

- [bcit-ci/CodeIgniter](https://github.com/bcit-ci/CodeIgniter)
- [twbs/bootstrap](https://github.com/twbs/bootstrap)
- [jquery/jquery](https://github.com/jquery/jquery)
- [jquery/jquery-ui](https://github.com/jquery/jquery-ui)
- [mpdf/mpdf](https://github.com/mpdf/mpdf)
- [Matrix Admin](http://wrappixel.com/demos/free-admin-templates/matrix-admin/index.html)
- [filp/whoops](https://github.com/filp/whoops)

## Requerimentos

- PHP = 8.2
- MySQL
- Composer

## Doações

Gosta do mapos e gostaria de contribuir com seu desenvolvimento?

Doações podem ser realizadas nos links:

- [catarse/mapos](https://www.catarse.me/mapos) - Mensal
- [kofi/mapos](https://ko-fi.com/mapos) - Exporádica

## Estrelas

[![Estrelas](https://api.star-history.com/svg?repos=RamonSilva20/mapos&type=Date)](https://star-history.com/#RamonSilva20/mapos&Date)

## Contribuidores

[![Contribuidores](https://contrib.rocks/image?repo=RamonSilva20/mapos)](https://github.com/RamonSilva20/mapos/graphs/contributors)

[Código de Conduta](./docs/CODE_OF_CONDUCT.md)

## Autor

| [<img src="https://avatars.githubusercontent.com/RamonSilva20?s=115"><br><sub>Ramon Silva</sub>](https://github.com/RamonSilva20) |
| :---: |
