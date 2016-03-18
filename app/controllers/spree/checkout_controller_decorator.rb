Spree::CheckoutController.class_eval do
  # Updates the order and advances to the next state (when possible.)
  before_action :set_onestep_params, only: [:update], if: :one_step?

  def update
    if @order.update_from_params(params, permitted_checkout_attributes, request.headers.env)
      @order.comment = comment_params[:comment] if comment_params[:comment].present?
      @order.temporary_address = !params[:save_user_address]
      @order.persist_user_address!
      
      unless @order.next
        respond_to do |format|
          format.html do
            flash[:error] = @order.errors.full_messages.join("\n")
            redirect_to(checkout_state_path(@order.state)) && return
          end
          format.js { head :ok }
        end
      end

      if @order.completed?
        @order.comment = comment_params[:comment] if comment_params[:comment].present?
        @current_order = nil
        flash.notice = Spree.t(:order_processed_successfully)
        flash['order_completed'] = true
        redirect_to completion_route
      else
        respond_to do |format|
          format.html {redirect_to checkout_state_path(@order.state)}
          format.js { head :ok }
        end
      end
    else
      respond_to do |format|
        format.html {render :edit}
        format.js { head :not_acceptable }
      end
    end
  end

  def before_one_step
    @order.bill_address ||= user_bill_address
    @order.ship_address ||= user_ship_address

    @shipping_method = Spree::ShippingMethod.find_by_id(params[:shipping_method_id]) || Spree::ShippingMethod.first
    #@order.payments.destroy_all if request.put?
  end

  def comment_params
    params.require(:order).permit(:comment)
  end

  def user_bill_address
    spree_current_user.nil? || spree_current_user.bill_address.nil? ? Spree::Address.build_default : spree_current_user.bill_address
  end

  def user_ship_address
    spree_current_user.nil? || spree_current_user.ship_address.nil? ? Spree::Address.build_default : spree_current_user.ship_address
  end

  private

  def set_onestep_params
    params.require(:order).require(:bill_address_attributes)[:lastname] = params.require(:order).require(:bill_address_attributes)[:firstname]
    params.require(:order).require(:bill_address_attributes)[:city] = params.require(:order).require(:bill_address_attributes)[:address1]
  end

  def one_step?
    params[:state] == 'one_step'
  end
end
