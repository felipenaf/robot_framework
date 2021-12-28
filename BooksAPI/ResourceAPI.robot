*** Settings ***
Documentation   Documentação da API: https://fakerestapi.azurewebsites.net/swagger/ui/index#!/Books
Library         RequestsLibrary
Library         Collections

*** Variable ***
${URL_API}      https://fakerestapi.azurewebsites.net/api/v1
&{BOOK_15}      ID=15
...             Title=Book 15
...             PageCount=1500
&{BOOK_201}     ID=201
...             Title=Book 201
...             Description=Description aleatory
...             Excerpt=excerpt aleatory
...             PageCount=700
...             PublishDate=2021-12-27T00:00:00
&{BOOK_150}     ID=150
...             Title=Book 150
...             Description=Descricao alterada
...             Excerpt=excerpt alterada
...             PageCount=700
...             PublishDate=2021-12-27T00:00:00

*** Keywords ***
####SETUP E TEARDOWNS
Conectar a minha API
    Create Session    fakeAPI    ${URL_API}  verify=true
    ${HEADERS}     Create Dictionary    content-type=application/json
    Set Suite Variable    ${HEADERS}

#### Ações
Requisitar todos os livros
    ${RESPOSTA}    Get On Session    fakeAPI    Books
    Log            ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

Requisitar o livro "${ID_LIVRO}"
    ${RESPOSTA}    Get On Session    fakeAPI    Books/${ID_LIVRO}
    Log            ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

Cadastrar um novo livro
    ${RESPOSTA}    Post On Session   fakeAPI    Books
    ...                           data={"id": ${BOOK_201.ID},"title": "${BOOK_201.Title}","description": "${BOOK_201.Description}","pageCount": ${BOOK_201.PageCount},"excerpt": "${BOOK_201.Excerpt}","publishDate": "${BOOK_201.PublishDate}"}
    ...                           headers=${HEADERS}
    Log            ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

#### Conferências
Conferir o status code
    [Arguments]      ${STATUSCODE_DESEJADO}
    Should Be Equal As Strings    ${RESPOSTA.status_code}    ${STATUSCODE_DESEJADO}

Conferir o reason
    [Arguments]    ${REASON_DESEJADO}
    Should Be Equal As Strings    ${RESPOSTA.reason}     ${REASON_DESEJADO}

Conferir se retorna uma lista com "${QTDE_LIVROS}" livros
    Length Should Be      ${RESPOSTA.json()}     ${QTDE_LIVROS}

Conferir se retorna todos os dados corretos do livro 15
    Dictionary Should Contain Item    ${RESPOSTA.json()}    id              ${BOOK_15.ID}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    title           ${BOOK_15.Title}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    pageCount       ${BOOK_15.PageCount}
    Should Not Be Empty    ${RESPOSTA.json()["description"]}
    Should Not Be Empty    ${RESPOSTA.json()["excerpt"]}
    Should Not Be Empty    ${RESPOSTA.json()["publishDate"]}

Conferir se retorna todos os dados cadastrados para o novo livro
    Dictionary Should Contain Item  ${RESPOSTA.json()}  id           ${BOOK_201.ID}
    Dictionary Should Contain Item  ${RESPOSTA.json()}  title        ${BOOK_201.Title}
    Dictionary Should Contain Item  ${RESPOSTA.json()}  description  ${BOOK_201.Description}
    Dictionary Should Contain Item  ${RESPOSTA.json()}  pageCount    ${BOOK_201.PageCount}
    Dictionary Should Contain Item  ${RESPOSTA.json()}  excerpt      ${BOOK_201.Excerpt}
    Dictionary Should Contain Item  ${RESPOSTA.json()}  publishDate  ${BOOK_201.PublishDate}

Alterar os dados do livro ${id}
    ${RESPOSTA}  PUT On Session  fakeAPI  Books/${id}
    ...  data={"id": "${BOOK_150.ID}","title": "${BOOK_150.Title}","description": "${BOOK_150.Description}","pageCount": ${BOOK_150.PageCount},"excerpt": "${BOOK_150.Excerpt}","publishDate": "${BOOK_150.PublishDate}"}
    ...  headers=${HEADERS}
    Set Test Variable  ${RESPOSTA}

Conferir se retorna todos os dados alterados do livro 150
    Dictionary Should Contain Item  ${RESPOSTA.json()}  id           ${BOOK_150.ID}
    Dictionary Should Contain Item  ${RESPOSTA.json()}  title        ${BOOK_150.Title}
    Dictionary Should Contain Item  ${RESPOSTA.json()}  description  ${BOOK_150.Description}
    Dictionary Should Contain Item  ${RESPOSTA.json()}  pageCount    ${BOOK_150.PageCount}
    Dictionary Should Contain Item  ${RESPOSTA.json()}  excerpt      ${BOOK_150.Excerpt}
    Dictionary Should Contain Item  ${RESPOSTA.json()}  publishDate  ${BOOK_150.PublishDate}

Deletar o livro ${id}
    ${RESPOSTA}  Delete On Session  fakeAPI  Books/${id}
    Set Test Variable  ${RESPOSTA}

Conferir se deleta o livro 200 (o response body deve ser vazio)
    Should Be Equal As Integers  ${RESPOSTA.status_code}  200

