# docker-postgres-example

Exemplo simples e didático de como subir um banco de dados PostgreSQL com Docker Compose, incluindo scripts de criação e popularização automática do banco.
O uso do pgAdmin (interface web) via Docker é **opcional**: você pode acessar o banco também por qualquer client PostgreSQL instalado localmente.

## **Pré-requisitos**

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) instalado
  (Funciona em Windows, macOS e Linux)

## **Instalando o Docker Desktop**

1. **Baixe e instale** o Docker Desktop para seu sistema operacional:
   [https://www.docker.com/products/docker-desktop/](https://www.docker.com/products/docker-desktop/)

2. **Reinicie seu computador** se solicitado.

3. **Verifique a instalação** abrindo um terminal e digitando:
   ```
   docker --version
   docker compose version
   ```

## **Como este projeto funciona**

- Ao subir o ambiente pela primeira vez, o Docker Compose irá criar um volume nomeado para persistência dos dados do PostgreSQL.
- Os scripts localizados na pasta `init-scripts` (`01_init.sql`, `02_seed.sql` etc.) são **executados automaticamente** apenas quando este volume está **vazio** (ou seja, quando o banco está sendo criado do zero).
- Isso garante que a estrutura das tabelas e os dados de exemplo sejam criados automaticamente na primeira inicialização.

## **Passo a passo para usar o projeto**

### **1. Clone o repositório**

```bash
git clone https://github.com/andreick/docker-postgres-example.git
cd docker-postgres-example
```

### **2. Suba o ambiente**

```bash
docker compose up -d
```

- Isso irá baixar as imagens, criar o banco e executar os scripts de inicialização **se o banco for novo**.

## **Acesso ao banco de dados**

Você pode acessar o PostgreSQL de diferentes maneiras:

### **1. Usando o pgAdmin via Docker (opcional)**
- **pgAdmin:**
  - URL: [http://localhost:5050](http://localhost:5050)
  - E-mail: `pgadmin@postgres.com`
  - Senha: `pgadminpw`
- O uso do pgAdmin por Docker é **opcional**. Ele serve apenas como interface web para facilitar a administração e visualização dos dados do PostgreSQL.

### **2. Usando um client PostgreSQL local**
- Você pode instalar o [psql](https://www.postgresql.org/download/) (cliente de linha de comando oficial do PostgreSQL) ou outro client gráfico (DBeaver, Beekeeper Studio, TablePlus, DataGrip, etc) na sua máquina.
- Para acessar via linha de comando:
  ```bash
  psql -h localhost -U postgres -d postgres
  ```
  (A senha é `postgrespw`)

- Sinta-se à vontade para remover o serviço `pgadmin` do `docker-compose.yml` se preferir trabalhar apenas com o client local.

## **Executando scripts de inicialização novamente (\"resetando\" o banco)**

Se você deseja executar novamente os scripts de inicialização (`init-scripts`), você precisa **resetar** o banco de dados, ou seja, remover o volume de dados do Postgres para que ele seja recriado do zero.
**Atenção:** Isso apagará todos os dados existentes no banco!

### **Como resetar o banco de dados:**

1. **Pare e remova somente o container do Postgres:**
   ```bash
   docker compose stop postgres
   docker compose rm -f postgres
   ```

2. **Remova o volume de dados do Postgres:**
   ```bash
   docker volume rm docker-postgres-example_postgres_data
   ```
   > Substitua `docker-postgres-example_postgres_data` pelo nome real do seu volume, se estiver diferente (veja com `docker volume ls`).

3. **Suba novamente o Postgres (ou todos os serviços):**
   ```bash
   docker compose up -d postgres
   ```
   ou
   ```bash
   docker compose up -d
   ```

- **Resultado:**
  O banco de dados será recriado do zero e todos os scripts na pasta `init-scripts` serão executados novamente automaticamente.

## **Executando scripts SQL manualmente em um container já existente**

Se você modificar ou adicionar scripts SQL na pasta `init-scripts` **após o banco já ter sido criado**, eles **NÃO serão executados automaticamente** (a menos que você resete o banco conforme explicado acima).

Para rodar um script manualmente:

1. **Copie o script para dentro do container (se necessário):**
   ```bash
   docker cp init-scripts/02_seed.sql postgres:/tmp/02_seed.sql
   ```
2. **Execute o script dentro do container:**
   ```bash
   docker exec -i postgres psql -U postgres -d postgres -f /tmp/02_seed.sql
   ```
   - Substitua pelo nome do seu script, usuário ou banco, se necessário.

3. **Ou, execute diretamente a partir do host:**
   ```bash
   docker exec -i postgres psql -U postgres -d postgres < init-scripts/02_seed.sql
   ```

4. **(Opcional) Use o pgAdmin:**
   - Acesse [http://localhost:5050](http://localhost:5050), conecte no banco e cole o conteúdo do script na ferramenta de query.

## **Estrutura do projeto**

```
.
├── docker-compose.yml
├── init-scripts/
│   ├── 01_init.sql     # Criação das tabelas
│   └── 02_seed.sql     # Dados de exemplo (seeds)
└── README.md
```

## **Dúvidas comuns**

- **Os scripts SQL do `init-scripts` só rodam automaticamente se o banco for novo (volume vazio).**
- **Para rodar os scripts novamente, é preciso resetar o banco, ou seja, remover o volume do Postgres.**
- **O volume do banco NÃO fica acessível como pasta local (usa volume nomeado do Docker).**
