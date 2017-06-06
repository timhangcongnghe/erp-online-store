module Erp
  module OnlineStore
    module Frontend
      class EventsController < Erp::Frontend::FrontendController
        def index
          @meta_description = "Các chương trình sự kiện của TimHangCongNghe.VN với những ưu đãi, giảm giá cực hấp dẩn, đa dạng mặt hàng, thoải mái lựa chọn"
        end
        def event_detail
          @products = Erp::Products::Event.get_event_products(params).paginate(:page => params[:page], :per_page => 16)
          @menus = Erp::Menus::Menu.get_menus          
        end
      end
    end
  end
end
