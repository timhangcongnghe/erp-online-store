module Erp
  module OnlineStore
    module Frontend
      class BrandController < Erp::Frontend::FrontendController
        def listing
          @body_class = "res layout-subpage"
          @brands = Erp::Products::Brand.get_brands_order_name
        end

        def detail
          @brand = Erp::Products::Brand.find(params[:brand_id])
          @products = Erp::Products::Product.get_products_for_brand(params).paginate(:page => params[:page], :per_page => 16)
          @menus = Erp::Menus::Menu.get_menus
        end

        def select2
          render json: {items: Erp::Products::Brand.select2(params)}
        end
      end
    end
  end
end
