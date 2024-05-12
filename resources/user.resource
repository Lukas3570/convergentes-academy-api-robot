*** Settings ***
Documentation  O objetivo deste arquivo é armazenar todos os recursos para os testes
Library  RequestsLibrary
Library  String
Library  Collections
Resource    login.resource

*** Keywords ***
Criar um novo usuário
  ${palavra_randomica}  Generate Random String  length=8  chars=[LETTERS]
  ${palavra_randomica}  Convert To Lower Case   ${palavra_randomica}
  ${50c_name}  Generate Random String  length=50  chars=[LETTERS]
  ${50c_name}  Convert To Lower Case   ${50c_name}
  ${cpf_randomico}  Generate Random String  length=11  chars=[NUMBERS]
  Set Test Variable     ${CPF_RAMDOMICO}          ${cpf_randomico}
  Set Test Variable     ${EMAIL_TEST}             ${palavra_randomica}@qacoders.com.br
  Set Test Variable     ${BAD_EMAIL_TEST}         ${palavra_randomica}qacoders.com.br
  Set Test Variable     ${USER_NAME}              L${palavra_randomica} T${palavra_randomica}
  Set Test Variable     ${USER_NAME_100C}         L${50c_name} T${50c_name}
  Set Test Variable     ${PUT_PASSWORD}           L@3${palavra_randomica}
  Set Test Variable     ${BAD_PASSWORD}           ${palavra_randomica}


##--Post--##
##__Funcional__##
Cadastrar um novo usuário
  Criar um novo usuário
  ${body}  Create Dictionary  fullName=Teste Lucas Emanuel  mail=${EMAIL_TEST}  
  ...  password=1234@Test   accessProfile=ADMIN  cpf=${CPF_RAMDOMICO}  confirmPassword=1234@Test
  Log  ${body}
  ${resposta}  POST On Session  alias=APIConvergentes  url=/api/user  json=${body}
  Log  ${resposta.json()}
  Set Test Variable    ${ID_USUARIO}  ${resposta.json()["user"]["_id"]}
  Set Test Variable    ${FULLNAME}  ${resposta.json()["user"]["fullName"]}
  Set Test Variable    ${RESPOSTA}  ${resposta.json()}
  Dictionary Should Contain Item    ${RESPOSTA}    msg    Olá ${FULLNAME}, cadastro realizado com sucesso.

##__Não Funcional__##
Cadastro com campos vazios
  ${body}  Create Dictionary  fullName=  mail=
  ...  password=   accessProfile=  cpf=  confirmPassword=
  Log  ${body}
  Run Keyword And Expect Error  HTTPError: 400*  POST On Session  alias=APIConvergentes  url=/api/user  json=${body}
Cadastro com campo NOME com mais de 100 caracteres
  Criar um novo usuário
  ${body}  Create Dictionary  fullName=${USER_NAME_100C}  mail=${EMAIL_TEST}  
  ...  password=1234@Test   accessProfile=ADMIN  cpf=${CPF_RAMDOMICO}  confirmPassword=1234@Test
  Log  ${body}
  Run Keyword And Expect Error  HTTPError: 400*  POST On Session  alias=APIConvergentes  url=/api/user  json=${body}
Cadastro com email inválido
  Criar um novo usuário
  ${body}  Create Dictionary  fullName=${USER_NAME}  mail=${BAD_EMAIL_TEST}  
  ...  password=1234@Test   accessProfile=ADMIN  cpf=${CPF_RAMDOMICO}  confirmPassword=1234@Test
  Log  ${body}
  Run Keyword And Expect Error  HTTPError: 400*  POST On Session  alias=APIConvergentes  url=/api/user  json=${body}
Cadastro com senha fora da regra de negócio
  Criar um novo usuário
  ${body}  Create Dictionary  fullName=Teste Lucas Emanuel  mail=${EMAIL_TEST}  
  ...  password=1234Test   accessProfile=ADMIN  cpf=${CPF_RAMDOMICO}  confirmPassword=1234Test
  Log  ${body}
  Run Keyword And Expect Error  HTTPError: 400*  POST On Session  alias=APIConvergentes  url=/api/user  json=${body}
Cadastro com CONFIRMAR SENHA incongruente
  Criar um novo usuário
  ${body}  Create Dictionary  fullName=Teste Lucas Emanuel  mail=${EMAIL_TEST}  
  ...  password=1234@Test   accessProfile=ADMIN  cpf=${CPF_RAMDOMICO}  confirmPassword=1234@Tests
  Log  ${body}
  Run Keyword And Expect Error  HTTPError: 400*  POST On Session  alias=APIConvergentes  url=/api/user  json=${body}

