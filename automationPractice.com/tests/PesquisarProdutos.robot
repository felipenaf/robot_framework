***Settings***
Resource    ../resource/resource.robot

Suite Setup     Abrir o navegador                 # Executado antes de todos os testes
Suite Teardown  Fechar o navegador                # Executado após todos os testes
Test Setup      Dado que estou na página inicial  # Executado antes de cada teste

***Variables***
${produto}   Blouse
${produto2}  produtonaoencontrado
${produto3}  t-shirt
${opcao_categoria}  Summer Dresses
${categoria}  Women
${dominio_email}  @felipe.com
&{pessoa}
    ...  primeiro_nome=felipe  ultimo_nome=ferreira
    ...  id_genero=1  passwd=bipao  endereco=Rua dos bobos, 0
    ...  cidade=Camp  id_estado=5  postcode=11111
    ...  numero_celular=970707070
@{locators}
    ...  id=cart_title
    ...  //li[@class="step_current\ \ first"]
    ...  id=cart_summary

***Test Cases***
Teste00: Logs
    Log  ${locators}

Teste01: Pesquisar produtos existentes
    Quando eu pesquisar por ${produto}
    Então será listado na tela o produto ${produto}

Teste02: Pesquisar Produtos não Existentes
    Quando eu pesquisar por ${produto2}
    Então aparecerá uma página de registro não encontrado

Teste03: Listar Produtos
    Quando eu passar com o mouse por cima da categoria ${categoria} no menu principal superior de categorias e clicar na opção ${opcao_categoria}
    Então uma página com os produtos da categoria selecionada deve ser exibida.

Teste04: Adicionar Produtos no Carrinho
    Quando eu pesquisar por ${produto3}
    E o produto for adicionado ao carrinho
    Então deverá exibir um pop-up de confirmação
    E quando clicar no botão "Proceed to checkout"
    Então a tela do carrinho de compras será exibida

Teste05: Remover Produtos
    Quando eu clicar no ícone de carrinho de compras
    Então a tela do carrinho de compras será exibida
    E quando eu clicar no botão de remoção de produto
    Então a tela exibirá a mensagem "Your shopping cart is empty."

Teste06: Adicionar Cliente
    Quando eu clicar no botão "Sign in"
    Então exibirá a tela de autenticação
    E Quando eu inserir um email válido no campo de criação de conta
    E clicar no botão "Create an account"
    Então será exibida a tela de criação de conta
    E quando eu preencher o formulário
    E clicar em "Register"
    Então a tela de gerenciamento de conta deve ser exibida
