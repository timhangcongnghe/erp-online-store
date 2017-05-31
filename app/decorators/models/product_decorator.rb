Erp::Products::Product.class_eval do
  # filter for frontend
  def self.frontend_filter(params={})
    records = self.where("1=1")

    if params[:menu_id].present?
      menu = Erp::Menus::Menu::find(params[:menu_id])
      records = records.where(category_id: menu.get_all_related_category_ids)

      # filter by brand if menu hass brand
      if menu.brand_id.present?
        records = records.where(brand_id: menu.brand_id)
      end
    end

    if params[:brand_ids].present?
      records = records.where(brand_id: params[:brand_ids])
    end

    if params[:brand_id].present?
      records = records.where(brand_id: params[:brand_id])
    end

    if params[:is_business_choises].present?
      records = records.where(is_business_choices: true)
    end

    if params[:is_deal].present?
      records = records.where(is_deal: true)
    end

    if params[:is_bestseller].present?
      records = records.where(is_bestseller: true)
    end

    if params[:sort_by].present?
      records = records.order(params[:sort_by].gsub('_', ' '))
    else
      records = records.order("created_at DESC")
    end

    return records
  end

  # Amazon ECS configuration
  def self.amazon_ecs_configure
    Amazon::Ecs.configure do |options|
      options[:AWS_access_key_id] = 'AKIAINAMNQTAEC66BZRA'
      options[:AWS_secret_key] = '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'
      options[:associate_tag] = 'tag'
    end
  end

  # Amazon ECS item search
  def self.amazon_ecs_item_search
    self.amazon_ecs_configure

    res = Amazon::Ecs.item_search('ruby', {:response_group => 'Medium', :sort => 'salesrank', :search_index => 'All'})

    puts res.items
  end

  # Ebay configuration
  def self.ebay_configure
    Rebay::Api.configure do |rebay|
      rebay.app_id = 'LuanPham-TimHangC-PRD-b08fa563f-518253e8'
    end
  end

  # Ebay item search
  def self.ebay_get_single_item(item_id)
    self.ebay_configure

    finder = Rebay::Shopping.new
    item = finder.get_single_item({:ItemID => item_id, IncludeSelector: "Description,Details"}).response["Item"]
    {
      'id' => item["ItemId"],
      'name' => item["Title"],
      'thumb' => item["galleryURL"],
      'price' => item["ConvertedCurrentPrice"]["Value"],
      'url' => item["viewItemURL"],
      'description' => item["Description"].to_s,
      'short_description' => item["ConditionDescription"].to_s,
      'pictures' => item["PictureURL"]
    }
  end

  # Ebay find products by keywords
  def self.ebay_find_items_by_keywords(keywords, options={})
    self.ebay_configure

    per_page = options[:per_page].present? ? options[:per_page] : 5
    page = options[:page].present? ? options[:page] : 1

    finder = Rebay::Finding.new
    response = finder.find_items_by_keywords({
      :keywords => keywords,
      'paginationInput.entriesPerPage' => per_page,
      'paginationInput.pageNumber' => page,
    }).response

    return [] if response["searchResult"]["item"].nil?

  {
    items: response["searchResult"]["item"].map { |item| self.ebay_item_map(item) },
    total_pages: response["paginationOutput"]["totalPages"],
    total_entries: response["paginationOutput"]["totalEntries"],
  }
  end

  # Ebay item map
  def self.ebay_item_map(item)
    {
      'id' => item["itemId"],
      'name' => item["title"],
      'thumb' => item["galleryURL"],
      'price' => item["sellingStatus"]["currentPrice"]["__value__"],
      'url' => item["viewItemURL"]
    }
  end

  # get ebay product. create new if not exist
  def self.get_ebay_product(eid)
    include ActionView::Helpers::SanitizeHelper

    product = self.where(ebay_id: eid).first

    if product.nil?
      # create new if not exist
      ebay_item = self.ebay_get_single_item(eid)

      product = self.new
      product.ebay_id = eid
      product.name = ebay_item["name"]
      product.short_name = ebay_item["name"]
      product.price = ebay_item["price"].to_f*22000
      product.description = ebay_item["description"].gsub(/<\s*script\s*>([^\<]*)<\s*\/\s*script\s*>/, '')
      product.short_description = ebay_item["short_description"]

      # brand
      brand = Erp::Products::Brand.where(name: 'Unknown').first
      brand = Erp::Products::Brand.create(name: 'Unknown') if brand.nil?
      product.brand_id = brand.id

      # category
      category = Erp::Products::Category.where(name: 'Ebay.com').first
      category = Erp::Products::Category.create(name: 'Ebay.com') if category.nil?
      product.category_id = category.id

      # picture
      ebay_item["pictures"] = [ebay_item["pictures"].to_s] if !ebay_item["pictures"].kind_of?(Array)
      ebay_item["pictures"].each do |url|
        image = product.product_images.new
        image.remote_image_url_url = url
        image.save!
      end

      product.save
    end

    product
  end
end
