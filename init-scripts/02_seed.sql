-- Fundos
INSERT INTO fundos (nome, cnpj, data_criacao, gestor, tipo) VALUES
  ('Fundo Alpha', '12.345.678/0001-90', '2023-01-01', 'Gestora X', 'FIA'),
  ('Fundo Beta', '98.765.432/0001-09', '2023-03-15', 'Gestora Y', 'FIM'),
  ('Fundo Gama', '11.222.333/0001-55', '2022-10-10', 'Gestora Z', 'FII');

-- Cotistas
INSERT INTO cotistas (nome, documento, data_entrada) VALUES
  ('João da Silva', '111.222.333-44', '2023-02-01'),
  ('Maria Souza', '555.666.777-88', '2023-03-20'),
  ('Carlos Pereira', '999.888.777-66', '2023-04-10'),
  ('Ana Bastos', '222.333.444-55', '2023-05-05');

-- Carteiras
INSERT INTO carteiras (fundo_id, nome, data_referencia) VALUES
  (1, 'Carteira Principal Alpha', '2023-06-01'),
  (2, 'Carteira Principal Beta', '2023-06-01'),
  (3, 'Carteira FII Gama', '2023-06-01'),
  (1, 'Carteira Renda Fixa Alpha', '2023-06-15');

-- Boletas
INSERT INTO boletas (carteira_id, tipo, ativo, quantidade, valor_unitario, data_operacao) VALUES
  (1, 'compra', 'PETR4', 1000, 26.50, '2023-06-05'),
  (1, 'compra', 'VALE3', 500, 66.00, '2023-06-10'),
  (1, 'venda',  'PETR4', 200, 27.00, '2023-06-15'),
  (2, 'compra', 'BBAS3', 700, 32.00, '2023-06-08'),
  (3, 'compra', 'HGLG11', 100, 160.00, '2023-06-12'),
  (4, 'compra', 'TESOURO SELIC', 1200, 1.05, '2023-06-20'),
  (2, 'venda', 'BBAS3', 200, 33.50, '2023-06-15');

-- Cotas
INSERT INTO cotas (fundo_id, cotista_id, data, quantidade, valor_cota) VALUES
  (1, 1, '2023-06-01', 1000, 1.0000),
  (1, 2, '2023-06-01', 500, 1.0000),
  (2, 1, '2023-06-01', 800, 1.0000),
  (2, 3, '2023-06-01', 200, 1.0000),
  (3, 4, '2023-06-01', 400, 1.0000),
  (3, 2, '2023-06-01', 200, 1.0000),
  (1, 3, '2023-06-10', 300, 1.0200);

-- Benchmarks
INSERT INTO benchmarks (nome, codigo) VALUES
  ('CDI', 'CDI'),
  ('IBOV', 'IBOV'),
  ('IFIX', 'IFIX');

-- Performance diária
INSERT INTO performance_diaria (fundo_id, data, valor_cota, rentabilidade_diaria, benchmark_id, rentabilidade_benchmark) VALUES
  (1, '2023-06-01', 1.0000, 0.000, 1, 0.001),
  (1, '2023-06-02', 1.0025, 0.0025, 1, 0.0012),
  (1, '2023-06-03', 1.0030, 0.0005, 1, 0.0011),
  (2, '2023-06-01', 1.0000, 0.000, 2, 0.0015),
  (2, '2023-06-02', 1.0010, 0.001, 2, 0.0012),
  (3, '2023-06-01', 1.0000, 0.000, 3, 0.0010),
  (3, '2023-06-02', 1.0012, 0.0012, 3, 0.0011);

-- Prestadores Inputs
INSERT INTO prestadores_inputs (fundo_id, nome_prestador, tipo_servico, valor, data_referencia) VALUES
  (1, 'Auditoria Alfa', 'Auditoria', 1500.00, '2023-06-01'),
  (2, 'Custódia Beta', 'Custódia', 1000.00, '2023-06-01'),
  (3, 'Gestora Z', 'Gestão', 2000.00, '2023-06-01'),
  (1, 'Administradora X', 'Administração', 800.00, '2023-06-10');

-- Relatórios
INSERT INTO relatorios (fundo_id, tipo, periodo_inicio, periodo_fim, caminho_arquivo) VALUES
  (1, 'PDF', '2023-06-01', '2023-06-30', '/relatorios/fundo_alpha_junho2023.pdf'),
  (2, 'PDF', '2023-06-01', '2023-06-30', '/relatorios/fundo_beta_junho2023.pdf'),
  (3, 'PDF', '2023-06-01', '2023-06-30', '/relatorios/fundo_gama_junho2023.pdf'),
  (1, 'HTML', '2023-06-01', '2023-06-15', '/relatorios/fundo_alpha_meiojunho2023.html');

-- Insights
INSERT INTO insights (fundo_id, data, descricao) VALUES
  (1, '2023-06-30', 'Rentabilidade acima do benchmark em junho/2023.'),
  (2, '2023-06-30', 'Fundo apresentou oscilação próxima ao IBOV em junho/2023.'),
  (3, '2023-06-30', 'Rentabilidade estável, com baixo drawdown em junho/2023.'),
  (1, '2023-06-15', 'Volume negociado acima da média no meio do mês.');