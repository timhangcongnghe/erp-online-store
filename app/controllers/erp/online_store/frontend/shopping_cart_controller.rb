module Erp
  module OnlineStore
    module Frontend
      class ShoppingCartController < Erp::Frontend::FrontendController
        def cart
          @body_class = "res layout-subpage"
        end
    
        def checkout
          @body_class = "res layout-subpage"
        end
    
        def compare
          @body_class = "res layout-subpage"
        end
      end
    end
  end
end
