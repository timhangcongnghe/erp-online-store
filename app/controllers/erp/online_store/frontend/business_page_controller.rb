module Erp
  module OnlineStore
    module Frontend
      class BusinessPageController < Erp::Frontend::FrontendController
        def index
          render layout: "erp/frontend/business"          
        end
      end
    end
  end
end