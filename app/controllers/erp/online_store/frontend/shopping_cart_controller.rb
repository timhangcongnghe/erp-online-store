module Erp
  module OnlineStore
    module Frontend
      class ShoppingCartController < Erp::Frontend::FrontendController
        def shopping_cart
          @body_class = "res layout-subpage"
        end

        def add_main_contact
          if params[:contact].present?
            if current_user.contact.nil?
              @contact = Erp::Contacts::Contact.new(user_id: current_user.id)
              @contact.assign_attributes(contact_params)
              @contact.creator = current_user
              @contact.contact_type = params[:contact_type].present? ? params[:contact_type] : Erp::Contacts::Contact::TYPE_PERSON
              @contact.user = current_user

              if @contact.save
                current_user.update_columns(contact_id: @contact.id)
                redirect_to erp_online_store.checkout_path(selected_contact_id: @contact.id),
                            flash: {success: "Thông tin khách hàng đã được cập nhật."}
              else
                redirect_to :back, flash: {error: "Thông tin chưa được cập nhật. Vui lòng thử lại."}
              end
            else
              @contact = Erp::Contacts::Contact.new(parent_id: current_user.contact.id)
              @contact.assign_attributes(contact_params)
              @contact.creator = current_user
              @contact.contact_type = params[:contact_type].present? ? params[:contact_type] : Erp::Contacts::Contact::TYPE_SHIPPING

              if @contact.save
                redirect_to erp_online_store.checkout_path(selected_contact_id: @contact.id), flash: {success: "Địa chỉ giao hàng đã thêm thành công."}
              else
                redirect_to :back, flash: {error: "Địa chỉ giao hàng chưa được cập nhật. Vui lòng thử lại."}
              end
            end
          end
        end
        
        def contact_form
          @contact = params[:contact_id].present? ? Erp::Contacts::Contact.find(params[:contact_id]) : Erp::Contacts::Contact.new
          render layout: nil
        end
        
        # edit contact
        def update_contact
          @contact = Erp::Contacts::Contact.find(params[:contact][:contact_id])
          if params[:contact].present?
            @contact.update(contact_params)
            redirect_to :back, notice: 'Thông tin liên hệ đã được cập nhật.'
          end
        end
        
        # delete sub-contact
        def delete_sub_contact
          @sub_contact = Erp::Contacts::Contact.find(params[:contact_id])

          @sub_contact.destroy
          redirect_to erp_online_store.checkout_path, notice: 'Địa chỉ giao hàng đã được xóa'
        end

        def checkout
          @body_class = "res layout-subpage"
          if @cart.cart_items.empty?
            redirect_to erp_online_store.shopping_cart_path
            return
          end
          
          if current_user.nil?
            redirect_to erp_online_store.shopping_cart_path, notice: "Bạn phải đăng nhập để đặt hàng."
            return
          end

          if !current_user.nil?
            if params[:selected_contact_id].present?
              @selected_contact = Erp::Contacts::Contact.find(params[:selected_contact_id])
            else
              @selected_contact = current_user.contact
            end
          end

          # @todo check if contact not belongs to user


          if params[:order].present?
            @order = Erp::Orders::FrontendOrder.new(order_params)
            @order.creator = current_user
            @order.status = Erp::Orders::FrontendOrder::STATUS_DRAFT
            @order.customer_id = current_user.contact_id

            if @order.save
              @order.save_from_cart(@cart)
              Erp::Carts::Cart.destroy(session[:cart_id])

              @order.update_columns(
                data: {
                  "customer": {
                    "name": @order.customer.name,
                    "phone": @order.customer.phone,
                    "address": @order.customer.address,
                    "district": @order.customer.district.name,
                    "state": @order.customer.state.name
                  },
                  "consignee": {
                    "name": @order.consignee.name,
                    "phone": @order.consignee.phone,
                    "address": @order.consignee.address,
                    "district": @order.consignee.district.name,
                    "state": @order.consignee.state.name
                  }
                }.to_json
              )

              # send order email for admin + customer
              Erp::Orders::FrontendOrderMailer.sending_admin_email_order_confirmation(@order).deliver_later
              Erp::Orders::FrontendOrderMailer.sending_customer_email_order_confirmation(@order).deliver_later

              redirect_to erp_online_store.checkout_completed_path, notice: "Đặt hàng thành công."
            else
              redirect_to :back, notice: "Đặt hàng không thành công. Thử lại?"
            end
          end
        end

        def compare
          @body_class = "res layout-subpage"
        end

        def top_cart
          render partial: 'erp/online_store/frontend/shopping_cart/top_cart', layout: nil
        end

        private
          def contact_params
            params.fetch(:contact, {}).permit(:name, :phone, :email, :state_id, :district_id, :address)
          end

          def order_params
            params.fetch(:order, {}).permit(:code, :status, :customer_id, :consignee_id, :data, :note)
          end
      end
    end
  end
end
