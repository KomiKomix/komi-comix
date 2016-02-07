Spree::OrdersController.class_eval do
  before_filter :calc_delivery, only: [:edit, :populate, :destroy_line_item]
  #rescue_from ActiveRecord::RecordNotFound, with: :page_not_found

  # Adds a new item to the order (creating a new order if none already exists)
  def populate
    order    = current_order(create_order_if_necessary: true)
    variant  = Spree::Variant.find(params[:variant_id])
    quantity = params[:quantity].to_i
    options  = params[:options] || {}

    # 2,147,483,647 is crazy. See issue #2695.
    if quantity.between?(1, 2_147_483_647)
      begin
        order.contents.add(variant, quantity, options)
      rescue ActiveRecord::RecordInvalid => e
        error = e.record.errors.full_messages.join(", ")
      end
    else
      error = Spree.t(:please_enter_reasonable_quantity)
    end

    if error
      flash[:error] = error
      redirect_back_or_default(spree.root_path)
    else
      respond_with(order) do |format|
        format.html { redirect_to cart_path }
        format.js
      end
    end
  end

  def destroy_line_item
    order    = current_order(create_order_if_necessary: true)
    variant  = Spree::Variant.find(params[:variant_id])
    quantity = params[:quantity].to_i

    order.contents.remove(variant, quantity)

    respond_with(order) do |format|
      format.js
    end
  end

  def calc_delivery
    @order = current_order(create_order_if_necessary: true)
    @shipping_method = Spree::ShippingMethod.find_by_id(params[:shipping_id]) || Spree::ShippingMethod.first
    post_calc = (@shipping_method.calculator.type == Spree::Order::DEFAULT_SHIPPING_CALCULATOR) && params[:zip].present?

    if post_calc
      delivery_cost = @shipping_method.calculator.compute(@order, {ship_address_zipcode: params[:zip].to_s})
    else
      delivery_cost = @shipping_method.calculator.compute_package(@order)
    end
    @order_total   = Spree::Money.new(delivery_cost + @order.total).to_s
    @delivery_cost = Spree::Money.new(delivery_cost).to_s
  end
end
