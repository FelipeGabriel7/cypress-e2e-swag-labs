describe("Checkout - Validação do Fluxo de checkout", () => {
  beforeEach(() => {
    cy.goPage();
  });

  it("Finalizar o checkout com o item adicionado ao carrinho", () => {
    cy.loginUser("standard_user", "secret_sauce");
    cy.pageIsVisible();
    cy.addItemCart(1, 29.99);
    cy.get('[data-test="checkout"]').click();
    cy.get('input[name="firstName"]').type("Felipe");
    cy.get('input[name="lastName"]').type("Gabriel");
    cy.get("#postal-code").type("12345678");
    cy.get("#continue").click();
    // Validar se existe as informações de pagamento
    cy.get(".summary_info").should("be.visible");
    // Validar o valor
    cy.get(".summary_subtotal_label").should("contain.text", "29.99");
    cy.get('button[name="finish"]').click();
    cy.get('button[name="back-to-products"]').click();
    cy.pageIsVisible();
  });
});
