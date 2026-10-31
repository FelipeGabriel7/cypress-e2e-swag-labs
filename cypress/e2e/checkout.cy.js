// describe("Checkout - Validação do Fluxo de checkout", () => {
//   beforeEach(() => {
//     cy.goPage();
//     cy.loginUser("standard_user", "secret_sauce");
//     cy.pageIsVisible();
//   });

//   it("Finaliza a compra de um produto com sucesso", () => {
//     cy.addItemCart("Sauce Labs Backpack");

//     cy.get('[data-test="checkout"]').click();
//     cy.get('[data-test="firstName"]').type("Felipe");
//     cy.get('[data-test="lastName"]').type("Gabriel");
//     cy.get('[data-test="postalCode"]').type("12345678");
//     cy.get('[data-test="continue"]').click();

//     cy.get('[data-test="payment-info"]').should("be.visible");
//     cy.get('[data-test="subtotal-label"]').should("contain.text", "29.99");

//     cy.get('[data-test="finish"]').click();
//     cy.get('[data-test="complete-header"]')
//       .should("be.visible")
//       .and("have.text", "Thank you for your order!");

//     cy.get('[data-test="back-to-products"]').click();
//     cy.pageIsVisible();
//   });
// });
