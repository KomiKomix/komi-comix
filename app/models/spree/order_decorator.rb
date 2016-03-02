Spree::Order.class_eval do
  DEFAULT_SHIPPING_CALCULATOR = 'Spree::RussianPost::Calculator'

  insert_checkout_step :one_step, before: :address

  remove_checkout_step :address
  remove_checkout_step :delivery
  #remove_checkout_step :payment
  remove_checkout_step :confirm


  def comment
    comments.first.comment
  end

  def comment=(text)
    if comments.empty?
      comments.create(comment: text, user_id: user_id)
    else
      comment = comments.first
      comment.comment = text
      comment.save
    end
  end

end
