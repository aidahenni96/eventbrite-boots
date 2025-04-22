document.addEventListener("DOMContentLoaded", () => {
  const stripe = Stripe("VOTRE_CLE_PUBLIQUE_STRIPE"); // Remplacez par votre clé publique Stripe

  const checkoutButton = document.getElementById("checkout-button");
  if (checkoutButton) {
    checkoutButton.addEventListener("click", function () {
      fetch("/checkout/create-checkout-session", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
      })
        .then((response) => response.json())
        .then((session) => {
          return stripe.redirectToCheckout({ sessionId: session.id });
        })
        .then((result) => {
          if (result.error) {
            alert(result.error.message);
          }
        })
        .catch((error) => {
          console.error("Erreur lors de la création de la session de paiement :", error);
        });
    });
  }
});