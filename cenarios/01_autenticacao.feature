# language: pt
Funcionalidade: Autenticação de Usuários
Como um cliente da loja virtual Swag Labs
Quero me autenticar com credenciais válidas ou ser notificado de falhas
Para garantir acesso seguro ao catálogo de produtos e compras

Contexto:
Dado que o usuário está na página inicial de autenticação

# ==========================================
# CENÁRIOS POSITIVOS (HAPPY PATH)
# ==========================================

@autenticacao @smoke @positivo
Cenário: Login bem-sucedido com usuário padrão
Quando o usuário preenche o campo "Username" com "standard_user"
E preenche o campo "Password" com "secret_sauce"
E clica no botão "Login"
Então deve ser redirecionado para a página "/inventory.html"
E a lista de produtos deve ser exibida com sucesso

# ==========================================
# CENÁRIOS NEGATIVOS (TRATAMENTO DE ERROS)
# ==========================================

@autenticacao @negativo
Cenário: Tentativa de login com usuário bloqueado
Quando o usuário preenche o campo "Username" com "locked_out_user"
E preenche o campo "Password" com "secret_sauce"
E clica no botão "Login"
Então o sistema deve exibir a mensagem de erro "Epic sadface: Sorry, this user has been locked out."
E o usuário deve permanecer na página de login

@autenticacao @negativo
Cenário: Tentativa de login com usuário inexistente
Quando o usuário preenche o campo "Username" com "usuario_nao_cadastrado"
E preenche o campo "Password" com "secret_sauce"
E clica no botão "Login"
Então o sistema deve exibir a mensagem de erro "Epic sadface: Username and password do not match any user in this service"

@autenticacao @negativo
Cenário: Tentativa de login com senha incorreta
Quando o usuário preenche o campo "Username" com "standard_user"
E preenche o campo "Password" com "senha_errada"
E clica no botão "Login"
Então o sistema deve exibir a mensagem de erro "Epic sadface: Username and password do not match any user in this service"

@autenticacao @negativo @validacao
Cenário: Tentativa de login sem informar o nome de usuário
Quando o usuário deixa o campo "Username" vazio
E preenche o campo "Password" com "secret_sauce"
E clica no botão "Login"
Então o sistema deve exibir a mensagem de erro "Epic sadface: Username is required"

@autenticacao @negativo @validacao
Cenário: Tentativa de login sem informar a senha
Quando o usuário preenche o campo "Username" com "standard_user"
E deixa o campo "Password" vazio
E clica no botão "Login"
Então o sistema deve exibir a mensagem de erro "Epic sadface: Password is required"

@autenticacao @negativo @validacao
Cenário: Tentativa de login com ambos os campos em branco
Quando o usuário deixa o campo "Username" vazio
E deixa o campo "Password" vazio
E clica no botão "Login"
Então o sistema deve exibir a mensagem de erro prioritária "Epic sadface: Username is required"

# ==========================================
# CENÁRIOS DE BORDA E SEGURANÇA
# ==========================================


@autenticacao @borda @seguranca
Cenário: Acesso direto à URL interna sem estar autenticado
Dado que o usuário não está autenticado no sistema
Quando tenta acessar a URL "/inventory.html" diretamente no navegador
Então o sistema deve bloquear o acesso e redirecionar para a página de login
E deve exibir a mensagem "Epic sadface: You can only access '/inventory.html' when you are logged in."

@autenticacao @borda @performance
Cenário: Login com usuário com degradação de performance
Quando o usuário preenche o campo "Username" com "performance_glitch_user"
E preenche o campo "Password" com "secret_sauce"
E clica no botão "Login"
Então a página "/inventory.html" deve ser carregada com sucesso mesmo com a latência de rede simulada

