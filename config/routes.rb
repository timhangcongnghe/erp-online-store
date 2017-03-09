Erp::TimhangcongngheVn::Engine.routes.draw do
  root to: "frontend/home#index"
  
  # CATEGORY
  get "chuyen-muc-san-pham.html" => "frontend/category#index", as: :category
  get "chuyen-muc-san-pham/chi-tiet-san-pham.html" => "frontend/category#product_detail", as: :product_detail
  get "xem-nhanh.html" => "frontend/category#product_quickview", as: :product_quickview
  
  # BLOG
  get "danh-sach-bai-viet.html" => "frontend/blog#index", as: :blog
  get "danh-sach-bai-viet/chi-tiet-bai-viet.html" => "frontend/blog#detail", as: :blog_detail
  
  # ACCOUNT
  get "dang-nhap.html" => "frontend/account#login", as: :login
  get "dang-ky.html" => "frontend/account#register", as: :register
  get "tai-khoan/thong-tin-tai-khoan.html" => "frontend/account#my_account", as: :my_account
  get "tai-khoan/lich-su-mua-hang.html" => "frontend/account#order_history", as: :order_history
  get "tai-khoan/chi-tiet-don-hang.html" => "frontend/account#order_information", as: :order_information
  get "tai-khoan/san-pham-tra-lai.html" => "frontend/account#product_returns", as: :product_returns
  get "tai-khoan/ma-khuyen-mai.html" => "frontend/account#gift_voucher", as: :gift_voucher
  get "tai-khoan/san-pham-yeu-thich.html" => "frontend/account#wishlist", as: :wishlist
  
  # SHOPPING CART
  get "gio-hang.html" => "frontend/shopping_cart#cart", as: :cart
  get "dat-hang.html" => "frontend/shopping_cart#checkout", as: :checkout
  get "so-sanh-san-pham.html" => "frontend/shopping_cart#compare", as: :compare
  
  # INFORMATION
  get "gioi-thieu.html" => "frontend/information#about_us", as: :about_us
  get "cau-hoi-thuong-gap.html" => "frontend/information#faq", as: :faq
  get "lien-he-gop-y.html" => "frontend/information#contact_us", as: :contact_us
  get "cac-dieu-khoan-va-dieu-kien.html" => "frontend/information#terms_and_conditions", as: :terms_and_conditions
  get "site-map.html" => "frontend/information#site_map", as: :site_map
end