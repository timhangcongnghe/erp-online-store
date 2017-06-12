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

    if params[:category_ids].present?
      records = records.where(category_id: params[:category_ids])
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
      options[:AWS_access_key_id] = 'AKIAILNYG24X6XR4UMTQ'
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

  # Amazon find products by keywords
  def self.amazon_find_items_by_keywords(keywords, options={})
    require 'mechanize'

    agent = Mechanize.new
    page = agent.get('https://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%3Daps&field-keywords='+URI::escape(keywords))
    items = []
    page.search("ul#s-results-list-atf li").each do |node|
      if node.css('h2').text.present?
        items << {
          'id' => node.css('a.a-link-normal').first["href"].split('dp/')[1].split('/')[0],
          'name' => node.css('h2').text,
          'thumb' => (node.css('img.s-access-image').first.nil? ? nil : node.css('img.s-access-image').first["src"]),
          'price' => (node.css('span.sx-price-whole').nil? ? nil : node.css('span.sx-price-whole').text),
          'url' => node.css('a.a-link-normal').first["href"]
        }
      end
    end

    {
      items: items,
      total_pages: 1,
      total_entries: items.count,
    }
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
    puts item

    {
      'id' => item["ItemId"],
      'name' => item["Title"],
      'thumb' => item["galleryURL"],
      'price' => item["ConvertedCurrentPrice"]["Value"],
      'url' => item["viewItemURL"],
      'description' => item["Description"].to_s,
      'short_description' => item["ConditionDescription"].to_s,
      'pictures' => item["PictureURL"],
      'category_id' => item["PrimaryCategoryID"],
      #'url' => item["ViewItemURLForNaturalSearch"],
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

  # Ebay find related items
  def self.ebay_find_related_items(eid, options={})
    self.ebay_configure

    per_page = options[:per_page].present? ? options[:per_page] : 5
    page = options[:page].present? ? options[:page] : 1

    item = self.ebay_get_single_item(eid)

    finder = Rebay::Finding.new
    response = finder.find_items_by_category({
      categoryId: item["category_id"],
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
    ebay_item = self.ebay_get_single_item(eid)

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

    {product: product, item: ebay_item}
  end

  # Get ebay related items
  def self.get_ebay_related_items(eid)

  end

  # get amazon product. create new if not exist
  def self.get_amazon_product(eid)
    require 'mechanize'
    include ActionView::Helpers::SanitizeHelper

    product = self.where(amazon_id: eid).first

    if product.nil?
      # create new if not exist
      agent = Mechanize.new
      page = agent.get('https://www.amazon.com/gp/product/'+eid)

      product = self.new
      product.amazon_id = eid
      product.name = page.search('#productTitle').text.strip
      product.short_name = product.name
      product.price = page.search('#priceblock_ourprice').text.strip.gsub('$','').to_f*22000
      product.description = page.search('#productDescription').text.strip.gsub(/<\s*script\s*>([^\<]*)<\s*\/\s*script\s*>/, '')
      product.short_description = page.search('#featurebullets_feature_div').text.strip.gsub(/<\s*script\s*>([^\<]*)<\s*\/\s*script\s*>/, '')

      # brand
      brand = Erp::Products::Brand.where(name: 'Unknown').first
      brand = Erp::Products::Brand.create(name: 'Unknown') if brand.nil?
      product.brand_id = brand.id

      # category
      category = Erp::Products::Category.where(name: 'Amazon.com').first
      category = Erp::Products::Category.create(name: 'Amazon.com') if category.nil?
      product.category_id = category.id

      # picture
      pictures = page.search('body').text.scan(/"large":"([^"]*)"/)
      pictures[0..5].each do |url|
        if url[0].present? and !url[0].empty?
          image = product.product_images.new
          image.remote_image_url_url = url[0]
          image.save!
        end
      end

      product.save
    end

    {product: product, item: {"url" => 'https://www.amazon.com/gp/product/'+eid}}
  end

  # Amazon find related items
  def self.amazon_find_related_items(aid, options={})
    agent = Mechanize.new
    page = agent.get('https://www.amazon.com/gp/product/'+aid)

    page.search('#sp_detail')

    {
      items: nil,
      total_pages: nil,
      total_entries: nil,
    }
  end

  # get all categories with products
  def self.get_related_categories
    Erp::Products::Category.where(id: self.distinct.pluck(:category_id))
  end

  # get all brands with products
  def self.get_related_brands
    Erp::Products::Brand.where(id: self.distinct.pluck(:brand_id))
  end

  ############ OVERIDE METHODS #####################
  # overide search method
  def self.search(params)
    query = self.no_online
    query = self.filter(query, params)

    # order
    if params[:sort_by].present?
      order = params[:sort_by]
      order += " #{params[:sort_direction]}" if params[:sort_direction].present?

      query = query.order(order)
    else
      query = query.order('created_at desc')
    end

    return query
  end

  # no online
  def self.no_online
    self.where(amazon_id: nil).where(ebay_id: nil)
  end

  # no online
  def self.get_active
    self.no_online.where(archived: false)
  end
end
