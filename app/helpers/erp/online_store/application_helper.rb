module Erp
  module OnlineStore
    module ApplicationHelper
      
      # display stars rating
      def stars(number)
        strs = []
        (1..5).each do |star|
          strs << "<span class=\"fa fa-stack\"><i class=\"fa fa-star#{(number >= star ? '' : '-o')} fa-stack-2x\"></i></span>"
        end
        strs.join('')
      end
      
    end
  end
end
