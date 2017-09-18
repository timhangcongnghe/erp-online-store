module Erp
  module OnlineStore
    module Frontend
      class StockInventoryController < Erp::Frontend::FrontendController
        def index
          @menus = Erp::Menus::Menu.get_menus
          @meta_description = "Chào quý khách hàng, các sản phẩm trong mục XẢ KHO HÀNG TỒN là những sản phẩm tồn lại trong kho của chúng tôi chưa qua sử dụng nên hoàn toàn mới nhé."
        end

        def module
          @menu = Erp::Menus::Menu.find(params[:menu_id])
          @products = @menu.get_products_with_sold_out.get_stock_inventory_products.frontend_filter(params).paginate(:page => params[:page], :per_page => 8)

          render layout: nil
        end
        
        def index_2
          render layout: "erp/frontend/product_sellers"
        end
      end
    end
  end
end
