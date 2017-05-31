module Erp
  module OnlineStore
    module Frontend
      class OnlineOrderingController < Erp::Frontend::FrontendController
        layout 'erp/frontend/order'
        include Erp::OnlineStore::ApplicationHelper

        def index
        end

        def search
          # check if keywords is ebay details link
          if params[:keywords].include?("ebay.com/itm")
            id = params[:keywords].split('?')[0].split('/').last
            if (true if Float(id) rescue false)
              redirect_to erp_online_store.online_ordering_product_detail_path(id: id)
              return
            end
          end

          @page = params[:page].present? ? params[:page] : 1
          @ebay_result = Erp::Products::Product::ebay_find_items_by_keywords(params[:keywords], {
            per_page: 16,
            page: @page
          })

          @amazon_result = Erp::Products::Product::amazon_find_items_by_keywords(params[:keywords], {
            per_page: 16,
            page: @page
          })
        end

        def product_detail
          @ebay_item = Erp::Products::Product::ebay_get_single_item(params[:id])
          @product = Erp::Products::Product::get_ebay_product(params[:id])
        end

        def cart
        end

        def checkout
        end

        def summary
        end
      end
    end
  end
end
