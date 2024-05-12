*** Settings ***
Resource  ../../resources/user.resource
Resource    ../../resources/login.resource

*** Test Cases ***
Funcional: Cadastrar um novo usuário com sucesso
  Criar sessão autorizada
  Cadastrar um novo usuário

Não funcional: Cadastro com campos vazios
  Criar sessão autorizada
  Cadastro com campos vazios
Não funcional: Cadastro com campo NOME com mais de 100 caracteres
  Criar sessão autorizada
  Cadastro com campo NOME com mais de 100 caracteres
Não funcional: Cadastro com email inválido
  Criar sessão autorizada
  Cadastro com email inválido
Não funcional: Cadastro com senha fora da regra de negócio
  Criar sessão autorizada
  Cadastro com senha fora da regra de negócio
Não funcional: Cadastro com CONFIRMAR SENHA incongruente
  Criar sessão autorizada
  Cadastro com CONFIRMAR SENHA incongruente