# language: pt
Funcionalidade: Processo de Checkout e Conclusão de Compra
  Como um cliente com produtos selecionados no carrinho
  Quero informar meus dados de entrega, revisar valores e confirmar o pedido
  Para concluir minha compra com precisão financeira e segurança

  Contexto:
    Dado que o usuário está autenticado com "standard_user"
    E adicionou o produto "Sauce Labs Backpack" ($29.99) ao carrinho
    E está na página do carrinho de compras "/cart.html"

  # ==========================================
  # CENÁRIO POSITIVO COMPLETO (HAPPY PATH E2E)
  # ==========================================

  @checkout @smoke @e2e @positivo
  Cenário: Concluir compra de ponta a ponta com sucesso
    Quando o usuário clica no botão "Checkout"
    Então deve ser direcionado para "/checkout-step-one.html"
    Quando preenche o campo "First Name" com "Felipe"
    E preenche o campo "Last Name" com "Gabriel"
    E preenche o campo "Zip/Postal Code" com "13000000"
    E clica em "Continue"
    Então deve ser direcionado para a tela de revisão "/checkout-step-two.html"
    E deve visualizar o resumo do pagamento e envio:
      | Campo                | Valor Esperado       |
      | Payment Information  | SauceCard #31337     |
      | Shipping Information | Free Pony Express    |
      | Item total           | $29.99               |
      | Tax                  | $2.40                |
      | Total                | $32.39               |
    Quando clica no botão "Finish"
    Então deve ser direcionado para "/checkout-complete.html"
    E deve visualizar o cabeçalho "Thank you for your order!"
    E a mensagem "Your order has been dispatched, and will arrive just as fast as the pony can get there!"
    Quando clica no botão "Back Home"
    Então deve retornar para "/inventory.html" com o carrinho completamente limpo

  # ==========================================
  # CENÁRIOS DE VALIDAÇÃO DE CAMPOS OBRIGATÓRIOS
  # ==========================================

  @checkout @negativo @validacao
  Cenário: Tentativa de avançar checkout com First Name em branco
    Dado que o usuário está na etapa "/checkout-step-one.html"
    Quando deixa o campo "First Name" vazio
    E preenche "Last Name" com "Gabriel" e "Postal Code" com "13000000"
    E clica no botão "Continue"
    Então deve visualizar a mensagem de erro "Error: First Name is required"
    E deve permanecer na etapa 1 do checkout

  @checkout @negativo @validacao
  Cenário: Tentativa de avançar checkout com Last Name em branco
    Dado que o usuário está na etapa "/checkout-step-one.html"
    Quando preenche "First Name" com "Felipe"
    E deixa o campo "Last Name" vazio
    E preenche "Postal Code" com "13000000"
    E clica no botão "Continue"
    Então deve visualizar a mensagem de erro "Error: Last Name is required"

  @checkout @negativo @validacao
  Cenário: Tentativa de avançar checkout com Postal Code em branco
    Dado que o usuário está na etapa "/checkout-step-one.html"
    Quando preenche "First Name" com "Felipe"
    E preenche "Last Name" com "Gabriel"
    E deixa o campo "Postal Code" vazio
    E clica no botão "Continue"
    Então deve visualizar a mensagem de erro "Error: Postal Code is required"

  @checkout @negativo @validacao
  Cenário: Tentativa de avançar checkout com todos os campos em branco
    Dado que o usuário está na etapa "/checkout-step-one.html"
    Quando deixa todos os campos em branco
    E clica no botão "Continue"
    Então o sistema deve priorizar o erro do primeiro campo "Error: First Name is required"

  # ==========================================
  # CENÁRIOS DE CANCELAMENTO E NAVEGAÇÃO
  # ==========================================

  @checkout @navegacao @positivo
  Cenário: Cancelar checkout na etapa 1 e retornar ao carrinho
    Dado que o usuário está na etapa "/checkout-step-one.html"
    Quando clica no botão "Cancel"
    Então deve ser redirecionado para a página do carrinho "/cart.html"
    E os itens no carrinho continuam preservados

  @checkout @navegacao @positivo
  Cenário: Cancelar checkout na etapa 2 (resumo) e retornar à vitrine
    Dado que o usuário preencheu os dados e está em "/checkout-step-two.html"
    Quando clica no botão "Cancel"
    Então deve ser redirecionado para a vitrine de produtos "/inventory.html"
    E os itens no carrinho continuam preservados com o badge "1"

  # ==========================================
  # CENÁRIOS DE CÁLCULO E CASOS DE BORDA
  # ==========================================

  @checkout @calculo @borda
  Cenário: Validação exata de cálculo com múltiplos produtos com centavos distintos
    Dado que o usuário adicionou "Sauce Labs Backpack" ($29.99) e "Sauce Labs Bike Light" ($9.99)
    Quando avança para a tela de revisão "/checkout-step-two.html"
    Então o "Item total" deve ser a soma exata "$39.98"
    E o imposto "Tax" deve ser calculado como "$3.20"
    E o "Total" final deve ser rigorosamente "$43.18"

  @checkout @borda
  Cenário: Checkout com carrinho vazio
    Dado que o usuário está na página do carrinho sem nenhum item
    Quando clica no botão "Checkout"
    E preenche dados válidos de identificação e clica em "Continue"
    Então o resumo deve exibir "Item total: $0.00", "Tax: $0.00" e "Total: $0.00"

  @checkout @borda @defeito-conhecido
  Cenário: Falha ao preencher sobrenome com usuário problemático (problem_user)
    Dado que o usuário efetuou login com o perfil "problem_user"
    E adicionou um item ao carrinho e avançou até a etapa 1 de checkout
    Quando tenta digitar no campo "Last Name"
    Então o campo recusa a digitação ou substitui pelo mesmo valor do First Name
    E ao tentar continuar o sistema impede o avanço

