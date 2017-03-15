module Erp
  module OnlineStore
    module Frontend
      class HomeController < Erp::Frontend::FrontendController
        def index
          @body_class = "common-home res layout-home1"
        end
        
        # home category box
        def category_box
          render layout: nil
        end
      end
    end
  end
end
