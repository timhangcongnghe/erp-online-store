module Erp
  module OnlineStore
    module Frontend
      class CategoryController < Erp::Frontend::FrontendController
        def index
          @body_class = "res layout-subpage"
          @menu = Erp::Menus::Menu.find(params[:menu_id])
          @related_menus = @menu.related_menus.limit(5)
          @products = @menu.get_products_for_categories(params).paginate(:page => params[:page], :per_page => 12)
          @meta_keywords = @menu.meta_keywords
          @meta_description = @menu.meta_description

          if request.xhr?
            render layout: nil
          end
        end

        def deal_products
          @products = Erp::Products::Product.get_deal_products.frontend_filter(params).paginate(:page => params[:page], :per_page => 16)
          @menus = Erp::Menus::Menu.get_menus
          @meta_description = "Các sản phẩm đang có chương trình khuyến mãi, giảm giá đều được giới thiệu tại KHUYẾN MÃI trên trang TimHangCongNghe.VN"
        end

        def bestseller_products
          @products = Erp::Products::Product.get_bestseller_products.frontend_filter(params).paginate(:page => params[:page], :per_page => 16)
          @menus = Erp::Menus::Menu.get_menus
          @meta_description = "Các sản phẩm được khách hàng đặt hàng được chúng tôi thống kê, chọn lọc để sắp xếp vào nhóm sản phẩm BÁN CHẠY trên trang TimHangCongNghe.VN"
        end

        def select2
          render json: {items: Erp::Menus::Menu.select2(params)}
        end
      end
    end
  end
end
