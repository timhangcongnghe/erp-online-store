module Erp
  module OnlineStore
    module ApplicationHelper

      # display stars rating
      def stars(number)
        strs = []
        (1..5).each do |star|
          star = star-1
          if number <= star+0.25
            cls = '-o'
          elsif number >= star+0.76
            cls = ''
          elsif number >= star+0.26 and number <= star+0.75
            cls = '-half-o'
          end

          strs << "<span class=\"fa fa-stack\"><i class=\"fa fa-star#{(cls)} fa-stack-2x\"></i></span>"
        end
        strs.join('').html_safe
      end

      # menu link helper
      def menu_link(menu)
        erp_online_store.category_path(menu_id: menu.id, title: url_friendly(menu.name))
      end

      # product link helper
      def product_link(product)
        erp_online_store.product_detail_path(product_id: product.id, title: product.alias)
      end
      
      # product url helper
      def product_property_link(product)
        erp_online_store.all_property_path(product_id: product.id, title: product.alias)
      end

      # brand link helper
      def brand_link(brand)
        erp_online_store.brand_detail_path(brand_id: brand.id, title: url_friendly(brand.name))
      end

      # page title helper
      def title(page_title)
        content_for :title, page_title.to_s
      end

      # article link
      def article_link(article)
        erp_online_store.blog_detail_path(article.id, title:  url_friendly(article.name))
      end

      # event link
      def event_link(event)
        erp_online_store.event_detail_path(event.id, title:  url_friendly(event.name))
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

      # product image
      def product_image(images, ordinal, thumb)
        if images.present?
          images.count < 2 ? images.first.image_url.send(thumb).url : images.send(ordinal).image_url.send(thumb).url
        else
          url_for('/frontend/image/shop/product/no-image.png')
        end
      end

      # display full address
      def full_address(contact)
        str = []
        str << contact.address if contact.address.present?
        str << contact.district_name if contact.district_name.present?
        str << contact.state_name if contact.state_name.present?
        str.join(", ")
      end

      # display status for frontend order
      def order_status(status)
        if status == 'draft'
          '<span class="pending"><i class="fa fa-info-circle"></i> Đang chờ xác nhận</span>'.html_safe
        elsif status == 'confirmed'
          '<span class="confirm"><i class="fa fa-warning"></i> Đã xác nhận</span><br/>
          <span class="confirm"><i class="fa fa-warning"></i> Đang chờ giao hàng</span>'.html_safe
        elsif status == 'finished'
          '<span class="finish"><i class="fa fa-check-circle"></i> Giao dịch thành công</span>'.html_safe
        elsif status == 'cancelled'
          '<span class="cancel"><i class="fa fa-ban"></i> Đơn hàng bị hủy</span>'.html_safe
        end
      end

      # count down to end datetime
      def count_down(from_time, to_time)
        if from_time.present? and to_time.present?
          if from_time <= Time.now and Time.now <= to_time
            "<div class=\'countdown_box\'>
                <div class=\'countdown_inner\'>
                    <div class=\'defaultCountdown-30 count-down\' rel=\'#{to_time.year}, #{to_time.month}, #{to_time.day}, #{to_time.hour}, #{to_time.min}\'></div>
                </div>
            </div>".html_safe
          end
        end
      end

      def product_list_description(product)
        props = product.product_list_descipriton_values_array
        return '' if props.empty?

        html = '<div class="description product-description"><p>'
        rows = []
        props.each do |row|
          rows << '<strong>' + row[:name] + '</strong>: ' + row[:values].join(', ') + ''
        end
        html += rows.join('<br>')
        html += '</p></div>'
        html.html_safe
      end

      def quick_actions(product)
        "<div class=\'view-buy hidden-xs\'>
            <a href=\'#{erp_online_store.product_quickview_path(product_id: product, title: url_friendly(product.product_name))}\' class=\'btn-cus quick-view btn_view ajax-link\' data-type=\'ajax\' rel=\'nofollow\' title=\'Xem nhanh sản phẩm\'><span>Xem nhanh</span></a>
            <a href=\'#\' class=\'btn-cus quick-view btn_view btn_compare\' product_id=\'#{product.id}\' data-url=\'#{erp_online_store.add_to_compare_frontend_compare_items_path}\' rel=\'nofollow\' title=\'So sánh sản phẩm\'><span>So sánh</span></a>
        </div>".html_safe
      end

    end
  end
end
