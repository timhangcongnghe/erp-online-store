module Erp
  module OnlineStore
    module Frontend
      class HomeController < Erp::Frontend::FrontendController
        def index
          @class = 'page-template-default page wp-custom-logo wp-embed-responsive theme-eletra thcn-no-js wpisset-wpb wpisset wpisset-home-ii wpisset-no-sidebar wpisset-sticky-nav wpisset-footer-bottom-active wpisset-cat-menu-always-active wpisset-responsive-breakpoints wpisset-medium-breakpoint-768 wpisset-desktop-breakpoint-992 wpisset-header-nav-variant2 wpisset-woo-sidebar-left wpisset-yith-wishlist wpisset-yith-compare wpb-js-composer js-comp-ver-6.6.0 vc_responsive'
          @page_title = 'Tìm Hàng Công Nghệ &#8211; Chuyên Laptop, PC, LCD Và Thiết Bị Tin Học'
          @mate_description = 'Tìm Hàng Công Nghệ là đơn vị cung cấp các sản phẩm, dịch vụ thuộc lĩnh vực Công Nghệ Thông Tin do Công Ty TNHH Giải Pháp CNTT Và Truyền Thông Hoàng Khang phụ trách và phát triển.'
          @menus = Erp::Menus::Menu.get_parent_menus

          @laptop_brands = Erp::Products::Brand.get_laptop_brands
          @laptop_products = Erp::Menus::Menu.get_laptop_menu.get_products_for_categories(params).limit(6)
          
          @sale_product = Erp::Products::Product.find(9341)
          @hot_menus = Erp::Menus::Menu.get_hot_parent_menus
          
          @apple = Erp::Products::Brand.find(16).get_products_home_page
          @desktop = Erp::Products::Category.find(242).get_products_home_page
          @workstation = Erp::Products::Category.find(33).get_products_home_page
          @server = Erp::Products::Category.find(90).get_products_home_page
          @aio = Erp::Products::Category.find(32).get_products_home_page
          @monitor_pc = Erp::Products::Category.find(196).get_products_home_page
          @monitor_signage = Erp::Products::Category.find(134).get_products_home_page
          @camera = Erp::Products::Category.find(204).get_products_home_page
          
          @computer_components = Erp::Products::Product.get_computer_components
          @computer_accessories = Erp::Products::Product.get_computer_accessories
          @network = Erp::Products::Product.get_network_products
          @printer = Erp::Products::Product.get_printer_products
          
          @newest_products = Erp::Products::Product.get_newest_products
        end
        
        def auth_failure
          redirect_to erp_online_store.root_path, flash: {notice: 'Thao tác không thành công.'}
        end
      end
    end
  end
end