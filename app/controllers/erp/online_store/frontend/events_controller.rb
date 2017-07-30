module Erp
  module OnlineStore
    module Frontend
      class EventsController < Erp::Frontend::FrontendController
        def index
          @meta_description = "Các chương trình sự kiện của Tìm Hàng Công Nghệ với những ưu đãi, giảm giá cực hấp dẫn, đa dạng mặt hàng, thoải mái lựa chọn"
        end
        def event_detail
          @products = Erp::Products::Event.get_event_products(params).paginate(:page => params[:page], :per_page => 16)
          @menus = Erp::Menus::Menu.get_menus
          @event = Erp::Products::Event.find(params[:event_id])
          @meta_description = "Tìm Hàng Công Nghệ - " + @event.name
        end
      end
    end
  end
end