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
      end
    end
  end
end
