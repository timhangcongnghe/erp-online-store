module Erp
  module TimhangcongngheVn
    module Frontend
      class CategoryController < Erp::Frontend::FrontendController
        def index
          @body_class = "res layout-subpage"
        end
        
        def product_detail
          @body_class = "res layout-subpage"
        end
      end
    end
  end
end