##--Put--##
##__Funcional__##
Atualizar os dados do usuário
  Login com usuário cadastrado
  Criar um novo usuário
  ${body}  Create Dictionary  fullName=${USER_NAME}  mail=${EMAIL_TEST}  
  ${resposta}  PUT On Session  alias=APIConvergentes  url=/api/user/${ID_USUARIO_LOGADO}  json=${body}
  Log  ${resposta.json()}
  Dictionary Should Contain Item    ${resposta.json()}    msg    Dados atualizados com sucesso!
Atualizar senha de usuário
  Login com usuário cadastrado
  Criar um novo usuário
  ${body}  Create Dictionary  password=${PUT_PASSWORD}  confirmPassword=${PUT_PASSWORD}  
  ${resposta}  PUT On Session  alias=APIConvergentes  url=/api/user/password/${ID_USUARIO_LOGADO}  json=${body}
  Log  ${resposta.json()}
  Dictionary Should Contain Item    ${resposta.json()}    msg    Senha atualizada com sucesso!
Inativar status de usuário
  Cadastrar um novo usuário
  ${body}  Create Dictionary  status=false 
  ${resposta}  Put On Session  alias=APIConvergentes  url=/api/user/status/${ID_USUARIO}  json=${body}
  Log    ${resposta.json()}
  Dictionary Should Contain Item    ${resposta.json()}    msg    Status do usuario atualizado com sucesso para status false.
Ativar status de usuário
  Inativar status de usuário
  ${body}  Create Dictionary  status=true 
  ${resposta}  Put On Session  alias=APIConvergentes  url=/api/user/status/${ID_USUARIO}  json=${body}
  Log    ${resposta.json()}
  Dictionary Should Contain Item    ${resposta.json()}    msg    Status do usuario atualizado com sucesso para status true.

##__Não Funcional__##
Atualizar dados com campo vazio
  Login com usuário cadastrado
  Criar um novo usuário
  ${body}  Create Dictionary  fullName=  mail=  
  Run Keyword And Expect Error  HTTPError: 400*  PUT On Session  alias=APIConvergentes  url=/api/user/${ID_USUARIO_LOGADO}  json=${body}
Atualizar dados com campo incorreto
  Login com usuário cadastrado
  Criar um novo usuário
  ${body}  Create Dictionary  fullName=Teste  mail=${BAD_EMAIL_TEST}  
  Run Keyword And Expect Error  HTTPError: 400*  PUT On Session  alias=APIConvergentes  url=/api/user/${ID_USUARIO_LOGADO}  json=${body}
Atualizar senha com campo vazio
  Login com usuário cadastrado
  Criar um novo usuário
  ${body}  Create Dictionary  password=  confirmPassword=
  Run Keyword And Expect Error  HTTPError: 400*  PUT On Session  alias=APIConvergentes  url=/api/user/password/${ID_USUARIO_LOGADO}  json=${body}
Atualizar senha com campo fora da regra de negócio
  Login com usuário cadastrado
  Criar um novo usuário
  ${body}  Create Dictionary  password=${BAD_PASSWORD}  confirmPassword=${BAD_PASSWORD}
  Run Keyword And Expect Error  HTTPError: 400*  PUT On Session  alias=APIConvergentes  url=/api/user/password/${ID_USUARIO_LOGADO}  json=${body}


##--Get--##
##__Funcional__##
Listar usuários
  ${resposta}  GET On Session  alias=APIConvergentes   url=/api/user/   
  Log  ${resposta.json()}
  Should Be Equal As Integers    ${resposta.status_code}    200
Pesquisar usuário por id
  Cadastrar um novo usuário
  ${resposta}  GET On Session  alias=APIConvergentes   url=/api/user/${ID_USUARIO}   
  Log  ${resposta.json()}
  Set Test Variable    ${id_user}    ${resposta.json()}[_id]
  Should Be Equal As Strings    ${id_user}    ${ID_USUARIO}
  Should Be Equal As Integers    ${resposta.status_code}    200

Pesquisar por id inválido
  ${resposta}  Run Keyword And Expect Error  HTTPError: 500*  GET On Session  alias=APIConvergentes   url=/api/user/661049f7ab172fbe&1010de6f  


##--Delete--##
##__Funcional__##
Deletar os dados do usuário
  Cadastrar um novo usuário
  ${resposta}  Delete On Session  alias=APIConvergentes  url=/api/user/${ID_USUARIO}
  Log    ${resposta.json()}
  Dictionary Should Contain Item    ${resposta.json()}    msg    Usuário deletado com sucesso!.