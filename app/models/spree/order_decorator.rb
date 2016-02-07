Spree::Order.class_eval do
  DEFAULT_SHIPPING_CALCULATOR = 'Spree::RussianPost::Calculator'

  insert_checkout_step :one_step, before: :address

  remove_checkout_step :address
  remove_checkout_step :delivery
  remove_checkout_step :payment
  remove_checkout_step :confirm


end
