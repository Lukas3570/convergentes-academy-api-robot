*** Settings ***
Resource  ../../resources/user.resource
Resource    ../../resources/login.resource
Resource    ../../resources/department.resource

*** Test Cases ***
Funcional: Deletar os dados do usuário
  Criar sessão autorizada
  Deletar os dados do usuário