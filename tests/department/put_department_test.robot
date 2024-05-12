*** Settings ***
Resource  ../../resources/department.resource
Resource    ../../resources/login.resource

*** Test Cases ***
##----Funcional----##
Funcional: Atualizar um departamento com sucesso
  Criar sessão autorizada
  Atualizar dados de um departamento
Funcional: inativar o status de um departamento
  Criar sessão autorizada
  Inativar departamento
Funcional: Ativar o status de um departamento
  Criar sessão autorizada
  Ativar departamento

##----Não_Funcional----##
Não Funcional: Atualizar departamento com caractere não permitido
  Criar sessão autorizada
  Atualizar dados de um departamento sem caractere especial "&"
Não Funcional: Atualizar com campo departamento vazio
  Criar sessão autorizada
  Atualizar com campo departamento vazio


# ESPERANDO DESENVOLVIMENTO DA MELHORIA
# Não Funcional: inativar o status de um departamento já inativado
#   Criar sessão autorizada
#   Inativar departamento já inativado

# Não Funcional: inativar o status de um departamento já inativado
#   Criar sessão autorizada
#   Ativar departamento já ativado