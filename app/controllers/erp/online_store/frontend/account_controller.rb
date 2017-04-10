module Erp
  module OnlineStore
    module Frontend
      class AccountController < Erp::Frontend::FrontendController
        def login
          @body_class = "res layout-subpage"
        end
    
        def register
          @body_class = "res layout-subpage"
        end
    
        def my_account
          @body_class = "res layout-subpage"
          
          @contact = !current_user.contact.nil? ? current_user.contact : Erp::Contacts::Contact.new(user_id: current_user.id)
          
          # Create contact for currnet_user if contact user does not exists
          if params[:contact].present?
            @contact.assign_attributes(contact_params)
            @contact.creator = current_user
            @contact.contact_type = params[:contact_type].present? ? params[:contact_type] : Erp::Contacts::Contact::TYPE_PERSON
            @contact.user = current_user
            
            @contact.user.update(user_params)
            
            if @contact.save
              current_user.update_columns(contact_id: @contact.id)
              redirect_to :back, flash: {success: "Thông tin cá nhân đã được cập nhật."}
            else
              redirect_to :back, flash: {error: "Thông tin chưa được cập nhật. Vui lòng thử lại."}
            end
          end        
        end
        
        def update_password
          # change password for user
          @user = current_user
      
          # check current password is valid
          if params[:user].present? and !@user.valid_password?(params[:user][:current_password])
            redirect_to :back, flash: { error: "Mật khẩu hiện tại không đúng." }
            return
          end
          
          if params[:user].present?
            params[:user].delete(:password) if params[:user][:password].blank?
            params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
            
            if @user.update_with_password(user_params)
              bypass_sign_in(@user)
              redirect_to :back, flash: { notice: "Mật khẩu mới đã được cập nhật." }
            else
              if params[:user][:password].length < 6
                redirect_to :back, flash: { error: "Mật khẩu phải chứa ít nhất 6 ký tự." }
              else
                redirect_to :back, flash: { error: "Mật khẩu không trùng khớp." }
              end
            end
          end
        end
    
        def order_history
          @body_class = "res layout-subpage"
        end
    
        def order_information
          @body_class = "res layout-subpage"
        end
        
        private
          def user_params
            params.fetch(:user, {}).permit(:avatar, :current_password, :password, :password_confirmation)
          end
          
          def contact_params
            params.fetch(:contact, {}).permit(:name, :phone, :email, :birthday, :gender, :address)
          end
      end
    end
  end
end
