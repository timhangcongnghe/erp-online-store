module Erp
  module OnlineStore
    module Frontend
      class BusinessChoicesController < Erp::Frontend::FrontendController
        def index
          @body_class = "common-home res layout-home7 loaded"
          @products = Erp::Products::Product.get_active.paginate(:page => params[:page], :per_page => 16)
        end
      end
    end
  end
end
