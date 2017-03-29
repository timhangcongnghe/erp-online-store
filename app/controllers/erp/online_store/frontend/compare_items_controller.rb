module Erp
  module OnlineStore
    module Frontend
      class CompareItemsController < Erp::Frontend::FrontendController
        # POST /compare_items
        # POST /ccompare_items.json
        def add_to_compare
          exist = Erp::Carts::CompareItem.where(product_id: params[:product_id]).where(compare_id: @compare.id)
          
          if exist.count == 0
            product = Erp::Products::Product.find(params[:product_id])
            @compare_item = @compare.compare_items.build(product: product)        
            if @compare_item.save
              render json: {
                message: 'Thêm sản phẩm vào mục so sánh thành công.',
                type: 'success',
                title: 'Thông báo'
              }
            end
          else
            render json: {
              message: 'Sản phẩm đã được thêm trước đó.',
              type: 'warning',
              title: 'Thông báo'
            }
          end
        end
        
        def remove_compare_item
          @compare.remove_compare_item(params[:compare_item_id])          
          redirect_to erp_online_store.compare_product_path, notice: 'Xóa sản phẩm khỏi mục so sánh thành công.'
        end
      end
    end
  end
end
