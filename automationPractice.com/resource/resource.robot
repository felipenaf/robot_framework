***Settings***
Library         SeleniumLibrary
Library         String

***Variables***
${base_url}  http://automationpractice.com/index.php
${browser}   firefox

***Keywords***
Abrir o navegador
    Open Browser  about:blank  ${browser}

Fechar o navegador
    Close Browser

Dado que estou na página inicial
    Go To   ${base_url}

Quando eu pesquisar por ${produto}
    Pesquisar por ${produto}

Então será listado na tela o produto ${produto}
    Wait Until Element Is Visible  id=page
    Title Should Be  Search - My Store
    Page Should Contain Link  //h5[@itemprop='name']//a[contains(text(), 'Blouse') and @class = 'product-name']

Então aparecerá uma página de registro não encontrado
    Wait Until Element Is Visible  id=page
    Title Should Be  Search - My Store
    Page Should Contain Element  //p[@class='alert alert-warning']

Pesquisar por ${produto}
    Wait Until Element Is Visible  id=searchbox
    Input Text  name=search_query  ${produto}
    Click Element  name=submit_search

Quando eu passar com o mouse por cima da categoria ${categoria} no menu principal superior de categorias e clicar na opção ${opcao_categoria}
    Wait Until Element Is Visible  //a[@title='Women']
    Mouse Over  //a[@title='Women']
    Wait Until Element Is Visible  //a[@title='Women']/following-sibling::ul
    Click Element  //a[@title='Women']/following-sibling::ul//a[@title='Dresses']/following-sibling::ul//li[3]

Então uma página com os produtos da categoria selecionada deve ser exibida.
    Wait Until Element Is Visible  id=page
    Title Should Be  ${opcao_categoria} - My Store
    Page Should Contain Element  //span[@class="cat-name"]

E o produto for adicionado ao carrinho
    Execute JavaScript    window.scrollByLines(35)
    Wait Until Element Is Visible  id=page
    Mouse Over  //img[@title="Faded Short Sleeve T-shirts"]
    Click Link  //a[@title='Add to cart']

Então deverá exibir um pop-up de confirmação
    Wait Until Element Is Visible  //div[@class="layer_cart_product col-xs-12 col-md-6"]

E quando clicar no botão "Proceed to checkout"
    Click Link  //a[@title='Proceed to checkout']

Então a tela do carrinho de compras será exibida
    Wait Until Element Is Visible  id=page
    Wait Until Element Is Visible  id=center_column
    Page Should Contain Element    ${locators[0]}
    Page Should Contain Element    ${locators[1]}
    Page Should Contain Element    ${locators[2]}

Quando eu clicar no ícone de carrinho de compras
    Click Link  //a[@title="View my shopping cart"]

E quando eu clicar no botão de remoção de produto
    Click Link  //a[@class="cart_quantity_delete"]

Então a tela exibirá a mensagem "Your shopping cart is empty."
    Wait Until Element Is Visible  //p[@class="alert alert-warning"]
    Page Should Contain Element    //p[@class="alert alert-warning" and text()="Your shopping cart is empty."]

Quando eu clicar no botão "Sign in"
    Wait Until Element Is Visible  id=page
    Click Link                     //a[@title="Log in to your customer account"]

Então exibirá a tela de autenticação
    Wait Until Element Is Visible  id=columns
    Page Should Contain Element    //span[@class="navigation_page"]  30

email aleatorio
    [Arguments]  ${nome}  ${sobrenome}
    ${aleatory_string}  Generate Random String  8  [LOWER]
    ${email} =  Catenate  SEPARATOR=  ${nome}  ${sobrenome}  ${aleatory_string}  @felipe.com
    [Return]  ${email}

E Quando eu inserir um email válido no campo de criação de conta
    ${email}  email aleatorio  filipe  alves
    Input Text  name=email_create  ${email}

E clicar no botão "Create an account"
    Click Button  id=SubmitCreate

Então será exibida a tela de criação de conta
    Wait Until Element Is Visible  id=noSlide
    Wait Until Element Is Visible  id=account-creation_form

E quando eu preencher o formulário
    Select Radio Button         id_gender                ${pessoa.id_genero}
    Input Text                  name=customer_firstname  ${pessoa.primeiro_nome}
    Input Text                  name=customer_lastname   ${pessoa.ultimo_nome}
    Input Password              name=passwd              ${pessoa.passwd}
    Input Text                  name=firstname           ${pessoa.primeiro_nome}
    Input Text                  name=lastname            ${pessoa.ultimo_nome}
    Input Text                  name=address1            ${pessoa.endereco}
    Input Text                  name=city                ${pessoa.cidade}
    Select From List By Value   name=id_state            ${pessoa.id_estado}
    Input Text                  name=postcode            ${pessoa.postcode}
    Input Text                  name=phone_mobile        ${pessoa.numero_celular}

E clicar em "Register"
    Click Button  name=submitAccount

Então a tela de gerenciamento de conta deve ser exibida
    Wait Until Element Is Visible  id=center_column
    Page Should Contain Element    //p[text()="Welcome to your account. Here you can manage all of your personal information and orders."]
