# 🎯 Matriz de Rastreabilidade & Dashboard de Automação

Dashboard de acompanhamento da cobertura de testes ponta a ponta (E2E) no **Swag Labs**, correlacionando as especificações em **BDD (Gherkin)** com os scripts automatizados em **Cypress**.

---

## 📊 Status da Cobertura Geral

| Métrica | Valor | Indicador Visual |
| :--- | :---: | :--- |
| **Total de Cenários Mapeados** | **40** | Especificados em `cenarios/*.feature` |
| 🟢 **Cenários Automatizados e Validados** | **26** | Inclui os 8 cenários da suíte de carrinho |
| 🟡 **Cenários Implementados, Validação Pendente** | **0** | Nenhum cenário aguardando validação |
| 🔵 **Cenários em Andamento** | **1** | Happy path do checkout ainda não validado |
| ⚪ **Cenários Pendentes** | **13** | Planejados para implementação |
| 📈 **Cobertura Validada** | **65%** | `26 / 40 cenários` |

```text
Progresso validado: [████████████████░░░░░░░░] 65% (26/40)
```

---

## 📌 Cobertura por Funcionalidade

```text
[1] Autenticação (Login)       : [████████████████████] 100% (9/9)   🟢 COMPLETO
[2] Catálogo & Detalhes (Home) : [████████████████████] 100% (8/8)   🟢 COMPLETO
[3] Checkout & Pedidos         : [░░░░░░░░░░░░░░░░░░░░] 0% validado (0/10); 1 em andamento 🔵
[4] Carrinho de Compras        : [████████████████████] 100% (8/8) 🟢 COMPLETO
[5] Menu Lateral & Sessão      : [░░░░░░░░░░░░░░░░░░░░] 0.0%  (0/5)  ⚪ PENDENTE
```

---

