module Erp
  module OnlineStore
    module Frontend
      class CategoryController < Erp::Frontend::FrontendController
        def index
          @body_class = "res layout-subpage"
          @menu = Erp::Menus::Menu.find(params[:menu_id])
          @products = @menu.get_products_for_categories(params)
        end
      end
    end
  end
end
