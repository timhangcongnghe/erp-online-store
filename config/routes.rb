Erp::OnlineStore::Engine.routes.draw do
  root to: "frontend/home#index"

  get "category-box" => "frontend/home#category_box", as: :category_box
  get "/auth/failure" => "frontend/home#auth_failure", as: :auth_failure

  # AREA
  get "district-select-box.html" => "frontend/area#district_select", as: :district_select

  # CATEGORY
  get "tim-kiem.html" => "frontend/product#search", as: :search
  get "san-pham/thuoc-tinh/:product_id.html" => "frontend/product#all_property", as: :all_property
  get "san-pham/:product_id(/:title).html" => "frontend/product#product_detail", as: :product_detail
  get "chuyen-muc(/:menu_id)(/:title).html" => "frontend/category#index", as: :category
  post "chuyen-muc/chi-tiet-san-pham.html" => "frontend/product#product_detail"
  get "binh-luan-san-pham.html" => "frontend/product#comments", as: :product_comments
  post "binh-luan-san-pham.html" => "frontend/product#comments"
  delete "binh-luan-san-pham/:comment_id-remove.html" => "frontend/product#delete_comment", as: :delete_product_comment
  get "danh-gia-san-pham.html" => "frontend/product#ratings", as: :product_ratings
  post "danh-gia-san-pham.html" => "frontend/product#ratings"
  delete "danh-gia-san-pham/:rating_id-remove.html" => "frontend/product#delete_rating", as: :delete_product_rating
  get "san-pham-khuyen-mai.html" => "frontend/category#deal_products", as: :deal_products
  get "san-pham-ban-chay.html" => "frontend/category#bestseller_products", as: :bestseller_products
  get "lua-chon-tu-doanh-nghiep.html" => "frontend/business_choices#index", as: :business_choices

  # BLOG
  get "tin-cong-nghe.html" => "frontend/blog#index", as: :blog
  get "tin-cong-nghe/:blog_id(/:title).html" => "frontend/blog#detail", as: :blog_detail
  get "tin-cong-nghe/chu-de/:cat_id(/:title).html" => "frontend/blog#index", as: :blog_with_category
  get "binh-luan-bai-viet.html/:blog_id" => "frontend/blog#comments", as: :blog_comments
  post "binh-luan-bai-viet.html/:blog_id" => "frontend/blog#comments"
  delete "binh-luan-bai-viet/:comment_id-remove.html" => "frontend/blog#delete_comment", as: :delete_blog_comment

  # EVENTS
  get "su-kien.html" => "frontend/events#index", as: :events
  get "su-kien/:event_id(/:title).html" => "frontend/events#event_detail", as: :event_detail

  # ACCOUNT
  get "tai-khoan/thong-tin-tai-khoan.html" => "frontend/account#my_account", as: :my_account
  post "tai-khoan/thong-tin-tai-khoan.html" => "frontend/account#my_account"
  get "tai-khoan/cap-nhat-mat-khau.html" => "frontend/account#update_password", as: :update_password
  post "tai-khoan/cap-nhat-mat-khau.html" => "frontend/account#update_password"
  get "tai-khoan/lich-su-mua-hang.html" => "frontend/account#order_history", as: :order_history
  get "tai-khoan/chi-tiet-don-hang/:order_id-:title.html" => "frontend/account#order_information", as: :order_information

  # SHOPPING CART
  get "topcart.html" => "frontend/shopping_cart#top_cart", as: :top_cart
  get "gio-hang.html" => "frontend/shopping_cart#shopping_cart", as: :shopping_cart
  get "dat-hang(/coid-:selected_contact_id).html" => "frontend/shopping_cart#checkout", as: :checkout
  post "dat-hang.html" => "frontend/shopping_cart#checkout"
  delete "dat-hang/:contact_id-remove.html" => "frontend/shopping_cart#delete_sub_contact", as: :delete_sub_contact
  get "dat-hang/thanh-cong.html" => "frontend/shopping_cart#success", as: :checkout_completed
  get "tao-moi-lien-he.html" => "frontend/shopping_cart#add_main_contact", as: :add_main_contact
  post "tao-moi-lien-he.html" => "frontend/shopping_cart#add_main_contact"
  get "new-contact-form.html" => "frontend/shopping_cart#contact_form", as: :contact_form
  get "cap-nhat-lien-he.html" => "frontend/shopping_cart#update_contact", as: :update_contact
  post "cap-nhat-lien-he.html" => "frontend/shopping_cart#update_contact"
  get "so-sanh-san-pham.html" => "frontend/shopping_cart#compare_product", as: :compare_product

  # BUSINESS PAGE
  get "uu-dai-doanh-nghiep.html" => "frontend/business_page#index", as: :business_page
  get "uu-dai-doanh-nghiep/chi-tiet-bai-viet.html" => "frontend/business_page#news_detail", as: :news_detail
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
  get "gop-y-lien-he.html" => "frontend/information#contact_us", as: :contact_us
  post "gop-y-lien-he.html" => "frontend/information#contact_us"
  get "thong-tin/cau-hoi-thuong-gap.html" => "frontend/information#faq", as: :faq
  get "thong-tin/cac-dieu-khoan-va-dieu-kien.html" => "frontend/information#terms_and_conditions", as: :terms_and_conditions
  get "thong-tin/:category_id(/:title).html" => "frontend/information#policy", as: :policy
  get "site-map.html" => "frontend/information#site_map", as: :site_map

  # BRAND
  get "thuong-hieu-san-pham.html" => "frontend/brand#listing", as: :brand_listing
  get "thuong-hieu-san-pham(/:brand_id)(/:title).html" => "frontend/brand#detail", as: :brand_detail

  # SERVICES
  get "dich-vu-sua-chua-bao-tri.html" => "frontend/services#computer_services", as: :computer_services
  get "thi-cong-ha-tang-mang.html" => "frontend/services#network_services", as: :network_services

  # HOME
  get "top-right-menu.html" => "frontend/home#top_right_menu", as: :top_right_menu

  #@todo online store
	get "autosearch" => "frontend/product#autosearch", as: :autosearch

	# NEWSLETTER
	# @todo newsletters routes errors
	Erp::Newsletters::Engine.routes.draw do
		get "dang-ky-nhan-tin.html" => "frontend/newsletters#add_email_to_newsletter", as: :newsletters
		post "dang-ky-nhan-tin.html" => "frontend/newsletters#add_email_to_newsletter"
	end
end
