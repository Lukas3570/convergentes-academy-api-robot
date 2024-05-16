# Convergentes - API :robot:

Projeto de automação de API com o ```Robot Framework```.

Projeto voluntário supervisionado pela Qa.Coders para Testes de API executado pela equipe Convergentes

## Instalação

*Instalando o Python*

[Python](https://python.org.br/instalacao-windows/)

*Instalando o Pip*

```bash
  pip -m pip install --upgrade pip
  pip -m pip --version
```

*Instalando as tecnologias e libs necessárias do projeto*

[Instalação do Robot](https://robotframework.org/?tab=1#getting-started)

```bash
  pip install robotframework
```

*Demais Libraries para os testes de API*

```bash
  pip install robotframework-requests
```

Para validar todas as instalações

```bash
  pip list
  pip freeze
```

Criar requirements.txt com as

## Stacks utilizada

**Libraries**: Builtin, Collections, String, RequestsLibrary

**Automação:** Robot Framework

<!-- **Shell**: Shell Script -->

## Rodando localmente

Clone o projeto:

```bash
  git clone  https://github.com/Lukas3570/convergentes-academy-api-robot
```

Entre no diretório do projeto

```bash
  cd convergentes-academy-api-robot
```
Para rodar os testes, rode o seguinte comando

```bash
  robot -d ./reports tests
```

## Equipe

- [@lukas3570](https://github.com/Lukas3570)
- [@lidianycosta](https://github.com/lidianycosta)
- [@Elias-roccha](https://github.com/Elias-roccha)
