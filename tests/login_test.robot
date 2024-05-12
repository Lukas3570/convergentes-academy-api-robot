*** Settings ***
Resource  ../resources/login.resource

*** Variables ***

*** Test Cases ***
Funcional: Logar usuário sysadmin
  Login com usuário sysadmin
  Validar o token e gravar em um header de autorização
Funcional: Login com usuário cadastrado
  Login com usuário cadastrado

Não funcional: Login com campos vazios
  Login com campos vazios
Não funcional: Login com campos incorretos
  Login com campos incorretos
