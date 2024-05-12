*** Settings ***
Resource  ../../resources/department.resource
Resource    ../../resources/login.resource

*** Test Cases ***
Funcional: cadastrar um departamento com sucesso
  Criar sessão autorizada
  Cadastrar um departamento


Não Funcional:Campo Departamento com caracteres especiais não permitidos
  Criar sessão autorizada
  Campo Departamento com caracteres especiais não permitidos
Não Funcional:Campo Departamento vazio
  Criar sessão autorizada
  Campo Departamento vazio