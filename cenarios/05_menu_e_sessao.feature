# language: pt
Funcionalidade: Menu Lateral e Gestão de Sessão
  Como um usuário da plataforma Swag Labs
  Quero utilizar os recursos do menu lateral (All Items, About, Logout, Reset App State)
  Para navegar rapidamente e resetar o estado da aplicação

  Contexto:
    Dado que o usuário está autenticado e na página de produtos "/inventory.html"

  # ==========================================
  # CENÁRIOS DO MENU LATERAL
  # ==========================================

  @menu @positivo
  Cenário: Abertura e fechamento do menu lateral
    Quando o usuário clica no ícone de menu hamburguer
    Então o menu lateral deve deslizar para a tela e exibir 4 opções:
      | Opção           |
      | All Items       |
      | About           |
      | Logout          |
      | Reset App State |
    Quando o usuário clica no botão "X" de fechar
    Então o menu lateral deve ser ocultado novamente

  @menu @sessao @logout @positivo
  Cenário: Realizar logout com sucesso
    Dado que o menu lateral está aberto
    Quando o usuário clica no link "Logout"
    Então a sessão do usuário deve ser encerrada
    E o usuário deve ser redirecionado para a página inicial "/"
    E se o usuário clicar no botão "Voltar" do navegador
    Não deve conseguir acessar os dados de inventário sem autenticar novamente

  @menu @estado @positivo
  Cenário: Resetar estado da aplicação (Reset App State)
    Dado que o usuário adicionou 2 produtos ao carrinho e o badge exibe "2"
    Quando abre o menu lateral e clica em "Reset App State"
    E fecha o menu lateral
    Então o badge do carrinho deve desaparecer
    E os botões dos produtos que estavam como "Remove" devem voltar a exibir "Add to cart"

  @menu @navegacao @positivo
  Cenário: Navegar para Todos os Itens a partir do carrinho
    Dado que o usuário está na página do carrinho "/cart.html"
    Quando abre o menu lateral e clica em "All Items"
    Então deve ser redirecionado de volta para a vitrine "/inventory.html"

  @menu @externo @borda
  Cenário: Validar link externo da opção About
    Quando o usuário abre o menu lateral
    Então o link "About" deve conter o atributo "href" apontando para "https://saucelabs.com/"

