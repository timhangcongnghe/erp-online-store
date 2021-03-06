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
          if params[:keywords].include?("amazon.com") and params[:keywords].include?("/dp/")
            id = params[:keywords].split('/dp/')[1].split('/').first.split('?').first
            if id.length > 8 and id.length < 12
              redirect_to erp_online_store.online_ordering_product_detail_path(id: id, service: 'amazon')
              return
            end
          end

          # check if keywords is ebay details link
          if params[:keywords].include?("ebay.") and params[:keywords].include?("/itm")
            id = params[:keywords].split('?')[0].split('/').last
            if (true if Float(id) rescue false)
              redirect_to erp_online_store.online_ordering_product_detail_path(id: id, service: 'ebay')
              return
            end
          end

          # Check if raw link
          if params[:keywords].include?("http")
            render "raw_link"
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
          if params[:service] == 'ebay'
            result = Erp::Products::Product::get_ebay_product(params[:id])
            @product = result[:product]
            @item = result[:item]
          elsif params[:service] == 'amazon'
            result = Erp::Products::Product::get_amazon_product(params[:id])
            @product = result[:product]
            @item = result[:item]
          end
        end

        def related_items
          if params[:service] == 'ebay'
            @related_items = Erp::Products::Product::ebay_find_related_items(params[:id], options={per_page: 12, page: 1})
          elsif params[:service] == 'amazon'
            @related_items = {items: []}
          end

          render layout: nil
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
