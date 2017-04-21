module Erp
  module OnlineStore
    module Frontend
      class AreaController < Erp::Frontend::FrontendController
        def district_select
          state = Erp::Areas::State.find(params[:state_id])
          @districts = state.get_districts

          render layout: nil
        end
      end
    end
  end
end
