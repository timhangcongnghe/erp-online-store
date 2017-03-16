module Erp
  module OnlineStore
    module Frontend
      class BlogController < Erp::Frontend::FrontendController          
        def index
          @body_class = "res layout-subpage banners-effect-6"
          @blogs = Erp::Articles::Article.get_all_blogs(params).paginate(:page => params[:page], :per_page => 5)
          @categories = Erp::Articles::Category.where(alias: Erp::Articles::Category::ALIAS_BLOG)
        end
    
        def detail
          @body_class = "res layout-subpage"
          @blog = Erp::Articles::Article.find(params[:blog_id])
          @categories = Erp::Articles::Category.where(alias: Erp::Articles::Category::ALIAS_BLOG)
        end
      end
    end
  end
end
