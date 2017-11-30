Erp::QuickOrders::QuickOrderMailer.class_eval do
  
  def sending_admin_email_order_confirmation(quick_order)
    @recipients = ['Kinh Doanh <kinhdoanh@hoangkhang.com.vn>']
    @bccmails = ['Hùng Nguyễn <hungnt@hoangkhang.com.vn>', 'Luân Phạm <luanpm@hoangkhang.com.vn>', 'Sơn Nguyễn <sonnn@hoangkhang.com.vn>', 'Nguyên Đỗ <nguyendtd@hoangkhang.com.vn>']
    #@recipients = ['Sơn Nguyễn <sonnn@hoangkhang.com.vn>']
    #@bccmails = []
    
    @quick_order = quick_order
    send_email(@recipients.join("; "), @bccmails.join("; "), "[THCN] -#{Time.current.strftime('%Y%m%d')}- YÊU CẦU ĐẶT HÀNG TRÊN TÌM HÀNG CÔNG NGHỆ")
  end
  
  def sending_customer_email_order_confirmation(quick_order)
    @quick_order = quick_order
    send_email(@quick_order.email, '', "#{Time.current.strftime('%Y%m%d')} - XÁC NHẬN ĐƠN ĐẶT HÀNG")
  end
  
end