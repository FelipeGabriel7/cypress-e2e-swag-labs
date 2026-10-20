Cypress.Commands.add("loginUser", (user, password) => {
  cy.get("[data-test='username']").type(user);
  cy.get("[data-test='password']").type(password);
  cy.get("[value='Login']").click();
});

Cypress.Commands.add("goPage", () => {
  cy.visit("https://www.saucedemo.com/");
});

Cypress.Commands.add("pageIsVisible", () => {
  cy.get('[data-test="inventory-container"]').should("be.visible");
});

Cypress.Commands.add("addItemCart", (quantity = 1, price = 0) => {
  cy.contains(".inventory_item", "Sauce Labs Backpack").should("be.visible");
  cy.get("#add-to-cart-sauce-labs-backpack").click();
  cy.get('[data-test="shopping-cart-link"]').click();
  cy.get('[data-test="inventory-item-name"]').should("be.visible");
  cy.get('[data-test="item-quantity"]').should("have.text", quantity);

  if (price !== 0) {
    const convert = "$" + price;
    cy.get('[data-test="inventory-item-price"]')
      .should("be.visible")
      .and("have.text", convert);
  }
});
