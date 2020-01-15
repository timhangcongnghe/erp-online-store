module Erp
  module OnlineStore
    module Frontend
      class EventsController < Erp::Frontend::FrontendController
        def index          
        end
        def event_detail
          @products = Erp::Products::Event.get_event_products(params).paginate(:page => params[:page], :per_page => 16)
          @menus = Erp::Menus::Menu.get_menus
          @event = Erp::Products::Event.find(params[:event_id])
        end
      end
    end
  end
end