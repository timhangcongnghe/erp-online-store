Erp::QuickOrders::QuickOrderMailer.class_eval do
  def sending_admin_email_order_confirmation(quick_order)    
    @recipients = ['Kinh Doanh <kinhdoanh@hoangkhang.com.vn>']
    @bccmails = ['Trương Thị Thanh Huyền <huyenttt@hoangkhang.com.vn>', 'Đỗ Thị Đa Nguyên <nguyendtd@hoangkhang.com.vn>']
    
    @quick_order = quick_order
    send_email(@recipients.join("; "), @bccmails.join("; "), "[Tìm Hàng Công Nghệ] - Đơn Đặt Đặt Hàng #{Time.current.strftime('%Y%m%d')}")
  end
  
  def sending_customer_email_order_confirmation(quick_order)
    @quick_order = quick_order
    send_email(@quick_order.email, '', "[Tìm Hàng Công Nghệ] - Xác Nhận Đơn Hàng #{Time.current.strftime('%Y%m%d')}")
  end
end