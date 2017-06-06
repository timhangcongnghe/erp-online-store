module Erp
  module OnlineStore
    module Frontend
      class StockInventoryController < Erp::Frontend::FrontendController
        def index
          @products = Erp::Products::Product.get_stock_inventory_products.frontend_filter(params).paginate(:page => params[:page], :per_page => 16)
          @menus = Erp::Menus::Menu.get_menus
        end

        def module
          @menu = Erp::Menus::Menu.find(params[:menu_id])
          @products = @menu.get_products.get_stock_inventory_products.frontend_filter(params).paginate(:page => params[:page], :per_page => 16)

          render layout: nil
        end
      end
    end
  end
end
