module Erp
  module OnlineStore
    module Frontend
      class BrandController < Erp::Frontend::FrontendController
        def list
          @class = 'page-template-default page wp-custom-logo wp-embed-responsive theme-eletra thcn-no-js wpisset wpisset-store-listing wpisset-no-sidebar wpisset-sticky-nav wpisset-footer-bottom-active wpisset-responsive-breakpoints wpisset-medium-breakpoint-768 wpisset-desktop-breakpoint-992 wpisset-header-nav-variant2 wpisset-woo-sidebar-left wpisset-yith-wishlist wpisset-yith-compare wpb-js-composer js-comp-ver-6.6.0 vc_responsive dokan-theme-eletra'
          @page_title = ' &#8211; Tìm Hàng Công Nghệ'
          @menus = Erp::Menus::Menu.get_parent_menus
        end
        
        def detail
          @class = 'wp-custom-logo wp-embed-responsive theme-eletra thcn-no-js wpisset wpisset-samsong-t32e755cx-32-smart-full-hd-led-tv wpisset-no-sidebar wpisset-sticky-nav wpisset-footer-bottom-active wpisset-responsive-breakpoints wpisset-medium-breakpoint-768 wpisset-desktop-breakpoint-992 wpisset-header-nav-variant2 wpisset-woo-sidebar-left wpisset-yith-wishlist wpisset-yith-compare wpb-js-composer js-comp-ver-6.6.0 vc_responsive dokan-store dokan-theme-eletra'
          @page_title = ' &#8211; Tìm Hàng Công Nghệ'
          @menus = Erp::Menus::Menu.get_parent_menus
        end
      end
    end
  end
end