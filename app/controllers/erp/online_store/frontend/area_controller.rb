module Erp
  module OnlineStore
    module Frontend
      class AreaController < Erp::Frontend::FrontendController
        def district_select
          if params[:state_id].present?
            state = Erp::Areas::State.find(params[:state_id])
            @districts = state.get_districts
          else
            @districts = []
          end

          render layout: nil
        end
      end
    end
  end
end
