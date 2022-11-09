
CREATE TABLE public.cargos (
                id_cargo VARCHAR(10) NOT NULL,
                cargo VARCHAR(35) NOT NULL,
                salario_minimo NUMERIC(8,2),
                salario_maximo NUMERIC(8,2),
                CONSTRAINT cargos PRIMARY KEY (id_cargo)
);


CREATE UNIQUE INDEX cargos_idx
 ON public.cargos
 ( cargo );

CREATE SEQUENCE public.regioes_nome_seq_1;

CREATE TABLE public.regioes (
                nome INTEGER NOT NULL,
                nome_1 VARCHAR(25) NOT NULL DEFAULT nextval('public.regioes_nome_seq_1'),
                CONSTRAINT regioes PRIMARY KEY (nome)
);


ALTER SEQUENCE public.regioes_nome_seq_1 OWNED BY public.regioes.nome_1;

CREATE UNIQUE INDEX regioes_idx
 ON public.regioes
 ( nome_1 );

CREATE SEQUENCE public.paises_nome_seq;

CREATE TABLE public.paises (
                id_pais INTEGER NOT NULL,
                nome VARCHAR(50) NOT NULL DEFAULT nextval('public.paises_nome_seq'),
                nome_1 INTEGER NOT NULL,
                CONSTRAINT paises PRIMARY KEY (id_pais)
);


ALTER SEQUENCE public.paises_nome_seq OWNED BY public.paises.nome;

CREATE UNIQUE INDEX paises_idx
 ON public.paises
 ( nome );

CREATE TABLE public.localizacoes (
                nome INTEGER NOT NULL,
                endereco VARCHAR(50),
                cep VARCHAR(12),
                cidade VARCHAR(50),
                uf VARCHAR(25),
                id_pais INTEGER NOT NULL,
                CONSTRAINT localizacoes PRIMARY KEY (nome)
);


CREATE TABLE public.departamento (
                id_departamento INTEGER NOT NULL,
                nome INTEGER NOT NULL,
                nome_1 VARCHAR(50),
                nome_2 INTEGER NOT NULL,
                CONSTRAINT departamento PRIMARY KEY (id_departamento)
);


CREATE UNIQUE INDEX departamento_idx
 ON public.departamento
 ( nome_1 );

CREATE TABLE public.empregados (
                nome INTEGER NOT NULL,
                id_departamento INTEGER NOT NULL,
                nome_1 VARCHAR(75) NOT NULL,
                nome_2 VARCHAR(35) NOT NULL,
                nome_3 VARCHAR(20),
                nome_4 DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                salario NUMERIC(8,2),
                comissao NUMERIC(4,2),
                nome_5 INTEGER NOT NULL,
                CONSTRAINT empregados PRIMARY KEY (nome)
);


CREATE UNIQUE INDEX empregados_idx
 ON public.empregados
 ( nome_2 );

CREATE TABLE public.historico_cargos (
                nome INTEGER NOT NULL,
                data_incial DATE NOT NULL,
                data_final DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                id_departamento INTEGER NOT NULL,
                CONSTRAINT historico_cargos PRIMARY KEY (nome, data_incial)
);


ALTER TABLE public.empregados ADD CONSTRAINT cargos_empregados_fk
FOREIGN KEY (id_cargo)
REFERENCES public.cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.historico_cargos ADD CONSTRAINT cargos_historico_cargos_fk
FOREIGN KEY (id_cargo)
REFERENCES public.cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.paises ADD CONSTRAINT regioes_paises_fk
FOREIGN KEY (nome_1)
REFERENCES public.regioes (nome)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.localizacoes ADD CONSTRAINT paises_localizacoes_fk
FOREIGN KEY (id_pais)
REFERENCES public.paises (id_pais)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.departamento ADD CONSTRAINT localizacoes_departamento_fk
FOREIGN KEY (nome_2)
REFERENCES public.localizacoes (nome)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.historico_cargos ADD CONSTRAINT departamento_historico_cargos_fk
FOREIGN KEY (id_departamento)
REFERENCES public.departamento (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.empregados ADD CONSTRAINT departamento_empregados_fk
FOREIGN KEY (id_departamento)
REFERENCES public.departamento (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.historico_cargos ADD CONSTRAINT empregados_historico_cargos_fk
FOREIGN KEY (nome)
REFERENCES public.empregados (nome)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.empregados ADD CONSTRAINT empregados_empregados_fk
FOREIGN KEY (nome_5)
REFERENCES public.empregados (nome)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.departamento ADD CONSTRAINT empregados_departamento_fk
FOREIGN KEY (nome)
REFERENCES public.empregados (nome)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
