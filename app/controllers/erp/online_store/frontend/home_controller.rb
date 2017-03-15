module Erp
  module OnlineStore
    module Frontend
      class HomeController < Erp::Frontend::FrontendController
        def index
          @body_class = "common-home res layout-home1"
        end
        
        # home category box
        def category_box
          @menu_hot = Erp::Menus::Menu.find(params[:menu_hot_id])
          if params[:child_1_id].present?
            @child_1 = Erp::Menus::Menu.find(params[:child_1_id])
          end
          render layout: nil
        end
      end
    end
  end
end
