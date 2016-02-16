Spree::CheckoutController.class_eval do
  # Updates the order and advances to the next state (when possible.)
  def update
    if @order.update_from_params(params, permitted_checkout_attributes, request.headers.env)
      @order.temporary_address = !params[:save_user_address]
      unless @order.next
        flash[:error] = @order.errors.full_messages.join("\n")
        redirect_to(checkout_state_path(@order.state)) && return
      end

      if @order.completed?
        @order.comment = comment_params[:comment] if comment_params[:comment].present?
        @current_order = nil
        flash.notice = Spree.t(:order_processed_successfully)
        flash['order_completed'] = true
        redirect_to completion_route
      else
        redirect_to checkout_state_path(@order.state)
      end
    else
      render :edit
    end
  end

  def before_one_step
    @order.bill_address ||= (spree_current_user.bill_address || Spree::Address.build_default)
    @order.ship_address ||= (spree_current_user.ship_address || Spree::Address.build_default)

    @shipping_method = Spree::ShippingMethod.find_by_id(params[:shipping_method_id]) || Spree::ShippingMethod.first
    #@order.payments.destroy_all if request.put?
  end

  def comment_params
    params.require(:order).require(:comments).permit(:comment)
  end
end
