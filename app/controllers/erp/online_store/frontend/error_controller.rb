module Erp
  module OnlineStore
    module Frontend
      class ErrorController < Erp::Frontend::FrontendController
        def not_found          
          render(:status => 404)
          render layout: "erp/frontend/error_page"
        end      
      end
    end
  end
end
