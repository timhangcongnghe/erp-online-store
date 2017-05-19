module Erp
  module OnlineStore
    module Frontend
      class BusinessChoicesController < Erp::Frontend::FrontendController
        def index
          @body_class = "common-home res layout-home7 loaded"
          @products = Erp::Products::Product.get_business_choices.frontend_filter(params).paginate(:page => params[:page], :per_page => 8)
          @menus = Erp::Menus::Menu.get_menus
        end
      end
    end
  end
end
