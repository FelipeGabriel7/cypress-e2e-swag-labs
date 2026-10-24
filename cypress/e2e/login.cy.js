import { LOGIN_MESSAGES } from "../support/messages";
import { ROUTES } from "../support/routes";

describe("Login no Swag Labs com usuários válidos e inválidos", () => {
  beforeEach(() => {
    cy.goPage();
  });

  it("CT-01 - Login com usuário Válido", () => {
    cy.loginUser("standard_user", "secret_sauce");
    cy.url().should("eq", ROUTES.INITIAL_PAGE);
    cy.pageIsVisible();
  });

  it("CT-02 - Login com usuário bloqueado", () => {
    cy.loginUser("locked_out_user", "secret_sauce");
    cy.get('[data-test="error"]')
      .should("be.visible")
      .and("have.text", LOGIN_MESSAGES.LOCKED_USER);
  });

  it("CT-03 - Login com um usuário inexistente", () => {
    cy.loginUser("teste", "teste");
    cy.get('[data-test="error"]')
      .should("be.visible")
      .and("have.text", LOGIN_MESSAGES.INVALID_USER);
  });

  it("CT04 - Login com senha incorreta e usuario válido", () => {
    cy.loginUser("standard_user", "teste");
    cy.get(".error-message-container")
      .should("be.visible")
      .and("have.text", LOGIN_MESSAGES.INVALID_USER);
  });

  it("CT05 - Login sem preencher o campo Username", () => {
    cy.loginUser("", "secret_sauce");
    cy.get("[data-test='error']")
      .should("be.visible")
      .and("have.text", LOGIN_MESSAGES.USERNAME_REQUIRED);
  });

  it("CT06 - Login sem preencher o campo Password", () => {
    cy.loginUser("standard_user", "");
    cy.get(".error-message-container")
      .should("be.visible")
      .and("have.text", LOGIN_MESSAGES.PASSWORD_REQUIRED);
  });

  it("CT07 - Login sem preencher o campo Username e Password", () => {
    cy.loginUser("", "");
    cy.get(".error-message-container")
      .should("be.visible")
      .and("have.text", LOGIN_MESSAGES.USERNAME_REQUIRED);
  });

  it("CT08 - Acessar a url diretamente", () => {
    cy.goPage(ROUTES.INITIAL_PAGE);
    cy.get(".error-message-container").should(
      "have.text",
      LOGIN_MESSAGES.BLOCK_ACCESS_URL,
    );
    cy.url().should("eq", ROUTES.LOGIN_PAGE);
  });

  it("CT09 - Login com um usuário que possui degradação de performance", () => {
    cy.loginUser("performance_glitch_user", "secret_sauce");
    cy.url({ timeout: 10000 }).should("include", "/inventory.html");
    cy.get("#inventory_container", { timeout: 10000 }).should("be.visible");
  });
});
