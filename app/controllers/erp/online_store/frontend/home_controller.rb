module Erp
  module OnlineStore
    module Frontend
      class HomeController < Erp::Frontend::FrontendController
        def index
          @body_class = "common-home res layout-home1 home-page"
          if Erp::Core.available?("banners")
            @block_banners = Erp::Banners::Banner.get_home_block_banners
            @long_banner = Erp::Banners::Banner.get_home_long_banners.last
          end
          #expires_in 5.hours, public: true
        end
        
        def category_box
          @category_hot = Erp::Menus::Menu.find(params[:category_hot_id])
          if params[:child_1_id].present?
            @child_1 = Erp::Menus::Menu.find(params[:child_1_id])
          end
          if params[:child_2_id].present?
            @child_2 = Erp::Menus::Menu.find(params[:child_2_id])
          end
          if (params[:category_hot_id].present? && params[:child_1_id].present? && params[:child_2_id].present?)
            @products = @child_2.get_products_for_categories(params).limit(6)
          elsif (params[:category_hot_id].present? && params[:child_1_id].present? && !params[:child_2_id].present?)
            @products = @child_1.get_products_for_categories(params).limit(6)
          else
            @products = @category_hot.get_products_for_categories(params).limit(6)
          end
          render layout: nil
        end

        def top_right_menu
          render partial: 'erp/online_store/frontend/modules/header/top_right_menu', layout: nil
        end
        
        def auth_failure
          redirect_to erp_online_store.root_path, flash: {notice: "Thao tác không thành công."}
        end
      end
    end
  end
end