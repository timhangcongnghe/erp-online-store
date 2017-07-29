module Erp
  module OnlineStore
    module Frontend
      class BlogController < Erp::Frontend::FrontendController
        before_action :set_comment, only: [:delete_comment]

        def index
          @body_class = "res layout-subpage banners-effect-6"
          @blogs = Erp::Articles::Article.get_all_blogs(params).paginate(:page => params[:page], :per_page => 5)
          @categories = Erp::Articles::Category.get_categories_by_alias_blog
          if params[:cat_id].present?
            @category = Erp::Articles::Category.find(params[:cat_id])
          end
        end

        def detail
          @body_class = "res layout-subpage"
          @blog = Erp::Articles::Article.find(params[:blog_id])
          @meta_keywords = @blog.meta_keywords
          @meta_description = @blog.meta_description
          @categories = Erp::Articles::Category.where(alias: Erp::Articles::Category::ALIAS_BLOG)
          @comments = @blog.comments.order('created_at DESC')
            .where(parent_id: nil)
            .where(archived: false)
            .paginate(:page => params[:page], :per_page => 5)
        end

        def comments
          @blog = Erp::Articles::Article.find(params[:blog_id])

          # blog comment
          if params[:comment].present?
            @comment = Erp::Articles::Comment.new(comment_params)
            @comment.user = current_user
            @comment.save
            render plain: 'Bạn đã đăng bình luận thành công'
            return
          end

          @comments = @blog.comments.order('created_at DESC')
            .where(parent_id: nil)
            .where(archived: false)
            .paginate(:page => params[:page], :per_page => 5)

          render 'erp/online_store/frontend/modules/blog/_comments', locals: {comments: @comments}, layout: nil
        end

        def delete_comment
          @comment.destroy
          redirect_back(fallback_location: @comment, notice: 'Nội dung bình luận đã được xóa')
        end

        private
          def set_comment
            @comment = Erp::Articles::Comment.find(params[:comment_id])
          end

          def comment_params
            params.fetch(:comment, {}).permit(:message, :article_id, :parent_id)
          end
      end
    end
  end
end
