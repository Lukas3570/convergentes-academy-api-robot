*** Settings ***
Documentation  O objetivo deste arquivo é armazenar todos os recursos para os testes
Library  RequestsLibrary
Library  String
Library  Collections
Resource    user.resource

*** Keywords ***
Criar sessão
  ${headers}  Create Dictionary  accept=application/json  Content-Type=application/json
  Create Session    alias=APIConvergentes  url=https://convergentes.qacoders-academy.com.br  headers=${headers}
  
Login com usuário sysadmin
  ${body}  Create Dictionary  mail=sysadmin@qacoders.com  password=1234@Test
  Log  ${body}
  Criar sessão
  ${resposta}  POST On Session  alias=APIConvergentes  url=/api/login  json=${body}
  Log  ${resposta.json()}
  Set Test Variable    ${TOKEN}    ${resposta.json()["token"]}

Validar o token e gravar em um header de autorização
  ${headers}  Create Dictionary  Authoriation=Bearer ${TOKEN}
  ${resposta}  GET On Session  alias=APIConvergentes  url=/api/ValidateToken  headers=${headers}
  Log  Resposta da solicitação: ${resposta.content}
  Log  ${TOKEN}

Criar sessão autorizada
  Criar sessão
  Login com usuário sysadmin
  ${headers}  Create Dictionary  accept=application/json  Content-Type=application/json  Authorization=${TOKEN}
  Create Session    alias=APIConvergentes  url=https://convergentes.qacoders-academy.com.br  headers=${headers}

Login com usuário cadastrado
  Criar sessão autorizada
  Cadastrar um novo usuário
  ${body}  Create Dictionary  mail=${EMAIL_TEST}  password=1234@Test
  Criar sessão
  ${resposta}  POST On Session  alias=APIConvergentes  url=/api/login  json=${body}
  Log  ${resposta.json()}
  Set Test Variable    ${USER_TOKEN}    ${resposta.json()["token"]}
  Set Test Variable    ${ID_USUARIO_LOGADO}    ${resposta.json()["user"]["_id"]}
  ${headers}  Create Dictionary  accept=application/json  Content-Type=application/json  Authorization=${USER_TOKEN}
  Create Session    alias=APIConvergentes  url=https://convergentes.qacoders-academy.com.br  headers=${headers}

Login com campos vazios
  ${body}  Create Dictionary  mail=  password=
  Log  ${body}
  Criar sessão
  Run Keyword And Expect Error  HTTPError: 400*  POST On Session  alias=APIConvergentes  url=/api/login  json=${body}
Login com campos incorretos
  ${body}  Create Dictionary  mail=testeqacoders.com  password=12345678
  Criar sessão
  Run Keyword And Expect Error  HTTPError: 400*  POST On Session  alias=APIConvergentes  url=/api/login  json=${body}
