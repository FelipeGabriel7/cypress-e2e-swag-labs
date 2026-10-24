import { ROUTES } from "../support/routes";

describe("Home - Visualização da Tela inicial e adicionar um item ao carrinho", () => {
  beforeEach(() => {
    cy.goPage();
    cy.loginUser("standard_user", "secret_sauce");
    cy.pageIsVisible();
  });

  it("CT-HM-01 - Visualização completa do catálogo padrão", () => {
    cy.get(".inventory_item_name").should("have.length", 6);
    cy.get(".inventory_item").each((item) => {
      cy.wrap(item).find(".inventory_item_img").should("be.visible");
      cy.wrap(item).find(".inventory_item_label").should("be.visible");
      cy.wrap(item).find(".pricebar").should("be.visible");
    });
  });

  it("CT-HM-02 - Acessar a página de detalhes clicando no título de um produto", () => {
    cy.contains(".inventory_item_name", "Sauce Labs Backpack").click();
    cy.url().should("eq", ROUTES.ITEM_PAGE);
    cy.contains(".inventory_details_name", "Sauce Labs Backpack").should(
      "be.visible",
    );
    cy.get(".inventory_details_desc").should("be.visible");
    cy.get(".inventory_details_price")
      .should("be.visible")
      .and("have.text", "$29.99");
    cy.get('img[alt="Sauce Labs Backpack"]').should("be.visible");
    cy.get("#back-to-products").click();
    cy.url().should("eq", ROUTES.INITIAL_PAGE);
    cy.get(".inventory_item_name").should("have.length", 6);
  });

  it("CT-HM-03 - Acessar a página de detalhes clicando na imagem de um produto", () => {
    cy.get('img[alt="Sauce Labs Bike Light"]').click();
    cy.url().should("eq", ROUTES.OTHER_ITEM);
    cy.get(".inventory_details_desc_container").should("be.visible");
    cy.get("#add-to-cart").should("be.visible");
  });
});
