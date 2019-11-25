Erp::Products::Product.class_eval do
  has_many :accessory_details, class_name: "Erp::Products::AccessoryDetail", dependent: :destroy
  has_many :product_gifts, class_name: "Erp::Products::ProductGift", dependent: :destroy
  
  #THCN Using Start
  
  #get product long name
  def get_long_name
    return self.name
  end
  
  # brand name
  def brand_name
    brand.present? ? brand.name : ''
  end
  
  # category name
  def category_name
    category.present? ? category.name : ''
  end
  
  #get product price
  def product_price
    # not deal
    return self.price if !self.is_deal
    
    # is deal
    from_conds = !self.deal_from_date.present? || (self.deal_from_date.present? && Time.now >= self.deal_from_date.beginning_of_day)
    to_conds = !self.deal_to_date.present? || (self.deal_to_date.present? && Time.now <= self.deal_to_date.end_of_day)
    
    if from_conds && to_conds
      return self.deal_price
    else
      self.update_column(:is_deal, false)
      return self.price
    end
  end
  
  def filter_meta_description
    groups = []
    return [] if self.category.nil?
    self.category.property_groups.each do |group|
      row = {}
      row[:values] = []
      group.properties.where(is_meta_description: true).each do |property|
        values = self.products_values_by_property(property).map {|pv| pv.properties_value.value }
        row[:values] += values if !values.empty?
      end
      groups << row if !row[:values].empty?
    end

    return groups
  end
  
  #THCN Using End
  
  # backend for thcn
  def self.filter(query, params)
    params = params.to_unsafe_hash
    and_conds = []

    # show archived items condition - default: false
    show_archived = false

    #filters
    if params["filters"].present?
      params["filters"].each do |ft|
        or_conds = []
        ft[1].each do |cond|
          # in case filter is show archived
          if cond[1]["name"] == 'show_archived'
            # show archived items
            show_archived = true
          else
            or_conds << "#{cond[1]["name"]} = '#{cond[1]["value"]}'"
          end
        end
        and_conds << '('+or_conds.join(' OR ')+')' if !or_conds.empty?
      end
    end

    #keywords
    if params["keywords"].present?
      params["keywords"].each do |kw|
        or_conds = []
        kw[1].each do |cond|
          or_conds << "LOWER(#{cond[1]["name"]}) LIKE '%#{cond[1]["value"].downcase.strip}%'"
        end
        and_conds << '('+or_conds.join(' OR ')+')'
      end
    end

    # global filter
    global_filter = params[:global_filter]

    if global_filter.present?

      @global_filters = global_filter

      # get categories
      brand_ids = @global_filters[:brands].present? ? @global_filters[:brands] : nil
      @brands = Erp::Products::Brand.where(id: brand_ids)

      # get categories
      category_ids = @global_filters[:categories].present? ? @global_filters[:categories] : nil
      @categories = Erp::Products::Category.where(id: category_ids)
      
      if Erp::Core.available?("warehouses")
        # warehouses
        @warehouses = Erp::Warehouses::Warehouse.all
      end
      # product query
      query = query.where(brand_id: brand_ids) if brand_ids.present?
      query = query.where(category_id: category_ids) if category_ids.present?

    end
    # end// global filter
    
    # join with categories table for search with category
    query = query.joins(:brand)

    # join with categories table for search with category
    query = query.joins(:category)

    # showing archived items if show_archived is not true
    if show_archived == true
      query = query.where(archived: true)
    else
      query = query.where(archived: false)
    end

    query = query.where(and_conds.join(' AND ')) if !and_conds.empty?

    # single keyword
    if params[:keyword].present?
      keyword = params[:keyword].strip.downcase
      keyword.split(' ').each do |q|
        q = q.strip        
        query = query.where('LOWER(erp_products_products.cache_search) LIKE ? OR LOWER(erp_products_products.cache_search) LIKE ? OR LOWER(erp_products_products.cache_search) LIKE ?', q+'%', '% '+q+'%', '%-'+q+'%')
      end
    end

    if Erp::Core.available?("menus")
      # menu id
      if params[:menu_id].present?
        menu = Erp::Menus::Menu.find(params[:menu_id])
        query = query.where(category_id: menu.get_all_related_category_ids)
      end
    end

    return query
  end
  
  def self.search(params)
    query = self.all
    query = self.filter(query, params)

    # order
    if params[:sort_by].present?
      order = params[:sort_by]
      order += " #{params[:sort_direction]}" if params[:sort_direction].present?

      query = query.order(order)
    else
      query = query.order('erp_products_products.created_at desc')
    end

    return query
  end
  # end backend for thcn
  
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

  def count_keywords_arr
    arr = self.meta_keywords.split(', ') if self.meta_keywords.present?
    return arr.count
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
      #'url' => item["viewItemURL"],
      'description' => item["Description"].to_s,
      'short_description' => item["ConditionDescription"].to_s,
      'pictures' => item["PictureURL"],
      'category_id' => item["PrimaryCategoryID"],
      'url' => item["ViewItemURLForNaturalSearch"],
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
  # def set_order
  def self.set_order(params)
    # order
    if params[:sort_by].present?
      order = params[:sort_by]
      order += " #{params[:sort_direction]}" if params[:sort_direction].present?

      query = self.order(order)
    else
      query = self.order('created_at desc')
    end

    return query
  end

  # overide search method
  def self.search(params)
    query = self.no_online
    query = self.filter(query, params)

    return query.set_order(params)
  end

  # no online
  def self.no_online
    self.where(amazon_id: nil).where(ebay_id: nil)
  end

  # no online
  def self.not_sold_out
    self.where(is_sold_out: false)
  end

  # no online
  def self.get_active_with_sold_out
    self.no_online.where(archived: false)
  end

  # no online
  def self.get_active
    self.get_active_with_sold_out.not_sold_out
  end

  # no online
  def self.get_stock_inventory_products
    self.get_active_with_sold_out.where(is_stock_inventory: true)
  end

  #@todo HK-ERP connector
  has_one :hkerp_product, dependent: :destroy

  def updateHkerpInfo(pid)
    url = ErpSystem::Application.config.hkerp_endpoint + "products/erp_get_info?id=" + pid.to_s
    uri = URI(url)
    begin
      res = Net::HTTP.get_response(uri)
    rescue
    end

    if res.is_a?(Net::HTTPSuccess)
      data = JSON.parse(res.body)

      if self.hkerp_product.nil?
        self.hkerp_product = Erp::Products::HkerpProduct.new(
          hkerp_product_id: data["id"],
          price: data["price"],
          stock: data["stock"],
          data: res.body
        )
      else
        self.hkerp_product.update_attributes(
          hkerp_product_id: data["id"],
          price: data["price"],
          stock: data["stock"],
          data: res.body
        )
      end

      self.price = data["price"]
      self.name = data["name"] if !self.name.present?
      self.code = data["product_code"] if !self.code.present?
    end
  end
  
  def getHkerpInfo
    return {} if !hkerp_product.present?
    
    pid = self.hkerp_product.hkerp_product_id
    
    url = ErpSystem::Application.config.hkerp_endpoint + "products/erp_get_info?id=" + pid.to_s
    uri = URI(url)
    begin
      res = Net::HTTP.get_response(uri)
    rescue
    end

    if res.is_a?(Net::HTTPSuccess)
      data = JSON.parse(res.body)
      return data
    else
      return {}
    end
  end

  after_create :hkerp_set_imported
  after_create :hkerp_set_cache_thcn_url
  after_save :hkerp_set_cache_thcn_url
  after_save :hkerp_set_cache_thcn_properties
  after_save :hkerp_update_price
  after_save :hkerp_set_sold_out
  before_destroy :hkerp_set_not_imported

  def hkerp_update_price(force=false)
    if self.hkerp_product.present?
      if force
        self.update_column(:price, self.hkerp_product.price)
      end
      if self.price.to_f == self.hkerp_product.get_data["price"].to_f
        url = ErpSystem::Application.config.hkerp_endpoint + "products/erp_price_update"

        uri = URI(url)
        Net::HTTP.post_form(uri, 'id' => self.hkerp_product.hkerp_product_id)
      end
    end
  end

  def hkerp_set_imported
    if self.hkerp_product.present?
      url = ErpSystem::Application.config.hkerp_endpoint + "products/erp_set_imported"

      uri = URI(url)
      Net::HTTP.post_form(uri, 'id' => self.hkerp_product.hkerp_product_id)

      self.product_images.where(image_url: nil).destroy_all
    end
  end

  def hkerp_set_not_imported
    if self.hkerp_product.present?
      url = ErpSystem::Application.config.hkerp_endpoint + "products/erp_set_imported"

      uri = URI(url)
      Net::HTTP.post_form(uri, 'id' => self.hkerp_product.hkerp_product_id, 'value' => 'false')

      self.product_images.where(image_url: nil).destroy_all
    end
  end

  def hkerp_set_sold_out
    if self.hkerp_product.present?
      url = ErpSystem::Application.config.hkerp_endpoint + "products/erp_set_sold_out"

      uri = URI(url)
      Net::HTTP.post_form(uri, 'id' => self.hkerp_product.hkerp_product_id, 'value' => self.is_sold_out)

      self.product_images.where(image_url: nil).destroy_all
    end
  end

  def hkerp_set_cache_thcn_url
    if self.hkerp_product.present?
      url = ErpSystem::Application.config.hkerp_endpoint + "products/erp_set_cache_thcn_url"

      uri = URI(url)
      Net::HTTP.post_form(uri, 'id' => self.hkerp_product.hkerp_product_id, 'url' => "http://timhangcongnghe.com/san-pham/#{self.id}/#{self.alias}.html")

      self.product_images.where(image_url: nil).destroy_all
    end
  end

  def hkerp_set_cache_thcn_properties
    result = {short: nil, long: []}

    # Long
    self.product_values_array.each do |group|
      result[:long] << {
        group: group[:group].name,
        properties: group[:properties]
      }
    end

    # Short
    result[:short] = self.product_short_descipriton_values_array

    data = result.to_json

    if self.hkerp_product.present?
      url = ErpSystem::Application.config.hkerp_endpoint + "products/erp_set_cache_thcn_properties"
      uri = URI(url)
      Net::HTTP.post_form(uri, 'id' => self.hkerp_product.hkerp_product_id, 'data' => data)
    end
  end

  # set is sold out
  def check_is_sold_out
    update_attributes(is_sold_out: true)
  end

  def uncheck_is_sold_out
    update_attributes(is_sold_out: false)
  end
  ##########################
  
  def self.check_hkerp_product_imported(pid)
    if Erp::Products::HkerpProduct.where(hkerp_product_id: pid).empty?
      url = ErpSystem::Application.config.hkerp_endpoint + "products/erp_set_imported"

      uri = URI(url)
      Net::HTTP.post_form(uri, 'id' => pid, 'value' => 'false')
    end
  end
end
