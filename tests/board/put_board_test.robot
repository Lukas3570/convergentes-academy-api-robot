*** Settings ***
Resource  ../../resources/diretoria.resource
Resource    ../../resources/login.resource

*** Test Cases ***
Funcional: Atualizar uma Diretoria por id
  Criar sessão autorizada
  Criar diretoria
  Atualizar uma Diretoria por id


Não funcional: Atualizar diretoria com caracteres não permitidos
  Criar sessão autorizada
  Atulaizar diretoria com caracteres não permitidos
Não funcional: Atualizar diretoria com campo vazio
  Criar sessão autorizada
  Atulaizar diretoria com campo vazio