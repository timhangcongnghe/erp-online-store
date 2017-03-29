module Erp
  module OnlineStore
    module Frontend
      class HomeController < Erp::Frontend::FrontendController
        def index
          @body_class = "common-home res layout-home1"
          @hot_deals = Erp::Products::Product.get_deal_products
          @bestsellers = Erp::Products::Product.get_bestseller_products
          @brands = Erp::Products::Brand.get_brands
          @newest_blogs = Erp::Articles::Article.newest_articles(2)
          @testimonials = Erp::Testimonials::Testimonial.get_testimonials
        end
        
        # home category box
        def category_box
          @menu_hot = Erp::Menus::Menu.find(params[:menu_hot_id])
          if params[:child_1_id].present?
            @child_1 = Erp::Menus::Menu.find(params[:child_1_id])
          end
          if params[:child_2_id].present?
            @child_2 = Erp::Menus::Menu.find(params[:child_2_id])
          end
          if (params[:menu_hot_id].present? && params[:child_1_id].present? && params[:child_2_id].present?)
            @products = @child_2.get_products_for_categories(params).limit(6)
          elsif (params[:menu_hot_id].present? && params[:child_1_id].present? && !params[:child_2_id].present?)
            @products = @child_1.get_products_for_categories(params).limit(6)
          else
            @products = @menu_hot.get_products_for_categories(params).limit(6)
          end
          render layout: nil
        end
        
        def top_right_menu
          render partial: 'erp/online_store/frontend/modules/header/top_right_menu', layout: nil
        end
      end
    end
  end
end