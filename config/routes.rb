Erp::OnlineStore::Engine.routes.draw do
	root to: "frontend/home#index"
	
	# START PRODUCT & CATEGORY
	get "san-pham/:product_id(/:title).html" => "frontend/product#product_detail", as: :product_detail #add sitemap
	get "chuyen-muc(/:menu_id)(/:title).html" => "frontend/category#index", as: :category #add sitemap	
	
	get "chuyen-muc-select2.html" => "frontend/category#select2", as: :category_select2
	get "san-pham/thuoc-tinh/:product_id(/:title).html" => "frontend/product#all_property", as: :all_property
	post "chuyen-muc/chi-tiet-san-pham.html" => "frontend/product#product_detail"
	
	get "binh-luan-san-pham.html" => "frontend/product#comments", as: :product_comments
	post "binh-luan-san-pham.html" => "frontend/product#comments"
	delete "binh-luan-san-pham/:comment_id-remove.html" => "frontend/product#delete_comment", as: :delete_product_comment
	
	get "danh-gia-san-pham.html" => "frontend/product#ratings", as: :product_ratings
	post "danh-gia-san-pham.html" => "frontend/product#ratings"
	delete "danh-gia-san-pham/:rating_id-remove.html" => "frontend/product#delete_rating", as: :delete_product_rating
	
	get "xem-nhanh/:product_id(/:title).html" => "frontend/product#product_quickview", as: :product_quickview
	# END PRODUCT & CATEGORY
	
	get "lua-chon-hang-dau.html" => "frontend/business_choices#index", as: :business_choices #add sitemap

	# START BLOG
	get "tin-cong-nghe.html" => "frontend/blog#index", as: :blog #add sitemap
	get "tin-cong-nghe/:blog_id(/:title).html" => "frontend/blog#detail", as: :blog_detail
	get "tin-cong-nghe/chu-de/:cat_id(/:title).html" => "frontend/blog#index", as: :blog_with_category
	get "binh-luan-bai-viet/:blog_id.html" => "frontend/blog#comments", as: :blog_comments
	post "binh-luan-bai-viet/:blog_id.html" => "frontend/blog#comments"
	delete "binh-luan-bai-viet/:comment_id-remove.html" => "frontend/blog#delete_comment", as: :delete_blog_comment
	# END BLOG

	# START EVENTS
	get "tin-su-kien.html" => "frontend/events#index", as: :events #add sitemap
	get "tin-su-kien/:event_id(/:title).html" => "frontend/events#event_detail", as: :event_detail
	# END EVENTS

	# ACCOUNT
	get "tai-khoan/thong-tin-tai-khoan.html" => "frontend/account#my_account", as: :my_account
	post "tai-khoan/thong-tin-tai-khoan.html" => "frontend/account#my_account"
	get "tai-khoan/cap-nhat-mat-khau.html" => "frontend/account#update_password", as: :update_password
	post "tai-khoan/cap-nhat-mat-khau.html" => "frontend/account#update_password"
	get "tai-khoan/danh-sach-don-hang.html" => "frontend/account#order_history", as: :order_history
	get "tai-khoan/chi-tiet-don-hang/:order_id-:title.html" => "frontend/account#order_information", as: :order_information
	get "tai-khoan/so-dia-chi.html" => "frontend/account#address_book", as: :address_book
	get "account-contact-form.html" => "frontend/account#contact_form", as: :account_contact_form
	get "tai-khoan/so-dia-chi/cap-nhat.html" => "frontend/account#contact_update", as: :account_contact_update
	post "tai-khoan/so-dia-chi/cap-nhat.html" => "frontend/account#contact_update"
	delete "tai-khoan/:contact_id-remove.html" => "frontend/account#delete_sub_contact", as: :account_sub_contact_delete

	# START ONLINE ORDERING
	get "topcart.html" => "frontend/shopping_cart#top_cart", as: :top_cart
	get "gio-hang.html" => "frontend/shopping_cart#shopping_cart", as: :shopping_cart
	get "dat-hang(/coid-:selected_contact_id).html" => "frontend/shopping_cart#checkout", as: :checkout
	post "dat-hang.html" => "frontend/shopping_cart#checkout"
	delete "dat-hang/:contact_id-remove.html" => "frontend/shopping_cart#delete_sub_contact", as: :delete_sub_contact
	get "dat-hang/thanh-cong.html" => "frontend/shopping_cart#success", as: :checkout_completed
	get "dat-hang/dat-hang-nhanh.html" => "frontend/quick_order#quick_order", as: :quick_order
	post "dat-hang/dat-hang-nhanh.html" => "frontend/quick_order#quick_order"
	get "tao-moi-lien-he.html" => "frontend/shopping_cart#add_main_contact", as: :add_main_contact
	post "tao-moi-lien-he.html" => "frontend/shopping_cart#add_main_contact"
	get "new-contact-form.html" => "frontend/shopping_cart#contact_form", as: :contact_form
	get "cap-nhat-lien-he.html" => "frontend/shopping_cart#update_contact", as: :update_contact
	post "cap-nhat-lien-he.html" => "frontend/shopping_cart#update_contact"
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
	get "dat-hang-truc-tuyen/chi-tiet-san-pham/lien-quan.html" => "frontend/online_ordering#related_items", as: :online_ordering_related_items
	get "dat-hang-truc-tuyen/tim-kiem/amazon.html" => "frontend/online_ordering#search_amazon", as: :online_ordering_search_amazon
	get "dat-hang-truc-tuyen/tim-kiem/ebay.html" => "frontend/online_ordering#search_ebay", as: :online_ordering_search_ebay
	get "dat-hang-truc-tuyen/tim-kiem.html" => "frontend/online_ordering#search", as: :online_ordering_search
	get "dat-hang-truc-tuyen.html" => "frontend/online_ordering#index", as: :online_ordering
	get "dat-hang-truc-tuyen/chi-tiet-san-pham.html" => "frontend/online_ordering#product_detail", as: :online_ordering_product_detail
	get "dat-hang-truc-tuyen/gio-hang.html" => "frontend/online_ordering#cart", as: :online_ordering_cart
	get "dat-hang-truc-tuyen/dat-hang.html" => "frontend/online_ordering#checkout", as: :online_ordering_checkout
	get "dat-hang-truc-tuyen/dat-hang-thanh-cong.html" => "frontend/online_ordering#summary", as: :online_ordering_summary
	# END ONLINE ORDERING

	# START INFORMATION
	get "gioi-thieu.html" => "frontend/information#about_us", as: :about_us #add sitemap
	get "gop-y-lien-he.html" => "frontend/information#contact_us", as: :contact_us #add sitemap
	post "gop-y-lien-he.html" => "frontend/information#contact_us"
	
	get "huong-dan-mua-hang.html" => "frontend/information#policy_01", as: :policy_01 #add sitemap
	get "chinh-sach-bao-hanh.html" => "frontend/information#policy_02", as: :policy_02 #add sitemap
	get "huong-dan-thanh-toan.html" => "frontend/information#policy_03", as: :policy_03 #add sitemap
	get "van-chuyen-va-giao-nhan.html" => "frontend/information#policy_04", as: :policy_04 #add sitemap
	get "doi-tra-va-hoan-tien.html" => "frontend/information#policy_05", as: :policy_05 #add sitemap
	get "bao-mat-thong-tin.html" => "frontend/information#policy_06", as: :policy_06 #add sitemap
	get "quy-che-hoat-dong.html" => "frontend/information#policy_07", as: :policy_07 #add sitemap
	get "dieu-khoan-giao-dich.html" => "frontend/information#policy_08", as: :policy_08 #add sitemap
	get "cau-hoi-thuong-gap.html" => "frontend/information#policy_09", as: :policy_09 #add sitemap
	# END INFORMATION

	# START BRAND
	get "thuong-hieu-san-pham-select2.html" => "frontend/brand#select2", as: :brand_select2
	get "thuong-hieu-san-pham.html" => "frontend/brand#listing", as: :brand_listing #add sitemap
	get "thuong-hieu-san-pham(/:brand_id)(/:title).html" => "frontend/brand#detail", as: :brand_detail #add sitemap
	# END BRAND

	# START OTHER SERVICES
	get "dich-vu-sua-chua-bao-tri.html" => "frontend/services#computer_services", as: :computer_services #add sitemap
	get "thi-cong-ha-tang-mang.html" => "frontend/services#network_services", as: :network_services #add sitemap
	# END OTHER SERIES

	get "top-right-menu.html" => "frontend/home#top_right_menu", as: :top_right_menu
	get "autosearch" => "frontend/product#autosearch", as: :autosearch
	get "tim-kiem.html" => "frontend/product#search", as: :search
	get "district-select-box.html" => "frontend/area#district_select", as: :district_select
	match "/404", :to => "frontend/error#not_found", :via => :all
	get "category-box" => "frontend/home#category_box", as: :category_box
	get "/auth/failure" => "frontend/home#auth_failure", as: :auth_failure
	
	# PRODUCTS SELLERS
	get "tat-ca-hinh-anh-sp/:title/:hkerp_id.html" => "frontend/product#images", as: :front_end_hkerp_images
	get "hinh-anh-sp/:title/:image_id(/:type).html" => "frontend/product#image", as: :front_end_hkerp_image
	
	# API PRODUCT INFO
	get "api/product-info/:id" => "frontend/product#api_info", as: :api_product_info
end