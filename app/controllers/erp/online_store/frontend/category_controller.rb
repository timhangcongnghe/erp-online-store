module Erp
  module OnlineStore
    module Frontend
      class CategoryController < Erp::Frontend::FrontendController
        def index
        end
        
        def list
          @class = 'archive post-type-archive post-type-archive-product wp-custom-logo wp-embed-responsive theme-eletra thcn-shop thcn thcn-page thcn-no-js wpisset wpisset-aplle-iphone-12-64-gb-green wpisset-no-sidebar wpisset-sticky-nav wpisset-footer-bottom-active wpisset-responsive-breakpoints wpisset-medium-breakpoint-768 wpisset-desktop-breakpoint-992 wpisset-header-nav-variant2 wpisset-woo-sidebar-left wpisset-yith-wishlist wpisset-yith-compare wpisset-wpb wpb-js-composer js-comp-ver-6.6.0 vc_responsive'
          @category = Erp::Menus::Menu.find(params[:category_id])
          @page_title = @category.get_custom_title.to_s + ' &#8211; Tìm Hàng Công Nghệ'
          @menus = Erp::Menus::Menu.get_parent_menus
          @newest_products = Erp::Products::Product.get_newest_products
          @related_categories = @category.get_children

          if !@category.not_create_link?
            if (@category.is_redirect?) && (@category.redirect_id.present?)
              redirect_to erp_online_store.category_list_path(category_id: @category.redirect_id, category_alias: Erp::Menus::Menu.find(@category.redirect_id).alias, reid: @category, rename: @category.alias), status: 301
            end
          end

          if @category.not_create_link?
            redirect_to root_link, status: 301
          end
          
          if params[:re_id].present?
            @redirect_category = Erp::Menus::Menu.find(params[:re_id])
          end
          
          @products = @category.get_products_for_categories(params).paginate(page: params[:page], per_page: 20)
        end
      end
    end
  end
end