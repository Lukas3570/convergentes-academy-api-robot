*** Settings ***
Resource  ../../resources/diretoria.resource
Resource    ../../resources/login.resource

*** Test Cases ***
Funcional: Cadastrar uma Diretoria 
  Criar sessão autorizada
  Criar diretoria


Não Funcional: Diretoria com mais de 50 caracteres
  Criar sessão autorizada
  Diretoria com mais de 50 caracteres
Não Funcional: Diretoria já cadastrada no sistema
  Criar sessão autorizada
  Diretoria já cadastrada no sistema
Não Funcional: Diretoria com caractere não permitido
  Criar sessão autorizada
  Diretoria com caractere não permitido