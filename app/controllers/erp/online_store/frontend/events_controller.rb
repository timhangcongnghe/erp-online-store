module Erp
  module OnlineStore
    module Frontend
      class EventsController < Erp::Frontend::FrontendController
        def index
        end
        def events_detail
          @products = Erp::Products::Product.get_deal_products.paginate(:page => params[:page], :per_page => 16)
          @menus = Erp::Menus::Menu.get_menus
        end
      end
    end
  end
end
