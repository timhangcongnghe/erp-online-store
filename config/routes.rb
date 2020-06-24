Erp::OnlineStore::Engine.routes.draw do
	get "chuyen-muc(/:category_id)(/:category_name).html" => "frontend/category#detail_301", as: :category_detail_301
	get "san-pham(/:product_id)(/:product_name).html" => "frontend/product#detail_301", as: :product_detail_301
	get "thuong-hieu-san-pham(/:brand_id)(/:brand_name).html" => "frontend/brand#detail_301", as: :brand_detail_301
	
	get "top-right-menu.html" => "frontend/home#top_right_menu", as: :top_right_menu #Disallow robots
	match "/404", :to => "frontend/error#not_found", :via => :all
	
	root to: "frontend/home#index" #add sitemap
	get "/:category_name-cid:category_id" => "frontend/category#detail", as: :category_detail #add sitemap
	get "/:product_name-pid:product_id" => "frontend/product#detail", as: :product_detail #add sitemap
	get "/:brand_name-bid:brand_id" => "frontend/brand#detail", as: :brand_detail #add sitemap
	
	get "thuong-hieu" => "frontend/brand#listing", as: :brand_listing #add sitemap
	get "thuong-hieu-select2" => "frontend/brand#select2", as: :brand_select2
	
	get "category-box" => "frontend/home#category_box", as: :category_box #Disallow robots
	
	get "cat-select2.html" => "frontend/category#select2", as: :category_select2
	post "cat/detail.html" => "frontend/product#product_detail"
	
	get "prod-comment.html" => "frontend/product#comments", as: :product_comments
	post "prod-comment.html" => "frontend/product#comments"
	delete "prod-comment/:comment_id-remove.html" => "frontend/product#delete_comment", as: :delete_product_comment
	
	get "danh-gia-san-pham.html" => "frontend/product#ratings", as: :product_ratings
	post "danh-gia-san-pham.html" => "frontend/product#ratings"
	delete "danh-gia-san-pham/:rating_id-remove.html" => "frontend/product#delete_rating", as: :delete_product_rating
	# END PRODUCT & CATEGORY
	
	get "lua-chon-hang-dau" => "frontend/business_choices#index", as: :business_choices #add sitemap

	# START BLOG
	get "tin-cong-nghe" => "frontend/blog#index", as: :blog #add sitemap
	get "tin-cong-nghe/:blog_id(/:title)" => "frontend/blog#detail", as: :blog_detail #add sitemap
	get "tin-cong-nghe/chu-de/:cat_id(/:title)" => "frontend/blog#index", as: :blog_with_category #add sitemap
	get "binh-luan-bai-viet/:blog_id" => "frontend/blog#comments", as: :blog_comments
	post "binh-luan-bai-viet/:blog_id" => "frontend/blog#comments"
	delete "binh-luan-bai-viet/:comment_id-remove" => "frontend/blog#delete_comment", as: :delete_blog_comment
	# END BLOG

	# START EVENTS
	get "tin-su-kien" => "frontend/events#index", as: :events #add sitemap
	get "tin-su-kien/:event_id(/:title)" => "frontend/events#event_detail", as: :event_detail
	# END EVENTS

	# ACCOUNT
	get "tai-khoan/thong-tin-tai-khoan" => "frontend/account#my_account", as: :my_account
	post "tai-khoan/thong-tin-tai-khoan" => "frontend/account#my_account"
	get "tai-khoan/cap-nhat-mat-khau" => "frontend/account#update_password", as: :update_password
	post "tai-khoan/cap-nhat-mat-khau" => "frontend/account#update_password"
	get "tai-khoan/danh-sach-don-hang" => "frontend/account#order_history", as: :order_history
	get "tai-khoan/chi-tiet-don-hang/:order_id-:title" => "frontend/account#order_information", as: :order_information
	get "tai-khoan/so-dia-chi" => "frontend/account#address_book", as: :address_book
	get "account-contact-form" => "frontend/account#contact_form", as: :account_contact_form
	get "tai-khoan/so-dia-chi/cap-nhat" => "frontend/account#contact_update", as: :account_contact_update
	post "tai-khoan/so-dia-chi/cap-nhat" => "frontend/account#contact_update"
	delete "tai-khoan/:contact_id-remove" => "frontend/account#delete_sub_contact", as: :account_sub_contact_delete

	# START ONLINE ORDERING
	get "topcart" => "frontend/shopping_cart#top_cart", as: :top_cart
	get "gio-hang" => "frontend/shopping_cart#shopping_cart", as: :shopping_cart
	get "dat-hang(/coid-:selected_contact_id)" => "frontend/shopping_cart#checkout", as: :checkout
	post "dat-hang" => "frontend/shopping_cart#checkout"
	delete "dat-hang/:contact_id-remove" => "frontend/shopping_cart#delete_sub_contact", as: :delete_sub_contact
	get "dat-hang/thanh-cong" => "frontend/shopping_cart#success", as: :checkout_completed
	get "dat-hang/dat-hang-nhanh" => "frontend/quick_order#quick_order", as: :quick_order
	post "dat-hang/dat-hang-nhanh" => "frontend/quick_order#quick_order"
	get "tao-moi-lien-he" => "frontend/shopping_cart#add_main_contact", as: :add_main_contact
	post "tao-moi-lien-he" => "frontend/shopping_cart#add_main_contact"
	get "new-contact-form" => "frontend/shopping_cart#contact_form", as: :contact_form
	get "cap-nhat-lien-he" => "frontend/shopping_cart#update_contact", as: :update_contact
	post "cap-nhat-lien-he" => "frontend/shopping_cart#update_contact"
	get "so-sanh-san-pham" => "frontend/shopping_cart#compare_product", as: :compare_product
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

	# START INFORMATION
	get "gioi-thieu" => "frontend/information#about_us", as: :about_us #add sitemap
	get "gop-y-lien-he" => "frontend/information#contact_us", as: :contact_us #add sitemap
	post "gop-y-lien-he" => "frontend/information#contact_us"
	
	get "huong-dan-mua-hang" => "frontend/information#policy_01", as: :policy_01 #add sitemap
	get "chinh-sach-bao-hanh" => "frontend/information#policy_02", as: :policy_02 #add sitemap
	get "huong-dan-thanh-toan" => "frontend/information#policy_03", as: :policy_03 #add sitemap
	get "van-chuyen-va-giao-nhan" => "frontend/information#policy_04", as: :policy_04 #add sitemap
	get "doi-tra-va-hoan-tien" => "frontend/information#policy_05", as: :policy_05 #add sitemap
	get "bao-mat-thong-tin" => "frontend/information#policy_06", as: :policy_06 #add sitemap
	get "quy-che-hoat-dong" => "frontend/information#policy_07", as: :policy_07 #add sitemap
	get "dieu-khoan-giao-dich" => "frontend/information#policy_08", as: :policy_08 #add sitemap
	get "cau-hoi-thuong-gap" => "frontend/information#policy_09", as: :policy_09 #add sitemap

	get "dich-vu-sua-chua-bao-tri" => "frontend/services#computer_services", as: :computer_services #add sitemap
	get "thi-cong-ha-tang-mang" => "frontend/services#network_services", as: :network_services #add sitemap
	
	get "autosearch" => "frontend/product#autosearch", as: :autosearch
	get "search" => "frontend/product#search", as: :search
	get "district-select-box" => "frontend/area#district_select", as: :district_select
	
	get "/auth/failure" => "frontend/home#auth_failure", as: :auth_failure
	
	get "tat-ca-hinh-anh-sp/:title/:hkerp_id.html" => "frontend/product#images", as: :front_end_hkerp_images
	get "hinh-anh-sp/:title/:image_id(/:type).html" => "frontend/product#image", as: :front_end_hkerp_image
	
	get "api/product-info/:id" => "frontend/product#api_info", as: :api_product_info
end