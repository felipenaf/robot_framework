***Settings***
Resource    ../resource/resource.robot

Suite Setup     Abrir o navegador   # Executado antes de todos os testes
Suite Teardown  Fechar o navegador  # Executado após todos os testes
Test Setup      Go To   ${base_url}      # Executado antes de cada teste

***Variables***
${pesquisa1}  clube da luta
${pesquisa2}  ewfewewffewfewfew

***Test Cases***
Teste01: Pesquisar resenha do Clube da Luta
    Dado que estou na página inicial
    Quando eu pesquisar por ${pesquisa1}
    Então aparecerá uma resenha de ${pesquisa1} na lista

Teste02: Pesquisa não encontrada
    Dado que estou na página inicial
    Quando eu pesquisar por ${pesquisa2}
    Então aparecerá uma página de registro não encontrado

***Keywords***
Dado que estou na página inicial
    Go To   ${base_url}

Quando eu pesquisar por ${termo}
    Pesquisar por ${termo}

Então aparecerá uma resenha de ${pesquisa1} na lista
    Wait Until Element Is Visible  id=post-lista
    Title Should Be  Você pesquisou por ${pesquisa1} - Resenhas à la Carte
    Page Should Contain Link  //a[contains(text(), 'Resenha: Clube da Luta – Chuck Palahniuk')]

Então aparecerá uma página de registro não encontrado
    Wait Until Element Is Visible  id=blog
    Title Should Be  Você pesquisou por ${pesquisa2} - Resenhas à la Carte
    Page Should Contain Element  //span[contains(text(), 'Não Encontrado')]
    Page Should Contain Element  //p[contains(text(), 'Nenhum registro foi encontrado!')]

Pesquisar por ${termo}
    Wait Until Element Is Not Visible  id=onesignal-slidedown-container 10
    Wait Until Element Is Visible  name=submit
    Input Text  name=s  ${termo}
    Click Element  name=submit
