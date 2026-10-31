import { ROUTES } from "../support/routes";

describe("Carrinho - Testes de funcionalidade do carrinho de compras", () => {
  beforeEach(() => {
    cy.goPage();
    cy.loginUser("standard_user", "secret_sauce");
  });

  it("CT-CR-01 - Adicionar produto ao carrinho", () => {
    cy.addItemCart("Sauce Labs Backpack");
    cy.get(".shopping_cart_badge").should("have.text", "1");
    cy.get("button[name='remove-sauce-labs-backpack']").should(
      "have.text",
      "Remove",
    );
  });

  it("CT-CR-02 - Adicionar múltiplos produtos e validar contador do badge", () => {
    cy.addItemCart("Sauce Labs Backpack");
    cy.addItemCart("Sauce Labs Bike Light");
    cy.addItemCart("Sauce Labs Bolt T-Shirt");
    cy.get(".shopping_cart_badge").should("have.text", "3");
  });

  it("CT-CR-03 - Adicionar produto a partir da tela de detalhes", () => {
    cy.contains(".inventory_item_name", "Sauce Labs Fleece Jacket").click();
    cy.get("#add-to-cart").click();
    cy.get(".shopping_cart_badge").should("have.text", "1");
    cy.get("button[name='back-to-products']").click();
    cy.get("#remove-sauce-labs-fleece-jacket").should("have.text", "Remove");
  });

  it("CT-CR-04 - Remover produto do carrinho direto pela vitrine", () => {
    cy.addItemCart("Sauce Labs Backpack");
    cy.get(".shopping_cart_badge").should("have.text", "1");
    cy.removeItemCart("Sauce Labs Backpack");
    cy.get(".shopping_cart_badge").should("not.exist");
    cy.get("button[name='add-to-cart-sauce-labs-backpack']").should(
      "have.text",
      "Add to cart",
    );
  });

  it("CT-CR-05 - Remover produto do carrinho a partir da tela do carrinho", () => {
    cy.addItemCart("Sauce Labs Backpack");
    cy.addItemCart("Sauce Labs Bike Light");
    cy.get(".shopping_cart_badge").should("have.text", "2");
    cy.get(".shopping_cart_link").click();
    cy.get("#remove-sauce-labs-backpack").click();
    cy.contains(".inventory_item_name", "Sauce Labs Backpack").should(
      "not.exist",
    );
    cy.contains(".inventory_item_name", "Sauce Labs Bike Light").should(
      "be.visible",
    );
    cy.get(".shopping_cart_badge").should("have.text", "1");
  });

  it("CT-CR-06 - Retornar às compras através do botão 'Continue Shopping'", () => {
    cy.goPage(ROUTES.CART_PAGE);
    cy.url().should("eq", ROUTES.CART_PAGE);
    cy.get('button[name="continue-shopping"]').click();
    cy.url().should("eq", ROUTES.INITIAL_PAGE);
  });

  it("CT-CR-07 - Finalizar compra e validar redirecionamento para a tela de checkout", () => {
    cy.addItemCart("Sauce Labs Backpack");
    cy.addItemCart("Sauce Labs Bike Light");
    cy.get(".shopping_cart_badge").should("have.text", "2");
    cy.reload();
    cy.get(".shopping_cart_badge").should("have.text", "2");
  });

  it("CT-CR-08 - Acessar a página do carrinho vazio e validar se não existe nenhum item", () => {
    cy.OpenCart();
    cy.url().should("eq", ROUTES.CART_PAGE);
    cy.get(".cart_item").should("have.length", 0);
    cy.get(".shopping_cart_badge").should("not.exist");
  });
});
