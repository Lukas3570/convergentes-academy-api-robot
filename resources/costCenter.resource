*** Settings ***
Documentation  O objetivo deste arquivo é armazenar todos os recursos para os testes
Resource  diretoria.resource
Library  RequestsLibrary
Library  String
Library  Collections

*** Keywords ***
Criar um Coast Center
  ${palavra_randomica}  Generate Random String  length=9  chars=[LETTERS]
  ${palavra_randomica}  Convert To Lower Case   ${palavra_randomica}
  Set Test Variable     ${PALAVRA_RAMDOMICA}           C${palavra_randomica}
  Set Test Variable     ${COSTCENTER_NAME}           ${palavra_randomica}
  Log                   ${COSTCENTER_NAME}

Cadastrar um Coast Center
  Criar um Coast Center
  ${body}  Create Dictionary  costCenterName=${COSTCENTER_NAME}  boardId=${BOARD_ID}
  ${resposta}  POST On Session  alias=APIConvergentes  url=/api/costCenter/  json=${body}
  Log  ${resposta.json()}
  Set Test Variable    ${COSTCENTER_ID}  ${resposta.json()["newCostCenter"]["_id"]}
  Log    ${COSTCENTER_ID}

