Erp::Orders::FrontendOrderMailer.class_eval do
  
  def sending_admin_email_order_confirmation(order)
    # @todo static emails
    @recipients = ['Kinh Doanh THCN <kinhdoanh@timhangcongnghe.com>']
    @bccmails = ['Hùng Nguyễn <hungnt@hoangkhang.com.vn>', 'Luân Phạm <luanpm@hoangkhang.com.vn>', 'Sơn Nguyễn <sonnn@hoangkhang.com.vn>']
    
    #@recipients = ['Sơn Nguyễn <sonnn@hoangkhang.com.vn>']
    #@bccmails = []
    
    @order = order
    send_email(@recipients.join("; "), @bccmails.join("; "), "##{@order.code} - Thông tin đơn hàng vừa được đặt trên hệ thống")
  end
  
  def sending_customer_email_order_confirmation(order)
    @order = order
    send_email(@order.customer.email, '', "##{@order.code} - Xác nhận đặt hàng thành công")
  end
end