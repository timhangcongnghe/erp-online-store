module Erp
  module OnlineStore
    module Frontend
      class InformationController < Erp::Frontend::FrontendController
        def about_us
          @body_class = "res layout-subpage"
        end
    
        def faq
          @body_class = "res layout-subpage"
        end
    
        def contact_us
          @body_class = "res layout-subpage"
          
          if params[:contact].present?
            @contact = Erp::Contacts::Contact.new(contact_params)
            @contact.contact_type = Erp::Contacts::Contact::TYPE_PERSON
            if @contact.save and params[:msg].present?
              @msg = Erp::Contacts::Message.new(message_params)
              @msg.contact_id = @contact.id
              @msg.to_contact_id = Erp::Contacts::Contact.first.id
              respond_to do |format|
                if @msg.save
                  Erp::Contacts::ContactMailer.sending_email_contact(@msg).deliver_now
                  format.html { redirect_to :back, notice: 'Yêu cầu đã gửi thành công. Chúng tôi sẽ liên hệ cho Quý khách trong thời gian sớm nhất.' }
                end
              end
            end
          end
        end
    
        def terms_and_conditions
        end
    
        def site_map
          @body_class = "res layout-subpage"
        end
        
        private
          def contact_params
            params.fetch(:contact, {}).permit(:name, :email, :phone)
          end
          
          def message_params
            params.fetch(:msg, {}).permit(:message)
          end
      end
    end
  end
end
