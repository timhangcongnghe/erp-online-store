module Erp
  module OnlineStore
    module Frontend
      class CategoryController < Erp::Frontend::FrontendController
        def index
          @body_class = "res layout-subpage"
          @menu = Erp::Menus::Menu.find(params[:menu_id])
          @products = @menu.get_products_for_categories(params)
        end
        
        def product_detail
          @body_class = "res layout-subpage"
        end
        
        def product_quickview
          render layout: "erp/frontend/quickview"
        end
      end
    end
  end
end
