Erp::ApplicationMailer.class_eval do
  default from: "TimHangCongNghe.com <noreply@timhangcongnghe.com>"
  layout 'mailer'

  private
  def send_email(email, email_bcc, subject)
    #@todo static email!!
    delivery_options = {
      address: 'smtp.zoho.com',
      port: 465,
      domain: 'timhangcongnghe.com',
      user_name: 'noreply@timhangcongnghe.com',
      password: 'aA456321@#$',
      authentication: 'plain',
      ssl: true,
      tls: true,
      enable_starttls_auto: true,
      openssl_verify_mode: 'none'
    }
    mail(to: email,
      bcc: email_bcc,
      subject: subject,
      delivery_method_options: delivery_options)
  end
end