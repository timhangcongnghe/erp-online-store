module Erp
  module OnlineStore
    module ApplicationHelper

      # display stars rating
      def stars(number)
        strs = []
        (1..5).each do |star|
          strs << "<span class=\"fa fa-stack\"><i class=\"fa fa-star#{(number >= star ? '' : '-o')} fa-stack-2x\"></i></span>"
        end
        strs.join('')
      end

      # menu link helper
      def menu_link(menu)
        erp_online_store.category_path(menu_id: menu.id, title: url_friendly(menu.name))
      end

      # product link helper
      def product_link(product)
        erp_online_store.product_detail_path(product_id: product.id, title: url_friendly(product.name))
      end

      # page title helper
      def title(page_title)
        content_for :title, page_title.to_s
      end

      # article link
      def article_link(article)
        erp_online_store.blog_detail_path(article.id, title:  url_friendly(article.name))
      end
      
      # user avatar
      def avatar(user)
        user.avatar? ? user.avatar.profile : url_for('/frontend/image/avatar/user_default.png')
      end
      
      # user avatar
      def article_image(thumb, size)
        if size == 'normal'
          thumb.present? ? thumb : url_for('/frontend/image/blog/normal_600x390.png')
        elsif size == 'small'
          thumb.present? ? thumb : url_for('/frontend/image/blog/small_70x70.png')
        end
      end
    end
  end
end
