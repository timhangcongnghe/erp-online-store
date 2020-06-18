module Erp
  module OnlineStore
    module Frontend
      class BrandController < Erp::Frontend::FrontendController
        def listing
          @body_class = "res layout-subpage"
          @brands = Erp::Products::Brand.get_brands_order_name
          @meta_description = "Danh sách các thương hiệu sản phẩm được kinh doanh nhiều nhất tại TimHangCongNghe để quý khách hàng tiện lựa chọn."
          #expires_in 3.hours, public: true
        end
        
        def detail_301
          @brand = Erp::Products::Brand.find(params[:brand_id])
          redirect_to erp_online_store.brand_detail_path(brand_id: @brand.id, brand_name: @brand.alias), status: 301
        end

        def detail
          @brand = Erp::Products::Brand.find(params[:brand_id])
          @products = Erp::Products::Product.get_products_for_brand(params).frontend_filter(params).paginate(:page => params[:page], :per_page => 64)
          @categories = Erp::Menus::Menu.get_menus
          #expires_in 3.hours, public: true
        end

        def select2
          render json: {items: Erp::Products::Brand.select2(params)}
        end
      end
    end
  end
end
