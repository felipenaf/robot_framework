*** Settings ***
Documentation   Documentação da API: https://fakerestapi.azurewebsites.net/swagger/ui/index#!/Books
Resource        ResourceAPI.robot
Suite Setup     Conectar a minha API

*** Test Case ***
Buscar a listagem de todos os livros (GET em todos os livros)
    Requisitar todos os livros
    Conferir o status code    200
    Conferir o reason   OK
    Conferir se retorna uma lista com "200" livros

Buscar um livro específico (GET em um livro específico)
    Requisitar o livro "15"
    Conferir o status code    200
    Conferir o reason   OK
    Conferir se retorna todos os dados corretos do livro 15

Cadastrar um novo livro (POST)
    Cadastrar um novo livro
    Conferir dados do livro
    ...  ${BOOK_201.ID}  ${BOOK_201.Title}  ${BOOK_201.Description}
    ...  ${BOOK_201.PageCount}  ${BOOK_201.Excerpt}  ${BOOK_201.PublishDate}

Alterar um livro (PUT)
    Alterar os dados do livro 150
    Conferir dados do livro
    ...  ${BOOK_150.ID}  ${BOOK_150.Title}  ${BOOK_150.Description}
    ...  ${BOOK_150.PageCount}  ${BOOK_150.Excerpt}  ${BOOK_150.PublishDate}

Deletar um livro (DELETE)
    Deletar o livro 150
    Conferir se deleta o livro 200 (o response body deve ser vazio)