## 🔐 1. Autenticação e Segurança (`01_autenticacao.feature`)
> **Arquivo de Teste:** [`cypress/e2e/login.cy.js`](file:///e:/Estudos/Cypress/E2ESwagLabs/cypress/e2e/login.cy.js)  
> **Status:** 🟢 **100% Automatizado** (9 de 9 cenários)

| ID | Tipo | Cenário BDD | Validação Realizada | Status |
| :---: | :---: | :--- | :--- | :---: |
| **CT-01** | `Smoke` | Login com usuário válido | Redirecionamento para `/inventory.html` e vitrine visível | 🟢 Concluído |
| **CT-02** | `Negativo` | Login com usuário bloqueado | Mensagem: `LOCKED_USER` | 🟢 Concluído |
| **CT-03** | `Negativo` | Login com usuário inexistente | Mensagem: `INVALID_USER` | 🟢 Concluído |
| **CT-04** | `Negativo` | Login com senha incorreta e usuário válido | Mensagem: `INVALID_USER` | 🟢 Concluído |
| **CT-05** | `Validação` | Login sem preencher usuário | Mensagem: `USERNAME_REQUIRED` | 🟢 Concluído |
| **CT-06** | `Validação` | Login sem preencher senha | Mensagem: `PASSWORD_REQUIRED` | 🟢 Concluído |
| **CT-07** | `Validação` | Login com ambos os campos em branco | Mensagem prioritária: `USERNAME_REQUIRED` | 🟢 Concluído |
| **CT-08** | `Segurança` | Acesso direto à URL interna sem login | Bloqueio via `{ failOnStatusCode: false }` e redirecionamento | 🟢 Concluído |
| **CT-09** | `Performance`| Login com usuário com lentidão simulada | Validação assíncrona com `{ timeout: 10000 }` | 🟢 Concluído |

---

## 📦 2. Catálogo e Vitrine (`02_catalogo_produtos.feature`)
> **Arquivo de Teste:** [`cypress/e2e/home.cy.js`](file:///e:/Estudos/Cypress/E2ESwagLabs/cypress/e2e/home.cy.js)  
> **Status:** 🟢 **100% Automatizado** (8 de 8 cenários)

| ID | Tipo | Cenário BDD | Validação Realizada | Status |
| :---: | :---: | :--- | :--- | :---: |
| **CT-HM-01** | `Smoke` | Visualização completa do catálogo padrão | Presença de 6 produtos com loop `.each()` e `.wrap()` | 🟢 Concluído |
| **CT-HM-02** | `Funcional` | Detalhes do produto clicando no título | Rota `ROUTES.ITEM_PAGE`, título, descrição, preço e botão voltar | 🟢 Concluído |
| **CT-HM-03** | `Acessibilidade` | Detalhes do produto clicando na imagem | Seletor semântico `img[alt="..."]`, rota `ROUTES.OTHER_ITEM` e `#add-to-cart` | 🟢 Concluído |
| **CT-HM-04** | `Filtro` | Ordenação: Menor para Maior Preço (`lohi`) | Primeiro produto `$7.99` e último `$49.99` com `.within()` | 🟢 Concluído |
| **CT-HM-05** | `Filtro` | Ordenação: Maior para Menor Preço (`hilo`) | Primeiro produto `$49.99` e último `$7.99` com `.within()` | 🟢 Concluído |
| **CT-HM-06** | `Filtro` | Ordenação: Nome Z a A (`za`) | Primeiro produto `Test.allTheThings()...` e último `Backpack` | 🟢 Concluído |
| **CT-HM-07** | `Filtro` | Ordenação: Retornar para A a Z (`az`) | Restauração da ordem inicial da vitrine | 🟢 Concluído |
| **CT-HM-08** | `Borda` | Imagens quebradas com `problem_user` | Detecção da URL da imagem com `have.attr` `src` e `include` `sl-404` | 🟢 Concluído |

---

## 💳 3. Checkout e Transações (`04_checkout.feature`)
> **Arquivo de Teste:** [`cypress/e2e/checkout.cy.js`](file:///e:/Estudos/Cypress/E2ESwagLabs/cypress/e2e/checkout.cy.js)  
> **Status:** 🔵 **Em andamento** (0 de 10 cenários validados; CT-CHK-01 ainda não passou)

| ID | Tipo | Cenário BDD | Validação Realizada | Status |
| :---: | :---: | :--- | :--- | :---: |
| **CT-CHK-01** | `E2E / Smoke`| Fluxo de compra completo (Happy Path) | Ainda não alcança/valida o fluxo completo; teste temporariamente comentado durante investigação | 🔵 Em andamento |
| **CT-CHK-02** | `Validação` | Checkout com First Name em branco | Erro: `Error: First Name is required` | ⚪ Pendente |
| **CT-CHK-03** | `Validação` | Checkout com Last Name em branco | Erro: `Error: Last Name is required` | ⚪ Pendente |
| **CT-CHK-04** | `Validação` | Checkout com Postal Code em branco | Erro: `Error: Postal Code is required` | ⚪ Pendente |
| **CT-CHK-05** | `Validação` | Checkout com todos os campos vazios | Validação em cascata do primeiro campo | ⚪ Pendente |
| **CT-CHK-06** | `Navegação` | Cancelar checkout na etapa 1 | Retorno para a rota `/cart.html` preservando itens | ⚪ Pendente |
| **CT-CHK-07** | `Navegação` | Cancelar checkout na etapa 2 (Resumo) | Retorno para a vitrine `/inventory.html` | ⚪ Pendente |
| **CT-CHK-08** | `Cálculo` | Validação matemática de Subtotal + Tax = Total | Conferência de centavos e impostos arredondados | ⚪ Pendente |
| **CT-CHK-09** | `Borda` | Checkout com carrinho vazio | Integridade da tela de resumo com valor `$0.00` | ⚪ Pendente |
| **CT-CHK-10** | `Borda` | Defeito no sobrenome com `problem_user` | Verificação do bloqueio de digitação no campo | ⚪ Pendente |

---

## 🛒 4. Carrinho de Compras (`03_carrinho.feature`)
> **Arquivo de Teste:** [`cypress/e2e/carrinho.cy.js`](file:///e:/Estudos/Cypress/E2ESwagLabs/cypress/e2e/carrinho.cy.js)  
> **Status:** 🟢 **100% Automatizado e validado** (8 de 8 cenários)

| ID | Tipo | Cenário BDD | Comportamento Esperado | Status |
| :---: | :---: | :--- | :--- | :---: |
| **CT-CAR-01** | `Smoke` | Adicionar item ao carrinho pela vitrine | Badge e botão do produto refletem a adição | 🟢 Validado |
| **CT-CAR-02** | `Funcional` | Adicionar múltiplos produtos | Badge exibe `3` | 🟢 Validado |
| **CT-CAR-03** | `Detalhes` | Adicionar produto pela tela de detalhes | Badge e botão refletem a adição ao voltar à vitrine | 🟢 Validado |
| **CT-CAR-04** | `Remoção` | Remover item pela vitrine | Botão restaura para `Add to cart` e badge desaparece | 🟢 Validado |
| **CT-CAR-05** | `Remoção` | Remover item de dentro da página do carrinho | Item removido, outro preservado e badge decrementado | 🟢 Validado |
| **CT-CAR-06** | `Navegação` | Retornar às compras pelo botão `Continue Shopping` | Redirecionamento para a vitrine | 🟢 Validado |
| **CT-CAR-07** | `Persistência` | Manter carrinho após recarregar a página | Badge permanece com `2` após reload | 🟢 Validado |
| **CT-CAR-08** | `Borda` | Acessar carrinho vazio | URL do carrinho, nenhum item e badge ausente | 🟢 Validado |

> **Ponto de atenção:** CT-CAR-07 está nomeado como finalização/checkout no código, mas valida persistência após recarregar. Alinhar o título para manter a rastreabilidade consistente.

---

## 🧭 5. Menu Lateral e Sessão (`05_menu_e_sessao.feature`)
> **Arquivo Alvo:** `cypress/e2e/menu.cy.js`  
> **Status:** ⚪ **0% Automatizado** (0 de 5 cenários)

| ID | Tipo | Cenário BDD | Comportamento Esperado | Status |
| :---: | :---: | :--- | :--- | :---: |
| **CT-MNU-01** | `UI` | Abertura e fechamento do menu lateral | Transição CSS e visibilidade dos 4 links | ⚪ Pendente |
| **CT-MNU-02** | `Sessão` | Logout pelo menu lateral | Destruição de sessão e bloqueio de botão Voltar | ⚪ Pendente |
| **CT-MNU-03** | `Estado` | Resetar estado da aplicação (`Reset App State`)| Limpeza do carrinho e reset de botões sem deslogar | ⚪ Pendente |
| **CT-MNU-04** | `Navegação` | Link All Items a partir de outras páginas | Retorno direto para `/inventory.html` | ⚪ Pendente |
| **CT-MNU-05** | `Externo` | Link About apontando para Sauce Labs | Atributo `href` direcionando para `saucelabs.com` | ⚪ Pendente |
