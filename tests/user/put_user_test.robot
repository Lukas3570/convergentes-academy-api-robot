*** Settings ***
Resource  ../../resources/user.resource
Resource    ../../resources/login.resource
Resource    ../../resources/department.resource

*** Test Cases ***
Funcional: Atualizar os dados do usuário
  Atualizar os dados do usuário
Funcional: Atualizar senha de usuário
  Atualizar senha de usuário
Funcional: Inativar status de usuário
  Criar sessão autorizada
  Inativar status de usuário
Funcional: Ativar status de usuário
  Criar sessão autorizada
  Ativar status de usuário

Não Funcional: Atualizar dados com campo vazio
  Atualizar dados com campo vazio
Não Funcional: Atualizar dados com campo incorreto
  Atualizar dados com campo incorreto
Não Funcional: Atualizar senha com campo vazio
  Atualizar senha com campo vazio
Não Funcional: Atualizar senha com campo fora da regra de negócio
  Atualizar senha com campo fora da regra de negócio