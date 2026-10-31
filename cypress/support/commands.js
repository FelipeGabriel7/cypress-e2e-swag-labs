Cypress.Commands.add("loginUser", (user, password) => {
  user ? cy.get("[data-test='username']").type(user) : "";
  password ? cy.get("[data-test='password']").type(password) : "";
  cy.get("[value='Login']").click();
});

Cypress.Commands.add("goPage", (url = "https://www.saucedemo.com/") => {
  cy.visit(url, { failOnStatusCode: false });
});

Cypress.Commands.add("pageIsVisible", () => {
  cy.get('[data-test="inventory-container"]').should("be.visible");
});

Cypress.Commands.add("addItemCart", (productName) => {
  cy.contains(".inventory_item", productName)
    .should("be.visible")
    .within(() => {
      cy.get('[data-test^="add-to-cart"]').click();
    });
});

Cypress.Commands.add("OpenCart", () => {
  cy.get(".shopping_cart_link").click();
});

Cypress.Commands.add("removeItemCart", (productName) => {
  cy.contains(".inventory_item", productName)
    .should("be.visible")
    .within(() => {
      cy.get('[data-test^="remove"]').click();
    });
});
