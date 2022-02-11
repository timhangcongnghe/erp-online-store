module Erp
  module OnlineStore
    module Frontend
      class OrderController < Erp::Frontend::FrontendController
        def cart
          @class = 'page-template-default page wp-custom-logo wp-embed-responsive theme-eletra thcn-cart thcn-page thcn-no-js wpisset wpisset-cart wpisset-no-sidebar wpisset-sticky-nav wpisset-footer-bottom-active wpisset-responsive-breakpoints wpisset-medium-breakpoint-768 wpisset-desktop-breakpoint-992 wpisset-header-nav-variant2 wpisset-woo-sidebar-left wpisset-yith-wishlist wpisset-yith-compare wpb-js-composer js-comp-ver-6.6.0 vc_responsive'
          @page_title = 'Giỏ Hàng Của Bạn &#8211; Tìm Hàng Công Nghệ'
          @menus = Erp::Menus::Menu.get_parent_menus
        end
        
        def checkout
          @class = 'page-template-default page wp-custom-logo wp-embed-responsive theme-eletra thcn-checkout thcn-page thcn-no-js wpisset wpisset-checkout wpisset-no-sidebar wpisset-sticky-nav wpisset-footer-bottom-active wpisset-responsive-breakpoints wpisset-medium-breakpoint-768 wpisset-desktop-breakpoint-992 wpisset-header-nav-variant2 wpisset-woo-sidebar-left wpisset-yith-wishlist wpisset-yith-compare wpb-js-composer js-comp-ver-6.6.0 vc_responsive'
          @page_title = ' &#8211; Tìm Hàng Công Nghệ'
          @menus = Erp::Menus::Menu.get_parent_menus
        end
        
        def finish
          @class = 'page-template-default page wp-custom-logo wp-embed-responsive theme-eletra thcn-checkout thcn-page thcn-order-received thcn-no-js wpisset wpisset-checkout wpisset-no-sidebar wpisset-sticky-nav wpisset-footer-bottom-active wpisset-responsive-breakpoints wpisset-medium-breakpoint-768 wpisset-desktop-breakpoint-992 wpisset-header-nav-variant2 wpisset-woo-sidebar-left wpisset-yith-wishlist wpisset-yith-compare wpb-js-composer js-comp-ver-6.6.0 vc_responsive'
          @page_title = ' &#8211; Tìm Hàng Công Nghệ'
          @menus = Erp::Menus::Menu.get_parent_menus
        end
        
        def track
          @class = 'page-template-default page wp-custom-logo wp-embed-responsive theme-eletra thcn-no-js wpisset-wpb wpisset wpisset-track-your-order wpisset-no-sidebar wpisset-sticky-nav wpisset-footer-bottom-active wpisset-responsive-breakpoints wpisset-medium-breakpoint-768 wpisset-desktop-breakpoint-992 wpisset-header-nav-variant2 wpisset-woo-sidebar-left wpisset-yith-wishlist wpisset-yith-compare wpb-js-composer js-comp-ver-6.6.0 vc_responsive'
          @page_title = 'Tra Cứu Đơn Hàng &#8211; Tìm Hàng Công Nghệ'
          @menus = Erp::Menus::Menu.get_parent_menus
        end
      end
    end
  end
end