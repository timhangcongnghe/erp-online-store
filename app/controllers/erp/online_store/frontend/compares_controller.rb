module Erp
  module OnlineStore
    module Frontend
      class ComparesController < Erp::Frontend::FrontendController
        rescue_from ActiveRecord::RecordNotFound, with: :invalid_compare
        private
        
          def invalid_compare
            logger.error "Không thể truy cập vào mục so sánh này: #{params[:id]}"
            redirect_to erp_online_store.root_path, notice: 'So sánh không hợp lệ'
          end
      end
    end
  end
end