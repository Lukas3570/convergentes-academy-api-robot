*** Settings ***
Resource  ../../resources/user.resource
Resource    ../../resources/login.resource
Resource    ../../resources/department.resource

*** Test Cases ***
Funcional: Listar usuários
  Criar sessão autorizada
  Listar usuários

Funcional: Pesquisar usuário por id
  Criar sessão autorizada
  Pesquisar usuário por id

Pesquisar por id inválido
  Criar sessão autorizada
  Pesquisar por id inválido