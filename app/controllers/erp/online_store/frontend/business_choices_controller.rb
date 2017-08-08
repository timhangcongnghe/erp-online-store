module Erp
  module OnlineStore
    module Frontend
      class BusinessChoicesController < Erp::Frontend::FrontendController
        def index
          @body_class = "common-home res layout-home7 loaded"
          @products = Erp::Products::Product.get_business_choices.frontend_filter(params).paginate(:page => params[:page], :per_page => 20)
          @menus = Erp::Menus::Menu.get_menus
          @sliders = Erp::Banners::Banner.get_home_sliders
          @meta_description = "Một nét mới lạ tại TimHangCongNghe.VN, các sản phẩm được các doanh nghiệp lựa chọn và tin dùng đều được giới thiệu tại trang Lựa Chọn Từ Doanh Nghiệp"
        end
      end
    end
  end
end
