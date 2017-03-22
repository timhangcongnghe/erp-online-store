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
          @meta_keywords = @product.meta_keywords
          @meta_description = @product.meta_description
          @comments = Erp::Products::Comment.where(product_id: params[:product_id]).order('created_at DESC')
                                            .where(parent_id: nil)
                                            .paginate(:page => params[:page], :per_page => 5)
          
          if params[:comment].present?
            @comment = Erp::Products::Comment.new(comment_params)
            @comment.save
            render 'erp/online_store/frontend/product/_comments', locals: {comments: @comments}, layout: nil
          end
        end
        
        def product_quickview
          @product = Erp::Products::Product.find(params[:product_id])
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
        
        private
          def comment_params
            params.fetch(:comment, {}).permit(:name, :email, :message, :product_id, :parent_id)
          end
      end
    end
  end
end
