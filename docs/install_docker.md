# Map-OS: Instalação via Docker (revisada)

- Autor: [Lucas Fogolin](https://github.com/fogolin)
- Última revisão: 2024-08-26

---

## Requisitos

> [!WARNING]
> Este é um passo a passo desenhado e pensado para usuários de sistemas operacionais **Windows** ou **Linux** que utilizam a plataforma **Docker** para instalação de aplicações via containers.

Este guia depende de que ambos, **Docker** e **Docker Compose**, estejam instalados corretamente no seu sistema. Você pode acompanhar guias de instalação acessando as páginas de documentação:

- [Docker](https://docs.docker.com/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Introdução

A utilização de container **Docker** para instalação do sistema é interessante pois permite isolamento dos recursos necessários para o **Map-OS** do sistema operacional raiz do seu servidor, com opções práticas para fácil backup, gerenciamento e manutenção.

Os arquivos relacionados à instalação via **Docker** são:

```structure
mapos
├── Dockerfile
├── docker/
│   ├── data/
│   │   ├── mapos/
│   │   └── mysql/
│   ├── env/
│   │   └── example.env
│   ├── etc/
│   │   ├── composer/
│   │   ├── nginx/
│   │   ├── php/
│   │   └── supervisor/
│   ├── compose.yml
│   └── compose-legacy.yml
└── [...]
```

Esta estrutura está, sobretudo, organizada para poder validar ambos os métodos de instalação via **Docker**, legado e revisado. Este guia orienta o usuário no método `revisado`.

## Instalação (revisado)

Para iniciar sua instalação no **Docker**, certifique-se de que o sistema esteja instalado e ativo no seu servidor, você pode, por meio do terminal, utilizar o seguinte comando para averiguar a disponibilidade:

```sh
docker ps
```

A resposta deverá ser uma lista dos containers ativos, ou nula (caso você não teha nenhum outro recurso sendo executado via Docker ainda).

### Download do Projeto

Para iniciar a instalação, no seu terminal, acesso o caminho de onde de onde deseja armazenar os arquivos do **Map-OS** e baixe o repositório do projeto por meio do [link da última versão](https://api.github.com/repos/RamonSilva20/mapos/releases/latest).

No caso de instalação em ambiente **Linux**, você pode utilizar os comandos a seguir para fazer o download dos recursos necessários diretamente pelo terminal:

```sh
# Instala o ZIP para descompactar arquivos
apt install zip -y

# Busca a release masi recente do Map-OS
wget --quiet --show-progress -O $(pwd)/MapOS.zip $(curl -s https://api.github.com/repos/RamonSilva20/mapos/releases/latest | grep "zipball_url" | awk -F\" '{print $4}')

# Descompacta o arquivo em uma pasta temporária
unzip -q $(pwd)/MapOS.zip -d $(pwd)/mapos-temp/

# Remove o arquivo original baixado
rm $(pwd)/MapOS.zip

# Renomeia o diretório para fácil acesso
mv -i $(pwd)/mapos-temp/RamonSilva20-mapos-* $(pwd)/mapos/

# Remove a pasta temporária
rm -rf $(pwd)/mapos-temp

# Entra no diretório para execução de comandos
cd $(pwd)/mapos
```

### Gerando a imagem do sistema

O **Docker** trabalha com imagens de sistema que são pacotes de versões fácilmente acessíveis e reutilizáveis. Como não há ainda uma release oficial deste sistema no **Docker Hub**, será necessário primeiro gerar a imagem do sistema.

Na pasta raiz onde você está, depois de executar os comandos da seção acima, execute o seguinte comando:

```sh
# 'latest', neste contexto, pode ser substituído pela versão numerada do sistema, que pode ser encontrada no changelog
docker build -t mapos:latest .
```

Este processo levará alguns minutos, a depender da capacidade e recursos do seu servidor. Assim que terminar, prossiga para as próximas etapas da instalação.

### Utilizando o arquivo Compose

O arquivo `compose` do Docker é um recurso de instruções que ajuda a plataforma a identificar as características e requisitos do projeto para criar o container de forma idêntica, independente do sistema operacional ou tipo de dispositivo utilizado. Nele são armazenadas todas as informações relativas as aplicações e relacionamentos para que ele possa funcionar adequadamente.

No diretório onde estão os arquivos que você baixou acesse a pasta `./docker`. Nela há um arquivo chamado `compose.yml`, responsável pela configuração no modo revisado do **Map-OS**.

#### Variáveis de ambiente

O sistema de composição do **Docker** se utiliza de variáveis de ambiente que podem ser configuradas para tratar de diferentes ambientes, independentemente. Assim, você pode ter um conjunto de variáveis em um aqruivo `devlopment.env` que se referem ao seu ambiente de desenvolvimento, enquanto para produção, com os dados do seu servidor em nuvem, se utiliza de um `production.env`.

O arquivo `compose.yml` por padrão espera por um arquivo `.env` que esteja localizado na mesma pasta, assim, como podemos ter diferntes e inúmeras versões de configuração de ambiente, na próxima etapa será necessário apontar qual versão você deseja utilizar.

> [!WARNING]
> Para criar diferentes versões, para cada ambiente que você utiliza, copie o arquivo `./docker/env/example.env` e renomeie-o para representar a sua realidade, mas cuidado para não carregar eles para o **GitHub**. Por padrão, os nomes `production.env` e `development.env` serão automaticamente ignorados em qualquer commit ou PR, use-os sem medo!

#### Executando o arquivo Compose

Para continuar, precisamos acessar o diretório `./docker`, onde o arquivo `composer.yml` está localizado:

```sh
cd docker
```

Dentro do diretório `./docker`, no terminal, execute o seguinte comando, escolhendo qual a sua variável de ambiente a ser utilizada (`production.env` neste exemplo):

```sh
docker compose -f compose.yml --env-file ./env/production.env up -d --force-recreate
```

O terminal agora irá informar você sobre o andamento, o download de todos os arquivos e dependências necessárias, bem como do status da instalação. Quando finalizado, ele apresentará a seguinte mensagem:

```sh
[+] Running 5/5
 ✔ Container mapos-mysql       Running     0.0s
 ✔ Container mapos-php-fpm     Running     0.0s
 ✔ Container mapos-composer    Started     1.4s
 ✔ Container mapos-phpmyadmin  Started     1.9s
 ✔ Container mapos-nginx       Started     0.2s
 ```

Isso significa que todos os serviços foram iniciados corretamente.

### Primeiro acesso e configuração

Uma vez que os serviços estão rodando no **Docker**, será necessário fazer a cofniguração inicial do seu ambiente. O primeiro acesso deverá ser feito sem SSL, então se o seu ambiente já possui configuração de redirecionamento automático (VPS com auto redirecionamento de `http` para `https`, por exemplo) será necessário abrir uma exceção para esta configuração inicial.

Acesse o endereço da aplicação onde ela estiver hospedada:

- **Ambiente local**: `http://localhost:{porta}`. Se a porta escolhida para a variável `MAPOS_PORT` foi a `80`, não é necessário informar porta.
- **VPS ou Nuvem**: será o apontamento do endereço do domínio configurado, ou ip do servidor, com a porta. Ex: `http://seuominio.com.br:{8090}` ou `http://200.100.70.102`

Neste primeiro acesso, siga o passo a passo de configuração conforme informado em tela, preenchendo os dados solicitados de acordo com os dados que você inseriu no seu arquivo de ambiente `*.env`.

### PhpMyAdmin

Esta stack do Docker também conta com uma instalação do **PhpMyAdmin**, de forma que você pode navegar pelo banco de dados com uma interface gráfica diretamente pelo navegador. Para isso, acesse `http://localhost:{porta}` em que a `porta` é igual à variável configurada no seu arquivo de ambiente `*.env`.

## Finalização e Cuidados

O seu ambiente está funcional, agora você pode utilizar um proxy reverso como `NGINX` ou `Traefik` para configurar o seu ambiente com o domínio e recursos de `SSL`.

Certifique-se de garantir segurança à pasta `./docker/data/mysql` pois este é o local onde está armazenado o seu banco de dados. Caso esta pasta seja removida, você perderá todos os registros do seu sistema.

> [!WARNING]
> Faça backups regulares da pasta `./docker/data/mysql` para garantir que seu banco de dados esteja seguro!

---

> [!CAUTION]
> Este guia trata de um formato de instalação descontinuado. Certifique-se de utilizar o [formato revisado](./install_docker.md) para novas instalações.
