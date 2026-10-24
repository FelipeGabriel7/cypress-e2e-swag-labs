# language: pt
Funcionalidade: Carrinho de Compras
  Como um cliente da loja Swag Labs
  Quero adicionar, visualizar e remover produtos no carrinho
  Para gerenciar os itens antes de prosseguir para o checkout

  Contexto:
    Dado que o usuário está autenticado com o perfil "standard_user"
    E está na página do inventário

  # ==========================================
  # CENÁRIOS POSITIVOS DE ADIÇÃO E CONTROLE
  # ==========================================

  @carrinho @smoke @positivo
  Cenário: Adicionar um item ao carrinho pela vitrine principal
    Quando o usuário clica no botão "Add to cart" do produto "Sauce Labs Backpack"
    Então o botão do produto deve alterar seu texto para "Remove"
    E o badge do carrinho no topo da página deve exibir o número "1"

  @carrinho @positivo
  Cenário: Adicionar múltiplos produtos e validar contador do badge
    Quando o usuário adiciona "Sauce Labs Backpack" ao carrinho
    E adiciona "Sauce Labs Bike Light" ao carrinho
    E adiciona "Sauce Labs Bolt T-Shirt" ao carrinho
    Então o badge do carrinho deve exibir o número "3"

  @carrinho @positivo
  Cenário: Adicionar produto a partir da tela de detalhes
    Quando o usuário acessa a página de detalhes de "Sauce Labs Fleece Jacket"
    E clica no botão "Add to cart"
    Então o badge do carrinho deve exibir "1"
    E o botão deve alternar para "Remove"
    Quando clica em "Back to products"
    Então na vitrine principal o mesmo produto também deve refletir o botão "Remove"

  # ==========================================
  # CENÁRIOS DE REMOÇÃO DE PRODUTOS
  # ==========================================

  @carrinho @remocao @positivo
  Cenário: Remover produto diretamente pela vitrine
    Dado que o produto "Sauce Labs Backpack" foi adicionado ao carrinho
    Quando o usuário clica no botão "Remove" da mochila na vitrine
    Então o botão deve voltar a exibir "Add to cart"
    E o badge do carrinho deve ser removido do cabeçalho

  @carrinho @remocao @positivo
  Cenário: Remover produto de dentro da página do carrinho
    Dado que os produtos "Sauce Labs Backpack" e "Sauce Labs Bike Light" estão no carrinho
    Quando o usuário clica no ícone do carrinho
    E clica no botão "Remove" correspondente à "Sauce Labs Backpack"
    Então a mochila não deve mais estar visível na lista do carrinho
    E o produto "Sauce Labs Bike Light" deve continuar listado
    E o badge do carrinho deve ser atualizado para "1"

  # ==========================================
  # CENÁRIOS DE NAVEGAÇÃO E PERSISTÊNCIA
  # ==========================================

  @carrinho @navegacao @positivo
  Cenário: Retornar às compras através do botão Continue Shopping
    Dado que o usuário está na página do carrinho "/cart.html"
    Quando clica no botão "Continue Shopping"
    Então deve ser redirecionado para a vitrine "/inventory.html"
    E os itens previamente selecionados devem continuar marcados como "Remove"

  @carrinho @borda @persistencia
  Cenário: Persistência do carrinho após recarregamento da página (F5)
    Dado que o usuário adicionou 2 itens ao carrinho
    Quando o usuário recarrega a página no navegador
    Então o badge do carrinho ainda deve exibir "2"
    E ao abrir a página do carrinho os 2 itens devem permanecer presentes

  # ==========================================
  # CENÁRIOS DE BORDA (CARRINHO VAZIO)
  # ==========================================

  @carrinho @borda
  Cenário: Acessar página de carrinho vazio
    Dado que o usuário não adicionou nenhum item
    Quando clica no ícone do carrinho
    Então a página "/cart.html" deve ser exibida
    E nenhum item de produto deve constar na listagem
    E o badge indicador no cabeçalho não deve estar visível

