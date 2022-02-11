module Erp
  module OnlineStore
    module ApplicationHelper
      def root_link
        erp_online_store.root_path
      end

      def category_link
        erp_online_store.category_path
      end
    
      def category_list_link(category)
        erp_online_store.category_list_path(category_id: category.id, category_alias: category.alias)
      end

      # START Brand
      def brand_list_link
        erp_online_store.brand_list_path
      end
      
      def brand_detail_link(brand)
        erp_online_store.brand_detail_path
      end
      # END Brand

      def about_link
        erp_online_store.about_path
      end

      def contact_link
        erp_online_store.contact_path
      end

      def warranty_request_link
        erp_online_store.warranty_request_path
      end
    
      def print_invoice_link
        erp_online_store.print_invoice_path
      end

      def product_link(product)
        erp_online_store.product_path(product_id: product.id, product_alias: product.alias)
      end

      def cart_link
        erp_online_store.cart_path
      end

      def remove_cart_item_link(cart_item)
        erp_online_store.remove_cart_item_frontend_cart_items_path(cart_item_id: cart_item.id)
      end

      def add_to_cart_link
        erp_online_store.add_to_cart_frontend_cart_items_path
      end

      def checkout_link
        erp_online_store.checkout_path
      end

      def finish_link
        erp_online_store.finish_path
      end

      def track_link
        erp_online_store.track_path
      end

      # START Guide
      def shopping_guide_link
        erp_online_store.shopping_guide_path
      end

      def shopping_payment_link
        erp_online_store.shopping_payment_path
      end
      # END Guide

      # START Privacy
      def general_policy_link
        erp_online_store.general_policy_path
      end

      def transport_policy_link
        erp_online_store.transport_policy_path
      end

      def warranty_policy_link
        erp_online_store.warranty_policy_path
      end

      def return_refund_policy_link
        erp_online_store.return_refund_policy_path
      end

      def information_security_policy_link
        erp_online_store.information_security_policy_path
      end
      # END Guide

      def title(title)
        content_for :title, title.to_s
      end

      def image_set_tag(source, srcset = {}, options = {})
        srcset = srcset.map { |src, size| "#{path_to_image(src)} #{size}" }.join(', ')
        image_tag(source, options.merge(srcset: srcset))
      end

      def product_image(images, ordinal, thumb)
        if images.present?
          images.count < 2 ? images.first.image_url.send(thumb).url : images.send(ordinal).image_url.send(thumb).url
        else
          url_for('/img/main/no-image-available.png')
        end
      end
      
      def format_price(price)
        price = (price.to_f/1000).round*1000
        "<span style=\'font-family:sans-serif;\'>#{number_to_currency(price, precision: 0, format: "%n₫", separator: ',', unit: '', delimiter: ".")}</span>".html_safe
      end
    end
  end
end