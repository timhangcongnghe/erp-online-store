module Erp
  module OnlineStore
    module Frontend
      class ProductController < Erp::Frontend::FrontendController
        def index
          @class = 'product-template-default single single-product wp-custom-logo wp-embed-responsive theme-eletra thcn thcn-page thcn-no-js wpisset wpisset-samsong-galaxy-s20-5g-128-gb-black wpisset-no-sidebar wpisset-sticky-nav wpisset-footer-bottom-active wpisset-responsive-breakpoints wpisset-medium-breakpoint-768 wpisset-desktop-breakpoint-992 wpisset-header-nav-variant2 wpisset-product-type-extented wpisset-product-sticky-active wpisset-yith-wishlist wpisset-yith-compare wpb-js-composer js-comp-ver-6.6.0 vc_responsive'
          @product = Erp::Products::Product.find(params[:product_id])
          @page_title = @product.get_name.to_s + ' &#8211; Tìm Hàng Công Nghệ'
          @menus = Erp::Menus::Menu.get_parent_menus
          @newest_products = Erp::Products::Product.get_newest_products

          @menu = @product.find_menu

          @category_newest_related_products = Erp::Products::Product.category_newest_related_products(@product).limit(3)

          if @product.is_sold_out?
            @brand_related_products = Erp::Products::Product.brand_related_products_for_sold_out(@product).limit(5)
            @category_related_products = Erp::Products::Product.category_related_products_for_sold_out(@product).limit(5)
          else
            @brand_related_products = Erp::Products::Product.brand_related_products_for_not_sold_out(@product).limit(5)
            @category_related_products = Erp::Products::Product.category_related_products_for_not_sold_out(@product).limit(5)
          end
        end
        
        def search
          @class = 'archive post-type-archive post-type-archive-product wp-custom-logo wp-embed-responsive theme-eletra thcn-shop thcn thcn-page thcn-no-js wpisset wpisset-aplle-iphone-12-64-gb-green wpisset-no-sidebar wpisset-sticky-nav wpisset-footer-bottom-active wpisset-responsive-breakpoints wpisset-medium-breakpoint-768 wpisset-desktop-breakpoint-992 wpisset-header-nav-variant2 wpisset-yith-wishlist wpisset-yith-compare wpisset-wpb wpb-js-composer js-comp-ver-6.6.0 vc_responsive'
        end
      end
    end
  end
end