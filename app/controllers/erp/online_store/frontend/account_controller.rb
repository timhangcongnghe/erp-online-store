module Erp
  module OnlineStore
    module Frontend
      class AccountController < Erp::Frontend::FrontendController
        def login
          @body_class = "res layout-subpage"
        end
    
        def register
          @body_class = "res layout-subpage"
        end
    
        def my_account
          @body_class = "res layout-subpage"
        end
    
        def order_history
          @body_class = "res layout-subpage"
        end
    
        def order_information
          @body_class = "res layout-subpage"
        end
    
        def product_returns
          @body_class = "res layout-subpage"
        end
    
        def gift_voucher
          @body_class = "res layout-subpage"
        end
        
        def wishlist
          @body_class = "res layout-subpage"
          @wish_lists = current_user.wish_lists.paginate(:page => params[:page], :per_page => 6)
        end
      end
    end
  end
end
