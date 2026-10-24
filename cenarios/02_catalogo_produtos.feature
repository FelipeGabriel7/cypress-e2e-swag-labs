# language: pt
Funcionalidade: Catálogo de Produtos e Vitrine
  Como um cliente autenticado no Swag Labs
  Quero explorar a vitrine de produtos, ordenar itens e acessar detalhes
  Para avaliar preços e escolher produtos de meu interesse

  Contexto:
    Dado que o usuário está autenticado com o perfil "standard_user"
    E está na página de produtos "/inventory.html"

  # ==========================================
  # CENÁRIOS POSITIVOS (VISUALIZAÇÃO & DETALHES)
  # ==========================================

  @catalogo @smoke @positivo
  Cenário: Visualização completa do catálogo padrão
    Então o sistema deve exibir exatamente 6 produtos na vitrine
    E cada produto deve exibir imagem, título, descrição, preço e botão "Add to cart"

  @catalogo @positivo
  Cenário: Acessar página de detalhes clicando no título do produto
    Quando o usuário clica no título do produto "Sauce Labs Backpack"
    Então deve ser redirecionado para a página "/inventory-item.html?id=4"
    E deve visualizar a foto ampliada, descrição completa e o preço "$29.99"
    Quando clica no botão "Back to products"
    Então deve retornar à listagem geral mantendo todos os produtos visíveis

  @catalogo @positivo
  Cenário: Acessar página de detalhes clicando na imagem do produto
    Quando o usuário clica na imagem do produto "Sauce Labs Bike Light"
    Então deve ser redirecionado para os detalhes do produto "Sauce Labs Bike Light"
    E o botão de adicionar ao carrinho deve estar disponível

  # ==========================================
  # CENÁRIOS DE ORDENAÇÃO E FILTROS
  # ==========================================

  @catalogo @ordenacao @positivo
  Cenário: Ordenar produtos por Menor Preço (Price low to high)
    Quando o usuário seleciona a opção "Price (low to high)" no filtro de ordenação
    Então o primeiro produto da lista deve ser "Sauce Labs Onesie" com o valor de "$7.99"
    E o último produto da lista deve ser "Sauce Labs Fleece Jacket" com o valor de "$49.99"

  @catalogo @ordenacao @positivo
  Cenário: Ordenar produtos por Maior Preço (Price high to low)
    Quando o usuário seleciona a opção "Price (high to low)" no filtro de ordenação
    Então o primeiro produto da lista deve ser "Sauce Labs Fleece Jacket" com o valor de "$49.99"
    E o último produto da lista deve ser "Sauce Labs Onesie" com o valor de "$7.99"

  @catalogo @ordenacao @positivo
  Cenário: Ordenar produtos por Nome de Z a A (Name Z to A)
    Quando o usuário seleciona a opção "Name (Z to A)" no filtro de ordenação
    Então o primeiro produto da lista deve ser "Test.allTheThings() T-Shirt (Red)"
    E o último produto da lista deve ser "Sauce Labs Backpack"

  @catalogo @ordenacao @positivo
  Cenário: Retornar ordenação para o padrão de A a Z (Name A to Z)
    Dado que a lista está ordenada por "Price (high to low)"
    Quando o usuário altera a ordenação para "Name (A to Z)"
    Então o primeiro produto da lista deve voltar a ser "Sauce Labs Backpack"
    E o último produto deve ser "Test.allTheThings() T-Shirt (Red)"

  # ==========================================
  # CENÁRIO DE BORDA / PROBLEMAS DE DADOS
  # ==========================================

  @catalogo @borda @defeito-conhecido
  Cenário: Identificar imagens quebradas com perfil de problema (problem_user)
    Dado que o usuário efetuou login com "problem_user"
    Quando acessa a vitrine de produtos
    Então todas as imagens dos produtos apontam para a mesma URL quebrada ("/static/media/sl-404.168b1cce.jpg")

