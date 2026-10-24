# 🛒 Swag Labs - Automação de Testes E2E com Cypress

Projeto de automação de testes End-to-End (E2E) desenvolvido para a plataforma de e-commerce [Sauce Demo (Swag Labs)](https://www.saucedemo.com/), focado em demonstrar arquitetura modular, boas práticas de Quality Assurance (QA), cobertura com BDD (Gherkin), relatórios visuais com **Allure Report** e pipeline de **Integração Contínua (CI/CD)** via **GitHub Actions**.

[![Cypress](https://img.shields.io/badge/Cypress-16.2.0-04C38C?style=for-the-badge&logo=cypress&logoColor=white)](https://www.cypress.io/)
[![JavaScript](https://img.shields.io/badge/JavaScript-ES6+-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)](https://developer.mozilla.org/)
[![Status](https://img.shields.io/badge/Cobertura_E2E-48.6%25_(18/37)-blue?style=for-the-badge)](./PROGRESSO_AUTOMACAO.md)
[![Allure Report](https://img.shields.io/badge/Report-Allure-F28D1A?style=for-the-badge&logo=qameta&logoColor=white)](https://qameta.io/)
[![CI/CD](https://img.shields.io/badge/CI%2FCD-GitHub_Actions-2088FF?style=for-the-badge&logo=githubactions&logoColor=white)](./.github/workflows/e2e-tests.yml)

---

## 📊 Dashboard de Progresso

Os cenários de teste são baseados em especificações vivas escritas em **Gherkin (`.feature`)** na pasta [`cenarios/`](./cenarios/).  
Para conferir a matriz completa com todos os casos de teste, acesse o [**PROGRESSO_AUTOMACAO.md**](./PROGRESSO_AUTOMACAO.md).

```text
Status Geral: [█████████████░░░░░░░░░░░░] 48.6% (18 de 37 cenários)
• Autenticação (Login)  : 100% (9/9)   🟢 CONCLUÍDO
• Catálogo e Detalhes   : 100% (8/8)   🟢 CONCLUÍDO
• Checkout e Compra     : 10.0% (1/10) ⚪ INICIADO
• Carrinho de Compras   : 0.0%  (0/5)  ⚪ PLANEJADO
• Menu Lateral e Sessão : 0.0%  (0/5)  ⚪ PLANEJADO
```

---

## 🚀 Integração Contínua (CI/CD - GitHub Actions)

O projeto conta com um workflow automatizado em [`.github/workflows/e2e-tests.yml`](./.github/workflows/e2e-tests.yml) que é disparado a cada `push` ou `pull_request` nos branches `main` e `master`:

1. **Ambiente Limpo**: Executa em contêiner `ubuntu-latest` com Node.js v20.
2. **Instalação Estrita**: Utiliza `npm ci` para garantir reprodução idêntica das dependências.
3. **Execução Headless**: Roda todos os testes de ponta a ponta sem interface gráfica.
4. **Relatório Allure**: Gera o `allure-report` automaticamente ao final da execução.
5. **Armazenamento de Artefatos**: Publica o relatório do Allure e screenshots de falhas para download direto na aba *Actions* do GitHub.

---

## 📊 Relatórios Visuais com Allure Report

O projeto utiliza a integração oficial **`allure-cypress`** da Qameta Software para geração de relatórios com gráficos, histórico e rastreabilidade:

- **Gerar e abrir o relatório no navegador com servidor local:**
  ```bash
  npm run allure:serve
  ```
- **Gerar a pasta estática do relatório (`allure-report`):**
  ```bash
  npm run allure:generate
  ```
- **Abrir relatório estático já compilado:**
  ```bash
  npm run allure:open
  ```

---

## 🎯 Cenários de Teste Automatizados

### 🔐 1. Autenticação e Segurança ([`cypress/e2e/login.cy.js`](./cypress/e2e/login.cy.js)) - 100% Concluído
- **CT-01**: Login com credenciais válidas e validação de redirecionamento.
- **CT-02**: Login com usuário bloqueado (`LOCKED_USER`).
- **CT-03**: Login com usuário inexistente (`INVALID_USER`).
- **CT-04**: Login com senha incorreta e usuário válido.
- **CT-05**: Tentativa de login com campo *Username* vazio (`USERNAME_REQUIRED`).
- **CT-06**: Tentativa de login com campo *Password* vazio (`PASSWORD_REQUIRED`).
- **CT-07**: Tentativa de login com ambos os campos em branco.
- **CT-08**: Tentativa de acesso direto à URL protegida (`/inventory.html`) sem sessão ativa, com tratamento de status HTTP e verificação de bloqueio.
- **CT-09**: Autenticação com perfil de lentidão severa (`performance_glitch_user`), utilizando timeouts dinâmicos (`{ timeout: 10000 }`) sem esperas estáticas.

### 📦 2. Catálogo e Vitrine ([`cypress/e2e/home.cy.js`](./cypress/e2e/home.cy.js)) - 100% Concluído
- **CT-HM-01**: Visualização completa da vitrine validando a presença dos 6 produtos e inspecionando imagem, texto e barra de preços de cada item via laço `.each()` e `cy.wrap()`.
- **CT-HM-02**: Navegação para a página de detalhes através do título do produto (*Sauce Labs Backpack*), conferindo rota, nome, descrição, preço e retorno à vitrine.
- **CT-HM-03**: Navegação para a página de detalhes através de clique na imagem usando seletor semântico de acessibilidade (`img[alt="..."]`) e validação do botão de compra.
- **CT-HM-04**: Ordenação por **Menor Preço** (*Price low to high*), validando o primeiro item (`$7.99`) e o último (`$49.99`) com escopo `.within()`.
- **CT-HM-05**: Ordenação por **Maior Preço** (*Price high to low*), validando o primeiro item (`$49.99`) e o último (`$7.99`) com escopo `.within()`.
- **CT-HM-06**: Ordenação por **Nome de Z a A** (*Name Z to A*), validando o primeiro item (`Test.allTheThings()...`) e o último (`Backpack`).
- **CT-HM-07**: Ordenação por **Nome de A a Z** (*Name A to Z*), restaurando a ordem alfabética padrão da vitrine.
- **CT-HM-08 (Borda / Defeito Conhecido)**: Validação de imagens quebradas no perfil `problem_user`, inspecionando o atributo `src` com `.should('have.attr', 'src').and('include', 'sl-404')`.

### 💳 3. Checkout e Transações ([`cypress/e2e/checkout.cy.js`](./cypress/e2e/checkout.cy.js))
- **CT-CHK-01**: Fluxo completo de compra de ponta a ponta (*Happy Path*): login $\rightarrow$ inclusão de produto com validação de valor $\rightarrow$ preenchimento de endereço de entrega $\rightarrow$ conferência de subtotal $\rightarrow$ finalização com sucesso.

---

## 💡 Boas Práticas e Padrões Aplicados

- **Especificação Viva em BDD (Gherkin)**: Criação de arquivos `.feature` na pasta `cenarios/` com mapeamento de regras funcionais e comportamentos esperados.
- **Isolamento de Contextos (`context` e `beforeEach`)**: Separação de estados de autenticação por perfil de usuário (`standard_user` vs `problem_user`) em blocos `context()` dedicados.
- **Centralização de Constantes (Helpers)**:
  - [`messages.js`](./cypress/support/messages.js): Dicionário de mensagens de erro do sistema (`LOGIN_MESSAGES`), eliminando *magic strings*.
  - [`routes.js`](./cypress/support/routes.js): Mapeamento centralizado de rotas e URLs da aplicação (`ROUTES`).
- **Comandos Customizados (Custom Commands)**:
  - `cy.loginUser(user, password)`: Tratamento com operadores ternários para simular campos em branco sem quebrar o `.type()`.
  - `cy.goPage(url)`: Navegação configurada com `{ failOnStatusCode: false }` para contornar limitações de SPA no GitHub Pages.
  - `cy.pageIsVisible()` e `cy.addItemCart(quantity, price)`: Reutilização de passos frequentes.
- **Retry-ability e Ausência de Waits Estáticos**: Zero uso de `cy.wait(tempo)`. Todos os cenários assíncronos e lentos utilizam a capacidade de repetição nativa do Cypress.
- **Tipagem Global com `jsconfig.json`**: Configuração na raiz para autocompletar IntelliSense em todos os arquivos sem poluir o código com diretivas repetitivas.
- **Seletores Baseados em `data-test` e Acessibilidade**: Priorização de seletores de teste e atributos semânticos (`alt`, `data-test`, `name`).

---

## 📁 Estrutura do Projeto

```plaintext
E2ESwagLabs/
├── .github/
│   └── workflows/
│       └── e2e-tests.yml      # Pipeline CI/CD do GitHub Actions
├── cenarios/                  # Especificação BDD e Regras de Negócio
│   ├── REGRAS_E_SISTEMA.md    # Documento de regras funcionais, rotas e perfis
│   ├── 01_autenticacao.feature
│   ├── 02_catalogo_produtos.feature
│   ├── 03_carrinho.feature
│   ├── 04_checkout.feature
│   └── 05_menu_e_sessao.feature
├── cypress/
│   ├── e2e/
│   │   ├── login.cy.js        # Testes de autenticação e segurança (9 cenários)
│   │   ├── home.cy.js         # Testes de vitrine, catálogo e detalhes (8 cenários)
│   │   └── checkout.cy.js     # Testes de checkout e conclusão de compra (1 cenário)
│   ├── fixtures/              # Massas de dados
│   └── support/
│       ├── commands.js        # Comandos customizados reutilizáveis
│       ├── messages.js        # Dicionário de mensagens de validação
│       ├── routes.js          # Centralização das rotas do sistema
│       └── e2e.js             # Configurações globais de suporte e Allure
├── PROGRESSO_AUTOMACAO.md     # Dashboard com matriz de rastreabilidade de testes
├── CYPRESS_ESTUDOS.md         # Guia técnico e anotações de aprendizado
├── jsconfig.json              # Tipagem global do Cypress para VS Code
├── cypress.config.js          # Configurações de execução do Cypress e Allure Reporter
├── package.json               # Dependências, scripts npm e Allure CLI
├── .gitignore                 # Arquivos ignorados pelo Git (node_modules, allure, etc)
└── README.md                  # Documentação principal do repositório
```

---

## 🚀 Como Executar o Projeto

### Pré-requisitos
- [Node.js](https://nodejs.org/) instalado (v18+)
- Git instalado

### 1. Clonar o repositório
```bash
git clone https://github.com/SEU-USUARIO/E2ESwagLabs.git
cd E2ESwagLabs
```

### 2. Instalar as dependências
```bash
npm install
```

### 3. Executar os testes

- **Modo Interativo (Cypress Test Runner):**
  ```bash
  npm run cypress:open
  ```

- **Modo Headless (Terminal):**
  ```bash
  npm test
  # ou
  npm run cypress:run
  ```

- **Visualizar Relatório Allure após os testes:**
  ```bash
  npm run allure:serve
  ```

---

## 👤 Autor

Desenvolvido por **Felipe Gabriel**  
Projeto prático para portfólio de Qualidade de Software / Automação de Testes E2E.
