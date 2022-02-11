module Erp
  module OnlineStore
    module Frontend
      class CartItemsController < Erp::Frontend::FrontendController
        def add_to_cart
          quantity = params[:quantity]
          product = Erp::Products::Product.find(params[:product_id])
          
          @cart_item = @cart.add_product(product.id, quantity)
          if @cart_item.save
            redirect_to erp_online_store.cart_path, notice: 'Thêm sản phẩm vào giỏ hàng thành công!'
          end
        end

        def remove_cart_item
          @cart.remove_cart_item(params[:cart_item_id])
          redirect_to erp_online_store.cart_path, notice: 'Xóa sản phẩm khỏi giỏ hàng thành công!'
        end
      end
    end
  end
end