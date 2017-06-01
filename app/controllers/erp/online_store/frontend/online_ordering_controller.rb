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
          if params[:keywords].include?("amazon.com/gp/product/")
            id = params[:keywords].split('amazon.com/gp/product/')[1].split('/').first
            if id.length > 8 and id.length < 12
              redirect_to erp_online_store.online_ordering_product_detail_path(id: id, service: 'amazon')
              return
            end
          end

          # check if keywords is ebay details link
          if params[:keywords].include?("amazon.com/dp/")
            id = params[:keywords].split('amazon.com/dp/')[1].split('/').first
            if id.length > 8 and id.length < 12
              redirect_to erp_online_store.online_ordering_product_detail_path(id: id, service: 'amazon')
              return
            end
          end

          # check if keywords is ebay details link
          if params[:keywords].include?("ebay.com/itm")
            id = params[:keywords].split('?')[0].split('/').last
            if (true if Float(id) rescue false)
              redirect_to erp_online_store.online_ordering_product_detail_path(id: id)
              return
            end
          end
        end

        def search_ebay
          @page = params[:page].present? ? params[:page] : 1
          @ebay_result = Erp::Products::Product::ebay_find_items_by_keywords(params[:keywords], {
            per_page: 16,
            page: @page
          })

          render layout: nil
        end

        def search_amazon
          @amazon_result = Erp::Products::Product::amazon_find_items_by_keywords(params[:keywords], {
            per_page: 16,
            page: @page
          })

          render layout: nil
        end

        def product_detail
          @product = Erp::Products::Product::get_ebay_product(params[:id]) if params[:service] == 'ebay'
          @product = Erp::Products::Product::get_amazon_product(params[:id]) if params[:service] == 'amazon'
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
