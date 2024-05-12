*** Settings ***
Documentation  O objetivo deste arquivo é armazenar todos os recursos para os testes
Resource  costCenter.resource
Resource  diretoria.resource
Library  RequestsLibrary
Library  String
Library  Collections
Library    SeleniumLibrary


*** Keywords ***

Criar departamento
  ${palavra_randomica}  Generate Random String  length=5  chars=[LETTERS]
  ${palavra_randomica}  Convert To Lower Case   ${palavra_randomica}
  Set Test Variable     ${PALAVRA_RAMDOMICA}           ${palavra_randomica}
  Set Test Variable     ${RAMDOM_NAME}           T${palavra_randomica} & ${palavra_randomica}
  Log                   ${RAMDOM_NAME}


##--Post--##
##__Funcional__##
Cadastrar um departamento
  Cadastrar diretoria
  Cadastrar um Coast Center
  Criar departamento
  ${body}  Create Dictionary  departmentName=${RAMDOM_NAME}  costCenterId=${COSTCENTER_ID}
  Log  ${body}
  ${resposta}  POST On Session  alias=APIConvergentes  url=/api/department/  json=${body}
  Log  ${resposta.json()}
  Dictionary Should Contain Item    ${resposta.json()}    msg    Cadastro realizado com sucesso.
  Set Test Variable    ${DEPARTMENT_ID}     ${resposta.json()["newDepartment"]["_id"]}
  Set Test Variable    ${DEPARTMENT_NAME}   ${resposta.json()["newDepartment"]["departmentName"]}
  Set Test Variable    ${COSTCENTER}        ${resposta.json()["newDepartment"]["costCenter"]}

##__Não Funcional__##
Campo Departamento com caracteres especiais não permitidos
  Cadastrar diretoria
  Cadastrar um Coast Center
  Criar departamento
  ${body}  Create Dictionary  departmentName=${RAMDOM_NAME}@#$    costCenterId=${COSTCENTER_ID}
  Run Keyword And Expect Error  HTTPError: 400*  POST On Session  alias=APIConvergentes   url=/api/department/   json=${body}

Campo Departamento vazio
  ${body}  Create Dictionary  departmentName=    costCenterId=6580f93a9e210910c506a281
  Run Keyword And Expect Error  HTTPError: 400*  POST On Session  alias=APIConvergentes   url=/api/department/   json=${body}


##--Get--##
##__Funcional__##
Listar departamentos
  ${resposta}  GET On Session  alias=APIConvergentes   url=/api/department/   
  Log  ${resposta.json()}
  Should Be Equal As Integers    ${resposta.status_code}    200
Pesquisar departamento por Id
  Cadastrar um departamento
  ${resposta}  GET On Session  alias=APIConvergentes   url=/api/department/${DEPARTMENT_ID}   
  Log  ${resposta.json()}
  Set Test Variable    ${id_department}    ${resposta.json()}[department][_id]
  Should Be Equal As Strings    ${id_department}    ${DEPARTMENT_ID}
  Should Be Equal As Integers    ${resposta.status_code}    200


##__Não Funcional__##
Pesquisar departamento por Id inválido
  ${resposta}  Run Keyword And Expect Error  HTTPError: 500*  GET On Session  alias=APIConvergentes   url=/api/department/661049f7ab172fbe&1010de6f   


##--Put--##
##__Funcional__##
Atualizar dados de um departamento
  Cadastrar um departamento
  ${body}  Create Dictionary  departmentName=${PALAVRA_RAMDOMICA}  costCenterId=${COSTCENTER}
  ${resposta}  PUT On Session  alias=APIConvergentes  url=/api/department/660c826e252939a66a16cab2  json=${body}
  Log    ${resposta.json()}
  Dictionary Should Contain Item    ${resposta.json()}    msg    Cadastro atualizado com sucesso.
Inativar departamento
  Cadastrar um departamento
  ${body}  Create Dictionary  status=false
  ${resposta}  PUT On Session  alias=APIConvergentes  url=/api/department/status/${DEPARTMENT_ID}  json=${body}
  Log    ${resposta.json()}
  Dictionary Should Contain Item    ${resposta.json()}    msg    Departamento inativado com sucesso!
Ativar departamento
  Inativar departamento
  ${body}  Create Dictionary  status=true
  PUT On Session  alias=APIConvergentes  url=/api/department/status/${DEPARTMENT_ID}  json=${body}
  ${resposta}  GET On Session  alias=APIConvergentes   url=/api/department/${DEPARTMENT_ID}
  Log  ${resposta.json()}
  Set Test Variable    ${status}    ${resposta.json()}[department][status]
  Should Be Equal As Strings    ${status}    True

##__Não Funcional__##
Inativar departamento já inativado
  Inativar departamento
  ${body}  Create Dictionary  status=false
  ${resposta}  PUT On Session  alias=APIConvergentes  url=/api/department/status/${DEPARTMENT_ID}  json=${body}
  Log    ${resposta.json()}
  Dictionary Should Contain Item    ${resposta.json()}    msg    Esse departamento já se encontra inativado.
Ativar departamento já ativado
  Ativar departamento
  ${body}  Create Dictionary  status=true
  ${resposta}  PUT On Session  alias=APIConvergentes  url=/api/department/status/${DEPARTMENT_ID}  json=${body}
  Log    ${resposta.json()}
  Dictionary Should Contain Item    ${resposta.json()}    msg    Esse departamento já se encontra ativado.
Atualizar dados de um departamento sem caractere especial "&"
  ${body}  Create Dictionary  departmentName=Compras$fitst  costCenterId=6580f93a9e210910c506a281
  Run Keyword And Expect Error  HTTPError: 400*  PUT On Session  alias=APIConvergentes   url=/api/department/66104d13ab172fbe1010df50   json=${body}
Atualizar com campo departamento vazio
  ${body}  Create Dictionary  departmentName=  costCenterId=6580f93a9e210910c506a281
  Run Keyword And Expect Error  HTTPError: 400*  PUT On Session  alias=APIConvergentes   url=/api/department/66104d13ab172fbe1010df50   json=${body}
