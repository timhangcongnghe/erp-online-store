Erp::Contacts::ContactMailer.class_eval do
  def sending_email_contact(msg)
    @msg = msg
    #@todo static emails
    @recipients = ['Liên hệ THCN <lienhe@timhangcongnghe.com>']
    @bccmails = ['Hùng Nguyễn <hungnt@hoangkhang.com.vn>', 'Luân Phạm <luanpm@hoangkhang.com.vn>', 'Sơn Nguyễn <sonnn@hoangkhang.com.vn>']
    send_email(@recipients.join("; "), @bccmails.join("; "), "Nội dung tin nhắn liên hệ/góp ý từ #{@msg.contact.email}")
  end
end
