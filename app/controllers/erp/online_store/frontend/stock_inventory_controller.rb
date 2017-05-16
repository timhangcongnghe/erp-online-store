module Erp
  module OnlineStore
    module Frontend
      class StockInventoryController < Erp::Frontend::FrontendController
        def index
          @products = Erp::Products::Product.get_stock_inventory_products.paginate(:page => params[:page], :per_page => 16)
          @menus = Erp::Menus::Menu.get_menus
        end
      end
    end
  end
end
