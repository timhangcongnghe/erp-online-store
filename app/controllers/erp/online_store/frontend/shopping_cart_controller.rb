module Erp
  module OnlineStore
    module Frontend
      class ShoppingCartController < Erp::Frontend::FrontendController
        def shopping_cart
          @body_class = "res layout-subpage"
        end
    
        def checkout
          @body_class = "res layout-subpage"
          redirect_to erp_online_store.shopping_cart_path if @cart.cart_items.empty?
        end
    
        def compare
          @body_class = "res layout-subpage"
        end
        
        def top_cart
          render partial: 'erp/online_store/frontend/shopping_cart/top_cart', layout: nil
        end
      end
    end
  end
end
