***Settings***
Library         SeleniumLibrary

***Variables***
${base_url}  http://automationpractice.com/index.php
${browser}   firefox

***Keywords***
Abrir o navegador
    Open Browser  about:blank  ${browser}

Fechar o navegador
    Close Browser
