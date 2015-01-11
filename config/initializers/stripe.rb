Rails.configuration.stripe = {
  :publishable_key => 'pk_test_kqnIs2hgJxMPfAb89tGIOTg6',
  :secret_key      => 'sk_test_c9YlfaiT0uYtNlX4eppfrMjN'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]