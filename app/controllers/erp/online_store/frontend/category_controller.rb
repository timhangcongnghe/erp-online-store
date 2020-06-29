module Erp
  module OnlineStore
    module Frontend
      class CategoryController < Erp::Frontend::FrontendController
        def detail_301          
          @category = Erp::Menus::Menu.find(params[:category_id])
          redirect_to erp_online_store.category_detail_path(category_id: @category.id, category_name: @category.alias), status: 301
        end
        
        def detail
          @body_class = "res layout-subpage"
          @category = Erp::Menus::Menu.find(params[:category_id])
          @products = @category.get_products_for_categories(params).paginate(:page => params[:page], :per_page => 36)
          @meta_description = @category.meta_description
          if request.xhr?
            render layout: nil
          end
          #expires_in 5.hours, public: true
        end

        def select2
          render json: {items: Erp::Menus::Menu.select2(params)}
        end
      end
    end
  end
end