## AZURE DATABASE
# Configurando uma Instância de Banco de Dados na Azure

Este projeto tem o intuito de ensinar a configurar uma instância de Banco de Dados na Azure tanto pela interface gráfica (Azure Portal) quanto utilizando Terraform. O exemplo aqui é baseado na configuração de uma instância do **Azure Database for PostgreSQL**.

# Estrutura do Projeto
```
AzureDatabase/
│
├──Infra/
│    └── main.tf
│    └── secrets.tfvars
└── README.md
```

## Configurando a Instância pelo Azure Portal

### Passo 1: Criar um Banco de Dados PostgreSQL

1. Acesse o **Azure Portal** https://portal.azure.com/.
2. No menu esquerdo, clique em **Create a resource**.
3. Na barra de pesquisa, digite **Azure Database for PostgreSQL** e selecione a opção correspondente.
4. Clique em **Create**.
5. Preencha os seguintes campos:
   - **Subscription**: Escolha a sua assinatura.
   - **Resource Group**: Selecione ou crie um novo grupo de recursos.
   - **Server Name**: Defina o nome do seu servidor PostgreSQL.
   - **Data Source**: Escolha **None** (para uma nova instância).
   - **Version**: Escolha a versão do PostgreSQL (ex.: 11).
   - **Compute + Storage**: Defina o SKU (como `GP_Gen5_2` para General Purpose) e o tamanho do disco.
   - **Administrator Login**: Crie o login do administrador.
   - **Password**: Defina uma senha segura.
6. No menu de **Networking**, escolha se deseja habilitar o acesso público (internet) ou apenas rede privada.
7. Em **Additional settings**, escolha o charset e a collation, se necessário.
8. Clique em **Review + create** e depois em **Create**.

### Passo 2: Acessando o Banco de Dados

1. Após a criação da instância, vá para **All resources** e selecione o seu servidor PostgreSQL.
2. Para acessar o banco de dados, use ferramentas como o [Azure Data Studio](https://docs.microsoft.com/pt-br/sql/azure-data-studio) ou o cliente PostgreSQL (`psql`) configurando o endereço IP e a senha de administrador.


## Configurando via Terraform

Se você preferir automatizar o processo via Terraform, aqui está um exemplo básico de como definir a instância de Banco de Dados PostgreSQL.

### Requisitos necessários:

Para criar devidamente sua VM, certifique-se de:
1. Instalar o **Terraform** na sua máquina local.
2. Configurar a **Azure CLI** para autenticação.

### Instalação da Azure CLI

Caso não tenha instalado a Azure CLI, utilize o seguinte comando:

**Para rodar no Windows:**
```bash
winget install Microsoft.AzureCLI
```

**Para rodar no Linux:**
```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

**Para rodar no MacOS:**
```bash
brew update && brew install azure-cli
```

Em seguida faça o login na Azure utilizando:

```bash
az login
```
Após executar `az login`, uma janela será aberta na Azure onde você deverá inserir suas credenciais. Caso você esteja usando o terminal, será solicitado que você insira um código para autenticação.

### Criação e execução do Terraform
Após a autenticação realizada anteriormente realize os seguintes passos:
1. Criar um arquivo `main.tf` (como este presente na pasta `infra`).
2. Iniciar o Terraform
3. Planejar a infra (gera um plano de execução, afim de verificar o que será criado)
4. Aplicar a configuração (neste passo, criará o banco de dados utilizando as variáveis de credenciais, visando a segurança)

### Inicializar o Terraform
```bash
terraform init
```

### Planejar a infra
```bash
terraform plan
```

### Aplicar a configuração
```bash
terraform apply -var-file="secrets.tfvars"
```

## Observação
Não estarei utilizando o .gitignore neste repositório justamente por não estar utilizando alguma credencial válida, logo não há riscos. Quando utilizar no seu projeto use o .gitignore, desta forma as informações sensíveis não terão acesso público, ou seja, **Não deve ser incluído de forma alguma no controle de versão**.