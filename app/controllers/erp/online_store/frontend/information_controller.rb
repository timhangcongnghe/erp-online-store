module Erp
  module OnlineStore
    module Frontend
      class InformationController < Erp::Frontend::FrontendController
        def about_us
          @body_class = "res layout-subpage"
          @testimonials = Erp::Testimonials::Testimonial.get_testimonials
        end
    
        def faq
          @body_class = "res layout-subpage"
          @categories = Erp::Articles::Category.get_categories_by_alias_group
          @faqs = Erp::Articles::Article.get_faqs
        end
        
        def policy
          @categories = Erp::Articles::Category.get_categories_by_alias_group
          @article = Erp::Articles::Category.find(params[:category_id]).articles.where(archived: false).last
        end
    
        def contact_us
          @body_class = "res layout-subpage"
          
          @company_info = Erp::Contacts::Contact.get_main_contact
          
          if params[:contact].present?
            @contact = Erp::Contacts::Contact.new(contact_params)
            @contact.contact_type = Erp::Contacts::Contact::TYPE_PERSON
            if @contact.save and params[:msg].present?
              @msg = Erp::Contacts::Message.new(message_params)
              @msg.contact_id = @contact.id
              # @todo get email receive contact
              @msg.to_contact_id = Erp::Contacts::Contact.first.id
              respond_to do |format|
                if @msg.save
                  Erp::Contacts::ContactMailer.sending_email_contact(@msg).deliver_now
                  format.html {
                    redirect_back(fallback_location: @contact, notice: 'Yêu cầu đã gửi thành công.\n Chúng tôi sẽ liên hệ cho bạn trong thời gian sớm nhất.')
                  }
                end
              end
            else
              redirect_back(fallback_location: @contact, flash: { error: 'Không thể gửi đi do một số trường đang bị bỏ trống.' })
            end
          end
        end
    
        def terms_and_conditions
          @categories = Erp::Articles::Category.get_categories_by_alias_group
          @terms_conditions = Erp::Articles::Article.get_terms_and_conditions
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
