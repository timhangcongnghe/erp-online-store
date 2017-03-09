module Erp
  module OnlineStore
    module Frontend
      class BlogController < Erp::Frontend::FrontendController
        def index
          @body_class = "res layout-subpage banners-effect-6"
        end
    
        def detail
          @body_class = "res layout-subpage"
        end
      end
    end
  end
end
