class CheckoutController < ApplicationController
  before_action :set_stripe_key
  def create
    # configurer la clé secrète Stripe
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    # Créer une session de paiement Stripe
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'eur',
          unit_amount: 2000, # 20€ en centimes
          product_data: {
            name: 'T-shirt personnalisé',
          },
        },
        quantity: 1,
      }],
      mode: 'payment',
      success_url: root_url + 'success',
      cancel_url: root_url + 'cancel',
    )

    render json: { id: session.id }
  end
end
