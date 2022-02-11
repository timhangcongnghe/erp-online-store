Erp::OnlineStore::Engine.routes.draw do
	root to: 'frontend/home#index'

  get '/danh-sach-chuyen-muc' => 'frontend/category#index', as: :category
  get '/:category_alias-cid:category_id' => 'frontend/category#list', as: :category_list

  get '/:product_alias-pid:product_id' => 'frontend/product#index', as: :product
  post '/:product_alias-pid:product_id' => 'frontend/product#index'

  get '/danh-sach-thuong-hieu' => 'frontend/brand#list', as: :brand_list
  get '/san-pham-thuong-hieu' => 'frontend/brand#detail', as: :brand_detail

	get '/gio-hang' => 'frontend/order#cart', as: :cart
  get '/dat-hang' => 'frontend/order#checkout', as: :checkout
  get '/dat-hang-thanh-cong' => 'frontend/order#finish', as: :finish
  get '/tra-cuu-don-hang' => 'frontend/order#track', as: :track

  get '/gioi-thieu' => 'frontend/info#about', as: :about
  get '/lien-he' => 'frontend/info#contact', as: :contact
  get '/gui-yeu-cau-bao-hanh' => 'frontend/info#warranty_request', as: :warranty_request
  get '/in-hoa-don-dien-tu' => 'frontend/info#print_invoice', as: :print_invoice

  get '/huong-dan-mua-hang' => 'frontend/guide#shopping', as: :shopping_guide
  get '/huong-dan-thanh-toan' => 'frontend/guide#payment', as: :shopping_payment

  get '/chinh-sach-chung' => 'frontend/privacy#general', as: :general_policy
  get '/chinh-sach-van-chuyen' => 'frontend/privacy#transport', as: :transport_policy
  get '/chinh-sach-bao-hanh' => 'frontend/privacy#warranty', as: :warranty_policy
  get '/chinh-sach-doi-tra-hoan-tien' => 'frontend/privacy#return_refund', as: :return_refund_policy
  get '/chinh-sach-bao-mat-thong-tin-khach-hang' => 'frontend/privacy#information_security', as: :information_security_policy

  get 'search' => 'frontend/frontend/product#search', as: :search

  namespace :frontend do
		resources :carts

		resources :cart_items do
			collection do
				post 'add_to_cart'
				get 'remove_cart_item'
			end
		end
	end
end