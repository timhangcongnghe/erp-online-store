Erp::OnlineStore::Engine.routes.draw do
  root to: "frontend/home#index"
  
  get "category-box" => "frontend/home#category_box", as: :category_box
  # CATEGORY
  get "chuyen-muc-san-pham.html" => "frontend/category#index", as: :category
  get "chuyen-muc-san-pham/chi-tiet-san-pham.html" => "frontend/product#product_detail", as: :product_detail
  get "chuyen-muc-san-pham/binh-luan.html" => "frontend/product#comments", as: :product_comments
  post "chuyen-muc-san-pham/binh-luan.html" => "frontend/product#comments"
  get "chuyen-muc-san-pham/danh-gia.html" => "frontend/product#ratings", as: :product_ratings
  post "chuyen-muc-san-pham/danh-gia.html" => "frontend/product#ratings"
  post "chuyen-muc-san-pham/chi-tiet-san-pham.html" => "frontend/product#product_detail"
  get "xem-nhanh.html" => "frontend/product#product_quickview", as: :product_quickview
  get "san-pham-khuyen-mai.html" => "frontend/category#deal_products", as: :deal_products
  get "san-pham-ban-chay-nhat.html" => "frontend/category#bestseller_products", as: :bestseller_products
  get "lua-chon-cua-doanh-nghiep.html" => "frontend/business_choices#index", as: :business_choices
  
  # BLOG
  get "danh-sach-bai-viet.html" => "frontend/blog#index", as: :blog
  get "danh-sach-bai-viet/:cat_id(/:title).html" => "frontend/blog#index", as: :blog_with_category
  get "bai-viet/:blog_id(/:title).html" => "frontend/blog#detail", as: :blog_detail
  get "bai-viet/binh-luan.html/:blog_id" => "frontend/blog#comments", as: :blog_comments
  post "bai-viet/binh-luan.html/:blog_id" => "frontend/blog#comments"
  
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
  get "gio-hang.html" => "frontend/shopping_cart#shopping_cart", as: :shopping_cart
  get "dat-hang.html" => "frontend/shopping_cart#checkout", as: :checkout
  get "so-sanh-san-pham.html" => "frontend/shopping_cart#compare_product", as: :compare_product
  namespace :frontend do
		resources :carts
		resources :cart_items do
			collection do
				post "add_to_cart"
				get "remove_cart_item"
			end    
		end
		resources :compares
    resources :compare_items do
      collection do
        post "add_to_compare"
        get "remove_compare_item"
      end    
    end
    resources :wish_lists do
      collection do
        post "add_to_wish_list"
        get "remove_product"
      end    
    end
	end
  
  # INFORMATION
  get "gioi-thieu.html" => "frontend/information#about_us", as: :about_us
  get "lien-he-gop-y.html" => "frontend/information#contact_us", as: :contact_us
  post "lien-he-gop-y.html" => "frontend/information#contact_us"
  get "thong-tin/cau-hoi-thuong-gap.html" => "frontend/information#faq", as: :faq
  get "thong-tin/cac-dieu-khoan-va-dieu-kien.html" => "frontend/information#terms_and_conditions", as: :terms_and_conditions
  get "thong-tin/:category_id(/:title).html" => "frontend/information#policy", as: :policy
  get "site-map.html" => "frontend/information#site_map", as: :site_map
  
  #@todo online store
	get "autosearch" => "frontend/product#autosearch", as: :autosearch
	
	# NEWSLETTER
	# @todo newsletters routes errors
	Erp::Newsletters::Engine.routes.draw do
		get "dang-ky-nhan-tin.html" => "frontend/newsletters#add_email_to_newsletter", as: :newsletters
		post "dang-ky-nhan-tin.html" => "frontend/newsletters#add_email_to_newsletter"
	end
end