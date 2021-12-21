***Settings***
Resource    ../resource/resource.robot

Suite Setup     Abrir o navegador   # Executado antes de todos os testes
Suite Teardown  Fechar o navegador  # Executado após todos os testes
Test Setup      Go To   ${url}      # Executado antes de cada teste

***Variables***
${pesquisa1}  clube da luta
${pesquisa2}  ewfewewffewfewfew

***Test Cases***
Teste01: Pesquisar resenha do Clube da Luta
    Pesquisar por ${pesquisa1}
    Wait Until Element Is Visible  id=post-lista
    Title Should Be  Você pesquisou por ${pesquisa1} - Resenhas à la Carte
    Page Should Contain Link  //a[contains(text(), 'Resenha: Clube da Luta – Chuck Palahniuk')]

Teste02: Pesquisa não encontrada
    Pesquisar por ${pesquisa2}
    Wait Until Element Is Visible  id=blog
    Title Should Be  Você pesquisou por ${pesquisa2} - Resenhas à la Carte
    Page Should Contain Element  //span[contains(text(), 'Não Encontrado')]
    Page Should Contain Element  //p[contains(text(), 'Nenhum registro foi encontrado!')]

***Keywords***
Pesquisar por ${termo}
    Wait Until Element Is Not Visible  id=onesignal-slidedown-container 10
    Wait Until Element Is Visible  name=submit
    Input Text  name=s  ${termo}
    Click Element  name=submit
