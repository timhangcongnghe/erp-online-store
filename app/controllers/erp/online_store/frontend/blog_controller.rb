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
          @comments = Erp::Articles::Comment.where(article_id: params[:blog_id]).order('created_at DESC')
                                            .where(parent_id: nil)
                                            .paginate(:page => params[:page], :per_page => 5)
          
          if params[:comment].present?
            @comment = Erp::Articles::Comment.new(comment_params)
            @comment.save
            render 'erp/online_store/frontend/blog/_comments', locals: {comments: @comments}, layout: nil
          end
        end
        
        private
          def comment_params
            params.fetch(:comment, {}).permit(:name, :email, :message, :article_id, :parent_id)
          end
      end
    end
  end
end
