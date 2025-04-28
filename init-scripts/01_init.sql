-- Criação do banco de dados (caso não exista)
-- O container do Postgres já cria o database definido pela variável POSTGRES_DB, então geralmente não é necessário criar aqui.
-- CREATE DATABASE aplicacao_fundos;

-- Conectar no banco (não é necessário no contexto do entrypoint do Docker)

-- Tabelas principais

-- 1. Tabela de Fundos
CREATE TABLE IF NOT EXISTS fundos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cnpj VARCHAR(18),
    data_criacao DATE,
    gestor VARCHAR(100),
    tipo VARCHAR(50)
);

-- 2. Tabela de Cotistas
CREATE TABLE IF NOT EXISTS cotistas (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    documento VARCHAR(20),
    data_entrada DATE
);

-- 3. Tabela de Carteiras
CREATE TABLE IF NOT EXISTS carteiras (
    id SERIAL PRIMARY KEY,
    fundo_id INT NOT NULL REFERENCES fundos(id),
    nome VARCHAR(100) NOT NULL,
    data_referencia DATE NOT NULL
);

-- 4. Tabela de Boletas (operações)
CREATE TABLE IF NOT EXISTS boletas (
    id SERIAL PRIMARY KEY,
    carteira_id INT NOT NULL REFERENCES carteiras(id),
    tipo VARCHAR(20) NOT NULL, -- compra/venda/aporte/resgate
    ativo VARCHAR(50),
    quantidade NUMERIC(20,6),
    valor_unitario NUMERIC(20,6),
    data_operacao DATE NOT NULL
);

-- 5. Tabela de Cotas (movimentação)
CREATE TABLE IF NOT EXISTS cotas (
    id SERIAL PRIMARY KEY,
    fundo_id INT NOT NULL REFERENCES fundos(id),
    cotista_id INT NOT NULL REFERENCES cotistas(id),
    data DATE NOT NULL,
    quantidade NUMERIC(20,6) NOT NULL,
    valor_cota NUMERIC(20,6) NOT NULL
);

-- 6. Tabela de Benchmarks
CREATE TABLE IF NOT EXISTS benchmarks (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    codigo VARCHAR(20) NOT NULL
);

-- 7. Performance diária
CREATE TABLE IF NOT EXISTS performance_diaria (
    id SERIAL PRIMARY KEY,
    fundo_id INT NOT NULL REFERENCES fundos(id),
    data DATE NOT NULL,
    valor_cota NUMERIC(20,6) NOT NULL,
    rentabilidade_diaria NUMERIC(10,6),
    benchmark_id INT REFERENCES benchmarks(id),
    rentabilidade_benchmark NUMERIC(10,6)
);

-- 8. Tabela para input dos prestadores
CREATE TABLE IF NOT EXISTS prestadores_inputs (
    id SERIAL PRIMARY KEY,
    fundo_id INT REFERENCES fundos(id),
    nome_prestador VARCHAR(100),
    tipo_servico VARCHAR(50),
    valor NUMERIC(20,2),
    data_referencia DATE
);

-- 9. Relatórios exportados
CREATE TABLE IF NOT EXISTS relatorios (
    id SERIAL PRIMARY KEY,
    fundo_id INT NOT NULL REFERENCES fundos(id),
    tipo VARCHAR(50) NOT NULL, -- ex: PDF, HTML
    periodo_inicio DATE,
    periodo_fim DATE,
    data_exportacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    caminho_arquivo TEXT -- local onde o arquivo foi salvo
);

-- 10. Insights
CREATE TABLE IF NOT EXISTS insights (
    id SERIAL PRIMARY KEY,
    fundo_id INT NOT NULL REFERENCES fundos(id),
    data DATE NOT NULL,
    descricao TEXT
);

-- Índices para performance
CREATE INDEX IF NOT EXISTS idx_boletas_carteira_data ON boletas(carteira_id, data_operacao);
CREATE INDEX IF NOT EXISTS idx_performance_fundo_data ON performance_diaria(fundo_id, data);