module Erp
  module OnlineStore
    module Frontend
      class ProductController < Erp::Frontend::FrontendController
        include Erp::ApplicationHelper
        include ActionView::Helpers::NumberHelper
        
        def product_detail
          @body_class = "res layout-subpage"
          @menu = Erp::Menus::Menu.find(params[:menu_id])
          @product = Erp::Products::Product.find(params[:product_id])
        end
        
        def product_quickview
          render layout: "erp/frontend/quickview"
        end
        
        def autosearch
          @products = Erp::Products::Product.search(params).paginate(:page => params[:page], :per_page => 10)
          
          render json: @products.map { |product| {
            name: product.name,
            price: format_number(product.price) + ' ₫',
            link: erp_online_store.product_detail_path(product),
            image: image_src(product.main_image, 'small'),
          }}
        end
      end
    end
  end
end
