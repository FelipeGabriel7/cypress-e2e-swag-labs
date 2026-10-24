# 🛒 Swag Labs - Automação de Testes E2E com Cypress

Projeto de automação de testes End-to-End (E2E) desenvolvido para a plataforma de e-commerce fictícia [Sauce Demo (Swag Labs)](https://www.saucedemo.com/), focado em demonstrar boas práticas de automação, escrita de testes limpos, reutilização de código e arquitetura modular.

---

## 🛠️ Tecnologias Utilizadas

- **[Cypress](https://www.cypress.io/)** (v16+) - Framework de automação E2E
- **[JavaScript (ES6+)](https://developer.mozilla.org/pt-BR/docs/Web/JavaScript)** - Linguagem de programação
- **Node.js** - Ambiente de execução JavaScript

---

## 🎯 Cenários de Teste Cobertos

### 🔐 1. Autenticação (`cypress/e2e/login.cy.js`)
- **Login com sucesso**: Autenticação com credenciais válidas e validação do carregamento da vitrine de produtos.
- **Login com usuário bloqueado**: Validação de mensagem de bloqueio (`Epic sadface: Sorry, this user has been locked out.`).
- **Login com usuário inválido**: Validação de mensagem de credenciais incorretas.

### 🛍️ 2. Home e Checkout (`cypress/e2e/home.cy.js`)
- **Adicionar item ao carrinho**: Validação da visibilidade do produto na vitrine, inclusão no carrinho e verificação da quantidade e nome no carrinho de compras.
- **Fluxo completo de compra (End-to-End)**:
  1. Login do usuário;
  2. Adição do produto ao carrinho com validação de preço;
  3. Preenchimento dos dados do comprador no checkout;
  4. Validação do resumo do pedido (método de pagamento e subtotal);
  5. Conclusão da ordem de compra e retorno à página inicial.

---

## 💡 Boas Práticas Aplicadas

- **Especificação Viva em BDD (Gherkin)**: Matriz de cenários estruturada em formato BDD no arquivo `CENARIOS_BDD.md`, servindo de guia funcional para a automação.
- **Seletores Baseados em Atributos de Teste**: Priorização de seletores com `[data-test="..."]`, garantindo robustez e imunidade a alterações de estilo CSS.
- **Custom Commands**: Centralização de fluxos repetitivos no arquivo `commands.js`:
  - `cy.goPage()`: Navegação para a URL base.
  - `cy.loginUser(user, password)`: Fluxo de autenticação reutilizável.
  - `cy.pageIsVisible()`: Validação da exibição da listagem de produtos.
  - `cy.addItemCart(quantity, price)`: Inclusão e validação parametrizada de itens no carrinho.
- **Asserções Encadeadas**: Uso idiomático do Chai/Mocha (`.should().and()`) para validações atômicas e declarativas.

---

## 📁 Estrutura do Projeto

```plaintext
E2ESwagLabs/
├── cypress/
│   ├── e2e/
│   │   ├── login.cy.js        # Testes de autenticação
│   │   └── home.cy.js         # Testes de vitrine, carrinho e checkout
│   ├── fixtures/              # Massas de dados (quando aplicável)
│   └── support/
│       ├── commands.js        # Comandos customizados reutilizáveis
│       └── e2e.js             # Configurações globais de suporte
├── cenarios/                  # Especificação BDD e Regras de Negócio
│   ├── REGRAS_E_SISTEMA.md    # Documento de regras, rotas e perfis de usuário
│   ├── 01_autenticacao.feature
│   ├── 02_catalogo_produtos.feature
│   ├── 03_carrinho.feature
│   ├── 04_checkout.feature
│   └── 05_menu_e_sessao.feature
├── PROGRESSO_AUTOMACAO.md     # Checklist e métricas de cobertura dos testes
├── CYPRESS_ESTUDOS.md         # Documento detalhado de conceitos e aprendizados
├── cypress.config.js          # Configurações do Cypress
├── package.json               # Dependências e scripts de execução
├── .gitignore                 # Arquivos ignorados pelo Git
└── README.md                  # Documentação principal do repositório
```

---

## 🚀 Como Executar o Projeto

### Pré-requisitos
- [Node.js](https://nodejs.org/) instalado (versão 18 ou superior recomendada)
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

- **Modo Interativo (Interface Gráfica do Cypress):**
  ```bash
  npm run cypress:open
  ```

- **Modo Headless (Execução rápida via terminal):**
  ```bash
  npm test
  # ou
  npm run cypress:run
  ```

---

## 👤 Autor

Desenvolvido por **Felipe Gabriel**  
Projeto para portfólio de Qualidade de Software / Automação de Testes.
