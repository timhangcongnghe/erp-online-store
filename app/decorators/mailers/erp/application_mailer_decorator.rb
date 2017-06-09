Erp::ApplicationMailer.class_eval do
  default from: "TimHangCongNghe.vn <no-reply@timhangcongnghe.vn>"
  layout 'mailer'

  private
  def send_email(email, subject)
    #@todo static email!!
    delivery_options = {
      address: 'smtp.zoho.com',
      port: 465,
      domain: 'timhangcongnghe.vn',
      user_name: 'no-reply@timhangcongnghe.vn',
      password: 'aA456321@#$',
      authentication: 'plain',
      ssl: true,
      tls: true,
      enable_starttls_auto: true,
      openssl_verify_mode: 'none'
    }
    mail(to: email,
      subject: subject,
      delivery_method_options: delivery_options)
  end
end