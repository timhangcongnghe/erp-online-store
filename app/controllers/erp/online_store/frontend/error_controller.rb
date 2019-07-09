module Erp
  module OnlineStore
    module Frontend
      class ErrorController < Erp::Frontend::FrontendController
        layout 'erp/frontend/error_page'
        def not_found          
          render(:status => 404)
          render(:status => 500)
        end   
      end
    end
  end
end
