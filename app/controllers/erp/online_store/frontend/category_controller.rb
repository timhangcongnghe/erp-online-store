module Erp
  module OnlineStore
    module Frontend
      class CategoryController < Erp::Frontend::FrontendController
        def index
          @body_class = "res layout-subpage"
          @menu = Erp::Menus::Menu.find(params[:menu_id])
          @related_menus = @menu.related_menus.limit(5)
          @products = @menu.get_products_for_categories(params)
          @meta_keywords = @menu.meta_keywords
          @meta_desciption = @menu.meta_description
        end
      end
    end
  end
end
