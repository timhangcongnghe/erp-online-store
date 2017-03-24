module Erp
  module OnlineStore
    module Frontend
      class CartsController < Erp::Frontend::FrontendController
        rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart
      
        # PATCH/PUT /carts/1
        # PATCH/PUT /carts/1.json
        def update
          params.to_unsafe_h[:quantities].each do |q|
            li = Erp::Carts::CartItem.find(q[0])
            li.update_attribute(:quantity, q[1])
          end
          
          redirect_to erp_online_store.shopping_cart_path, notice: 'Cập nhật số lượng sản phẩm thành công.'
        end
      
        private
        
          def invalid_cart
            logger.error "Không thể truy cập vào giỏ hàng này: #{params[:id]}"
            redirect_to erp_online_store.root_path, notice: 'Giỏ hàng không hợp lệ'
          end
      end
    end
  end
end