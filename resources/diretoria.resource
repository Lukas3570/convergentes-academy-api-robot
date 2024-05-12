*** Settings ***
Documentation  O objetivo deste arquivo é armazenar todos os recursos para os testes
Library  RequestsLibrary
Library  String
Library  Collections

*** Keywords ***
Criar diretoria
  ${palavra_randomica}  Generate Random String  length=9  chars=[LETTERS]
  ${palavra_randomica}  Convert To Lower Case   ${palavra_randomica}
  Set Test Variable     ${PALAVRA_RAMDOMICA}           B${palavra_randomica}
  Set Test Variable     ${BOARD_NAME}           ${palavra_randomica}
  Log                   ${BOARD_NAME}

##--Post--##
##__Funcional__##
Cadastrar diretoria
  Criar diretoria
  ${body}  Create Dictionary  boardName=${BOARD_NAME}
  Log  ${body}
  ${resposta}  POST On Session  alias=APIConvergentes  url=/api/board/  json=${body}
  Log  ${resposta.json()}
  Set Test Variable    ${BOARD_ID}  ${resposta.json()["newBoard"]["_id"]}
  Log  ${BOARD_ID}

##__Não Funcional__##
Diretoria com mais de 50 caracteres
  ${body}   Create Dictionary  boardName= Operationsd Tesdter&bhujk Operationsf Tesdter&b lOperations Tesdter&b  
  Run Keyword And Expect Error  HTTPError: 400*  POST On Session  alias=APIConvergentes   url=/api/board/   json=${body}
Diretoria já cadastrada no sistema
  ${body}   Create Dictionary  boardName=Operation Tesdter&  
  Run Keyword And Expect Error  HTTPError: 409*    POST On Session  alias=APIConvergentes   url=/api/board/   json=${body}
Diretoria com caractere não permitido
  ${body}   Create Dictionary  boardName=Operation Tesdter$  
  Run Keyword And Expect Error  HTTPError: 400*  POST On Session  alias=APIConvergentes   url=/api/board/   json=${body}


##--Put--##
##__Funcional__##
Atualizar uma Diretoria por id
  Cadastrar diretoria
  ${body}   Create Dictionary  boardName= New ${BOARD_NAME}  
  ${resposta}  PUT On Session  alias=APIConvergentes   url=/api/board/${BOARD_ID}   json=${body}
   Log  ${resposta.json()}
   Dictionary Should Contain Item    ${resposta.json()}   msg   Cadastro atualizado com sucesso.

##__Não Funcional__##
Atulaizar diretoria com caracteres não permitidos
  Cadastrar diretoria
  ${body}   Create Dictionary  boardName= @#$${BOARD_NAME}  
  Run Keyword And Expect Error  HTTPError: 400*  PUT On Session  alias=APIConvergentes   url=/api/board/${BOARD_ID}   json=${body}
Atulaizar diretoria com campo vazio
  Cadastrar diretoria
  ${body}   Create Dictionary  boardName=  
  Run Keyword And Expect Error  HTTPError: 400*  PUT On Session  alias=APIConvergentes   url=/api/board/${BOARD_ID}   json=${body}


##--Get--##
##__Funcional__##
Listar diretorias
  ${resposta}  GET On Session  alias=APIConvergentes   url=/api/board/   
  Log  ${resposta.json()}
  Should Be Equal As Integers    ${resposta.status_code}    200
Mostrar diretoria por id
  Cadastrar diretoria
  ${resposta}  GET On Session  alias=APIConvergentes   url=/api/board/${BOARD_ID}   
  Log  ${resposta.json()}
  Set Test Variable    ${id_diretoria}    ${resposta.json()}[board][_id]
  Should Be Equal As Strings    ${id_diretoria}    ${BOARD_ID}
  Should Be Equal As Integers    ${resposta.status_code}    200

##__Não Funcional__##
pesquisar Diretoria por id inválido 
    Run Keyword And Expect Error  HTTPError: 500*  GET On Session  alias=APIConvergentes   url=/api/board/660340e40&17ca8b3bf6107d8   
