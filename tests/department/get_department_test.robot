*** Settings ***
Resource  ../../resources/department.resource
Resource    ../../resources/login.resource

*** Test Cases ***
Funcional: Listar departamento
  Criar sessão autorizada
  Listar departamentos
Funcional: pesquisar departamento por Id
  Criar sessão autorizada
  Pesquisar departamento por Id


Não funcional: pesquisar departamento por Id inválido
  Criar sessão autorizada
  Pesquisar departamento por Id inválido            