module Erp
  module OnlineStore
    module Frontend
      class WishListsController < Erp::Frontend::FrontendController
        before_action :set_wish_list, only: [:destroy]
        
        # POST /wish_lists
        # POST /wish_lists.json
        def add_to_wish_list
          exist = Erp::Carts::WishList.where(product_id: params[:product_id]).where(user_id: current_user.id)
          
          if exist.count == 0
            @wish_list = Erp::Carts::WishList.new(
              product_id: params[:product_id],
              user_id: current_user.id
            )
            if @wish_list.save
              redirect_to erp_online_store.wishlist_path, notice: 'Thêm yêu thích sản phẩm thành công.'
            end
          else
            redirect_to erp_online_store.wishlist_path, notice: 'Đã yêu thích sản phẩm trước đó.'
          end
        end
        
        # DELETE /wish_lists/1
        # DELETE /wish_lists/1.json
        def destroy
          @wish_list.destroy
          redirect_to erp_online_store.wishlist_path, notice: 'Hủy yêu thích sản phẩm thành công.'
        end
        
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_wish_list
            @wish_list = Erp::Carts::WishList.find(params[:id])
          end 
      end
    end
  end
end