module Erp
  module OnlineStore
    module Frontend
      class BlogController < Erp::Frontend::FrontendController          
        def index
          @body_class = "res layout-subpage banners-effect-6"
          @blogs = Erp::Articles::Article.search(params).paginate(:page => params[:page], :per_page => 1)
          @categories = Erp::Articles::Category.all
        end
    
        def detail
          @body_class = "res layout-subpage"
          @blog = Erp::Articles::Article.find(params[:blog_id])
          @categories = Erp::Articles::Category.all
        end
      end
    end
  end
end
