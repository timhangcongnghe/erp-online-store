module Erp
  module TimhangcongngheVn
    module Frontend
      class InformationController < Erp::Frontend::FrontendController
        def about_us
          @body_class = "res layout-subpage"
        end
    
        def faq
          @body_class = "res layout-subpage"
        end
    
        def contact_us
          @body_class = "res layout-subpage"
        end
    
        def terms_and_conditions
        end
    
        def site_map
          @body_class = "res layout-subpage"
        end
      end
    end
  end
end
