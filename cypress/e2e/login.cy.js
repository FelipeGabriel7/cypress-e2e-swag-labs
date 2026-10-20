/// <reference types="cypress" />

describe("Login no Swag Labs com usuários válidos e inválidos", () => {
  beforeEach(() => {
    cy.goPage();
  });

  it("Login Valido", () => {
    cy.loginUser("standard_user", "secret_sauce");
    cy.pageIsVisible();
  });

  it("Login com usuário bloqueado", () => {
    cy.loginUser("locked_out_user", "secret_sauce");
    cy.get('[data-test="error"]')
      .should("be.visible")
      .and("have.text", "Epic sadface: Sorry, this user has been locked out.");
  });

  it("Login com um usuário inválido", () => {
    cy.loginUser("teste", "teste");
    cy.get('[data-test="error"]')
      .should("be.visible")
      .and(
        "have.text",
        "Epic sadface: Username and password do not match any user in this service",
      );
  });
});
