module Erp
  module OnlineStore
    module Frontend
      class BrandController < Erp::Frontend::FrontendController
        def listing
          @body_class = "res layout-subpage"
          @brands = Erp::Products::Brand.get_brands
        end
      end
    end
  end
end
