module Erp
  module OnlineStore
    module Frontend
      class QuickOrderController < Erp::Frontend::FrontendController
        def quick_order
          @body_class = "res layout-subpage"

          if params[:product_id].present?
            quantity = 1
            product = Erp::Products::Product.find(params[:product_id])
            @cart_item = @cart.add_product(product.id, quantity)
            @cart.cart_items << @cart_item
          end

          if @cart.cart_items.empty?
            redirect_to erp_online_store.root_path, notice: "Chưa có sản phẩm nào được chọn."
            return
          end
          
          if !current_user.nil? 
            @quick_order = Erp::QuickOrders::Order.new
            if current_user.contact.nil?
              @quick_order.customer_name = current_user.name
              @quick_order.email = current_user.email
            else
              @quick_order.customer_name = current_user.contact.name
              @quick_order.phone = current_user.contact.phone
              @quick_order.email = current_user.contact.email
            end
          end

          if params[:quick_order].present?
            @quick_order = Erp::QuickOrders::Order.new(quick_order_params)

            if @quick_order.save
              @quick_order.save_from_cart(@cart)
              Erp::Carts::Cart.destroy(session[:cart_id])

              Erp::QuickOrders::QuickOrderMailer.sending_admin_email_order_confirmation(@quick_order).deliver_now
              Erp::QuickOrders::QuickOrderMailer.sending_customer_email_order_confirmation(@quick_order).deliver_now

              redirect_to erp_online_store.checkout_completed_path, notice: "Thông tin đặt hàng được gửi thành công."
            else
              redirect_back(fallback_location: @quick_order, notice: "Thông tin đặt hàng chưa được gửi. Vui lòng kiểm tra và thử lại?")
            end
          end

          if request.xhr?
            render layout: nil
          end
        end

        private
          def quick_order_params
            params.fetch(:quick_order, {}).permit(:customer_name, :invoice, :address, :state_id, :district_id, :phone, :email, :note)
          end
      end
    end
  end
end
