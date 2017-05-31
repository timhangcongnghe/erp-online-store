module Erp
  module OnlineStore
    module Frontend
      class OnlineOrderingController < Erp::Frontend::FrontendController
        include Erp::OnlineStore::ApplicationHelper

        def index
          render layout: nil
        end

        def search
          @page = params[:page].present? ? params[:page] : 1

          @ebay_result = Erp::Products::Product::ebay_find_items_by_keywords(params[:keywords], {
            per_page: 16,
            page: @page
          })

          render layout: nil
        end

        def product_detail
          # @ebay_item = Erp::Products::Product::ebay_get_single_item(params[:id])
          @product = Erp::Products::Product::get_ebay_product(params[:id])

          redirect_to product_link(@product)
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
