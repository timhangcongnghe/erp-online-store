module Erp
  module OnlineStore
    module Frontend
      class GuideController < Erp::Frontend::FrontendController
        def shopping
          @class = 'page-template-default page wp-custom-logo wp-embed-responsive theme-eletra thcn-no-js wpisset-wpb wpisset wpisset-faqs wpisset-no-sidebar wpisset-sticky-nav wpisset-footer-bottom-active wpisset-responsive-breakpoints wpisset-medium-breakpoint-768 wpisset-desktop-breakpoint-992 wpisset-header-nav-variant2 wpisset-woo-sidebar-left wpisset-yith-wishlist wpisset-yith-compare wpb-js-composer js-comp-ver-6.6.0 vc_responsive'
          @page_title = 'Hướng Dẫn Mua Hàng &#8211; Tìm Hàng Công Nghệ'
          @menus = Erp::Menus::Menu.get_parent_menus
        end
    
        def payment
          @class = 'page-template-default page wp-custom-logo wp-embed-responsive theme-eletra thcn-no-js wpisset-wpb wpisset wpisset-faqs wpisset-no-sidebar wpisset-sticky-nav wpisset-footer-bottom-active wpisset-responsive-breakpoints wpisset-medium-breakpoint-768 wpisset-desktop-breakpoint-992 wpisset-header-nav-variant2 wpisset-woo-sidebar-left wpisset-yith-wishlist wpisset-yith-compare wpb-js-composer js-comp-ver-6.6.0 vc_responsive'
          @page_title = 'Hướng Dẫn Thanh Toán &#8211; Tìm Hàng Công Nghệ'
          @menus = Erp::Menus::Menu.get_parent_menus
        end
      end
    end
  end
end