*** Settings ***
Resource  ../../resources/diretoria.resource
Resource    ../../resources/login.resource

*** Test Cases ***
Funcional: Listar uma Diretoria 
  Criar sessão autorizada
  Listar diretorias
Funcional: Mostrar Diretoria por id
  Criar sessão autorizada
  Mostrar diretoria por id

Não Funcional: pesquisar Diretoria por id inválido 
  Criar sessão autorizada
  pesquisar Diretoria por id inválido