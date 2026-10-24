import { ROUTES } from "../support/routes";

describe("Home - Tela inicial, visualização única e ordenação de produtos", () => {
  context("Usuario padrão (standard_user)", () => {
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

    it("CT-HM-04 - Ordenar produtos por Menor Preço (Price low to high)", () => {
      cy.get('[data-test="product-sort-container"]').select("lohi");

      cy.get(".inventory_item")
        .first()
        .within(() => {
          cy.get(".inventory_item_name").should(
            "have.text",
            "Sauce Labs Onesie",
          );
          cy.get(".inventory_item_price").should("have.text", "$7.99");
        });

      cy.get(".inventory_item")
        .last()
        .within(() => {
          cy.get(".inventory_item_name").should(
            "have.text",
            "Sauce Labs Fleece Jacket",
          );
          cy.get(".inventory_item_price").should("have.text", "$49.99");
        });
    });

    it("CT-HM-05 - Ordenar produtos por Maior Preço (Price high to low)", () => {
      cy.get('[data-test="product-sort-container"]').select("hilo");

      cy.get(".inventory_item")
        .last()
        .within(() => {
          cy.get(".inventory_item_name").should(
            "have.text",
            "Sauce Labs Onesie",
          );
          cy.get(".inventory_item_price").should("have.text", "$7.99");
        });

      cy.get(".inventory_item")
        .first()
        .within(() => {
          cy.get(".inventory_item_name").should(
            "have.text",
            "Sauce Labs Fleece Jacket",
          );
          cy.get(".inventory_item_price").should("have.text", "$49.99");
        });
    });

    it("CT-HM-06 - Ordenar produtos por Nome de Z a A (Name Z to A)", () => {
      cy.get('[data-test="product-sort-container"]').select("za");

      cy.get(".inventory_item")
        .first()
        .within(() => {
          cy.get(".inventory_item_name").should(
            "have.text",
            "Test.allTheThings() T-Shirt (Red)",
          );
        });

      cy.get(".inventory_item")
        .last()
        .within(() => {
          cy.get(".inventory_item_name").should(
            "have.text",
            "Sauce Labs Backpack",
          );
        });
    });

    it("CT-HM-07 - Ordenar produtos por Nome de A a Z (Name A to Z)", () => {
      cy.get('[data-test="product-sort-container"]').select("az");

      cy.get(".inventory_item")
        .last()
        .within(() =>
          cy
            .get(".inventory_item_name")
            .should("have.text", "Test.allTheThings() T-Shirt (Red)"),
        );

      cy.get(".inventory_item")
        .first()
        .within(() =>
          cy
            .get(".inventory_item_name")
            .should("have.text", "Sauce Labs Backpack"),
        );
    });
  });

  context("Usuario com problema (problem_user)", () => {
    beforeEach(() => {
      cy.goPage();
      cy.loginUser("problem_user", "secret_sauce");
      cy.pageIsVisible();
    });

    it("CT-HM-08 - Usuario com problema na visualização de imagens", () => {
      cy.get(".inventory_item").each((item) => {
        cy.wrap(item)
          .find(".inventory_item_img img")
          .should("have.attr", "src")
          .and("include", "sl-404");
      });
    });
  });
});
