# 📘 Regras de Negócio e Arquitetura do Sistema - Swag Labs

Este documento detalha o funcionamento funcional, as regras de negócio, a matriz de usuários e as condições de borda da plataforma **Sauce Demo (Swag Labs)**. Ele serve como especificação formal para embasar a escrita dos cenários em Gherkin e a automação de testes.

---

## 🌐 1. Arquitetura de Telas e Rotas

A aplicação é uma SPA (Single Page Application) que simula um e-commerce com as seguintes rotas e estados:

| Rota | Tela | Descrição / Responsabilidade |
| :--- | :--- | :--- |
| `/` | **Login** | Autenticação com formulário de usuário e senha. |
| `/inventory.html` | **Catálogo (Home)** | Exibição da grade de 6 produtos, ordenação e botão do carrinho. |
| `/inventory-item.html?id={id}` | **Detalhes do Produto** | Exibição de foto ampliada, descrição completa, preço e botão de adicionar/remover. |
| `/cart.html` | **Carrinho** | Listagem dos itens adicionados, quantidades, remoção e botões "Continue Shopping" e "Checkout". |
| `/checkout-step-one.html` | **Checkout: Dados** | Formulário de identificação do comprador (First Name, Last Name, Postal Code). |
| `/checkout-step-two.html` | **Checkout: Resumo** | Revisão dos itens, informações de envio/pagamento, subtotal, taxa (tax) e total. |
| `/checkout-complete.html` | **Checkout: Conclusão** | Mensagem de sucesso, ilustração e botão para reiniciar o fluxo ("Back Home"). |

---

## 👥 2. Matriz de Usuários e Comportamentos

O Swag Labs possui perfis de usuários pré-configurados para simular cenários reais de testes manuais e automatizados:

| Usuário | Senha Padrão | Comportamento Esperado / Cenários Cobertos |
| :--- | :--- | :--- |
| **`standard_user`** | `secret_sauce` | **Usuário Padrão (Happy Path)**: Todas as funcionalidades operam sem erros. |
| **`locked_out_user`** | `secret_sauce` | **Usuário Bloqueado**: Impede o login e exibe mensagem de erro de bloqueio. |
| **`problem_user`** | `secret_sauce` | **Simulação de Defeitos Funcionais**: Todas as imagens dos produtos aparecem iguais (quebradas) e o campo *Last Name* no checkout não aceita preenchimento. |
| **`performance_glitch_user`** | `secret_sauce` | **Problema de Performance**: Aplicação simula uma lentidão severa de rede (~5 segundos) no carregamento das páginas. |
| **`error_user`** | `secret_sauce` | **Erros em Tempo de Execução**: Apresenta falhas ao tentar remover itens e quebra ao clicar em "Finish" no checkout. |
| **`visual_user`** | `secret_sauce` | **Regressão Visual**: Desalinhamento proposital de elementos, botões e imagens para testes visuais. |

---

## 📋 3. Regras de Negócio e Casos de Borda

### 3.1. Autenticação e Controle de Sessão
1. **Credenciais Obrigatórias**: Tanto usuário quanto senha são obrigatórios. Se qualquer um estiver vazio, o sistema não deve disparar requisição inválida e deve acusar erro específico:
   - Sem usuário: `Epic sadface: Username is required`
   - Sem senha: `Epic sadface: Password is required`
2. **Proteção de Rotas (Acesso Direto)**:
   - Se um usuário deslogado tentar acessar `/inventory.html` ou qualquer tela interna diretamente pela barra de endereços do navegador, o sistema **deve redirecionar para a tela inicial** com o erro:  
     `Epic sadface: You can only access '/inventory.html' when you are logged in.`
3. **Persistência de Sessão**:
   - A sessão do usuário é gerenciada via cookies/storage (`session-username`). Ao efetuar logout ou limpar os dados, o acesso deve ser encerrado.

---

### 3.2. Catálogo e Filtros de Ordenação
1. **Total de Produtos**: A vitrine possui exatamente **6 itens**.
2. **Opções de Ordenação**:
   - `az`: Nome de A a Z (Padrão).
   - `za`: Nome de Z a A (Inverso alfabético).
   - `lohi`: Menor Preço para Maior Preço (Ordem numérica crescente: de $7.99 a $49.99).
   - `hilo`: Maior Preço para Menor Preço (Ordem numérica decrescente: de $49.99 a $7.99).
3. **Consistência de Estado (Toggle de Botão)**:
   - Ao clicar em "Add to cart", o botão deve alternar seu texto e estilo para "Remove".
   - Ao navegar para a tela de detalhes do produto ou para o carrinho, o status "Remove" deve estar sincronizado.

---

### 3.3. Carrinho de Compras
1. **Contador do Badge**:
   - Quando o carrinho estiver com 0 itens, o elemento `.shopping_cart_badge` **não deve existir no DOM**.
   - Ao adicionar itens, o badge deve refletir exatamente o número de itens distintos adicionados.
2. **Caso de Borda - Checkout sem Itens**:
   - O Swag Labs permite clicar em "Checkout" mesmo com o carrinho vazio. Os testes devem verificar a integridade da tela de resumo ($0.00 de subtotal e taxa).
3. **Persistência ao Navegar**:
   - Adicionar itens, navegar entre telas internas e retornar ao carrinho deve manter todos os itens intactos.

---

### 3.4. Checkout e Cálculos Financeiros
1. **Validação de Campos do Comprador (Step One)**:
   - Todos os três campos são obrigatórios: *First Name*, *Last Name* e *Zip/Postal Code*.
   - A validação ocorre em cascata na seguinte ordem de prioridade:
     1. Se `First Name` vazio $\rightarrow$ `Error: First Name is required`
     2. Se `Last Name` vazio $\rightarrow$ `Error: Last Name is required`
     3. Se `Postal Code` vazio $\rightarrow$ `Error: Postal Code is required`
2. **Regra de Cálculo Financeiro (Step Two)**:
   - **Item Total (Subtotal)**: Soma exata dos valores unitários dos produtos selecionados.
   - **Tax (Imposto/Taxa)**: Corresponde a aproximadamente **8.04%** do Subtotal, arredondado para duas casas decimais (ex: em $29.99, taxa = $2.40).
   - **Total**: Deve ser rigorosamente `Subtotal + Tax` (ex: $29.99 + $2.40 = $32.39).
3. **Cancelamento em Qualquer Etapa**:
   - Clicar em "Cancel" no Step One deve retornar para `/cart.html` sem perder os itens.
   - Clicar em "Cancel" no Step Two deve retornar para `/inventory.html` sem perder os itens.

---

### 3.5. Menu Lateral (Sidebar) e Estado Geral
1. **Opções do Menu**:
   - **All Items**: Redireciona para `/inventory.html`.
   - **About**: Redireciona para o site institucional externo da Sauce Labs (`https://saucelabs.com/`).
   - **Logout**: Encerra a sessão e apaga as credenciais salvas.
   - **Reset App State**: Limpa o carrinho de compras e redefine o estado de todos os botões para "Add to cart", sem deslogar o usuário.

