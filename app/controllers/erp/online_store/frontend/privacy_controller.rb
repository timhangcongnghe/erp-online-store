module Erp
  module OnlineStore
    module Frontend
      class PrivacyController < Erp::Frontend::FrontendController
        def general
          @class = 'page-template-default page wp-custom-logo wp-embed-responsive theme-eletra thcn-no-js wpisset-wpb wpisset wpisset-faqs wpisset-no-sidebar wpisset-sticky-nav wpisset-footer-bottom-active wpisset-responsive-breakpoints wpisset-medium-breakpoint-768 wpisset-desktop-breakpoint-992 wpisset-header-nav-variant2 wpisset-woo-sidebar-left wpisset-yith-wishlist wpisset-yith-compare wpb-js-composer js-comp-ver-6.6.0 vc_responsive'
          @page_title = 'Chính Sách Chung &#8211; Tìm Hàng Công Nghệ'
          @menus = Erp::Menus::Menu.get_parent_menus
        end
    
        def transport
          @class = 'page-template-default page wp-custom-logo wp-embed-responsive theme-eletra thcn-no-js wpisset-wpb wpisset wpisset-faqs wpisset-no-sidebar wpisset-sticky-nav wpisset-footer-bottom-active wpisset-responsive-breakpoints wpisset-medium-breakpoint-768 wpisset-desktop-breakpoint-992 wpisset-header-nav-variant2 wpisset-woo-sidebar-left wpisset-yith-wishlist wpisset-yith-compare wpb-js-composer js-comp-ver-6.6.0 vc_responsive'
          @page_title = 'Chính Sách Vận Chuyển &#8211; Tìm Hàng Công Nghệ'
          @menus = Erp::Menus::Menu.get_parent_menus
        end
    
        def warranty
          @class = 'page-template-default page wp-custom-logo wp-embed-responsive theme-eletra thcn-no-js wpisset-wpb wpisset wpisset-faqs wpisset-no-sidebar wpisset-sticky-nav wpisset-footer-bottom-active wpisset-responsive-breakpoints wpisset-medium-breakpoint-768 wpisset-desktop-breakpoint-992 wpisset-header-nav-variant2 wpisset-woo-sidebar-left wpisset-yith-wishlist wpisset-yith-compare wpb-js-composer js-comp-ver-6.6.0 vc_responsive'
          @page_title = 'Chính Sách Bảo Hành &#8211; Tìm Hàng Công Nghệ'
          @menus = Erp::Menus::Menu.get_parent_menus
        end
    
        def return_refund
          @class = 'page-template-default page wp-custom-logo wp-embed-responsive theme-eletra thcn-no-js wpisset-wpb wpisset wpisset-faqs wpisset-no-sidebar wpisset-sticky-nav wpisset-footer-bottom-active wpisset-responsive-breakpoints wpisset-medium-breakpoint-768 wpisset-desktop-breakpoint-992 wpisset-header-nav-variant2 wpisset-woo-sidebar-left wpisset-yith-wishlist wpisset-yith-compare wpb-js-composer js-comp-ver-6.6.0 vc_responsive'
          @page_title = 'Chính Sách Đổi Trả, Hoàn Tiền &#8211; Tìm Hàng Công Nghệ'
          @menus = Erp::Menus::Menu.get_parent_menus
        end
    
        def information_security
          @class = 'page-template-default page wp-custom-logo wp-embed-responsive theme-eletra thcn-no-js wpisset-wpb wpisset wpisset-faqs wpisset-no-sidebar wpisset-sticky-nav wpisset-footer-bottom-active wpisset-responsive-breakpoints wpisset-medium-breakpoint-768 wpisset-desktop-breakpoint-992 wpisset-header-nav-variant2 wpisset-woo-sidebar-left wpisset-yith-wishlist wpisset-yith-compare wpb-js-composer js-comp-ver-6.6.0 vc_responsive'
          @page_title = 'Chính Sách Bảo Mật Thông Tin Khách Hàng &#8211; Tìm Hàng Công Nghệ'
          @menus = Erp::Menus::Menu.get_parent_menus
        end
      end
    end
  end
end