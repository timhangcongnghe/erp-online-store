Erp::Products::Product.class_eval do
  has_many :accessory_details, class_name: "Erp::Products::AccessoryDetail", dependent: :destroy
  has_many :product_gifts, class_name: "Erp::Products::ProductGift", dependent: :destroy
  
  mount_uploader :datasheet, Erp::Products::DatasheetProductUploader
  
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
    query = self.all
    query = self.filter(query, params)

    return query.set_order(params)
  end

  # no online
  def self.not_sold_out
    self.all.where(is_sold_out: false)
  end

  # no online
  def self.get_active_with_sold_out
    self.all.where(archived: false)
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

def hkerp_update_imported
    #if self.hkerp_product.present?
      url = ErpSystem::Application.config.hkerp_endpoint + "products/erp_set_imported"

      uri = URI(url)
      Net::HTTP.post_form(uri, 'id' => self.hkerp_product.hkerp_product_id, 'value' => self.hkerp_product.present?.to_s)

      self.product_images.where(image_url: nil).destroy_all
    #end
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
      Net::HTTP.post_form(uri, 'id' => self.hkerp_product.hkerp_product_id, 'url' => "https://timhangcongnghe.com/san-pham/#{self.id}/#{self.alias}.html")

      self.product_images.where(image_url: nil).destroy_all
    end
  end

  def hkerp_set_cache_thcn_properties
    result = {short: nil, long: []}
    # Long
    self.product_values_array.each do |group|
      if group[:group].show_name.present?
        result[:long] << {
          group: group[:group].get_show_name,
          properties: group[:properties]
        }
      else
        result[:long] << {
          group: group[:group].get_name,
          properties: group[:properties]
        }
      end
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
  
  #Start THCN
  after_save :save_meta_description
  after_save :save_short_description
  after_create :create_alias
  
  def get_long_name
    return self.name
  end
  
  def get_short_name
    return self.short_name
  end
  
  def brand_name
    brand.present? ? brand.name : ''
  end
  
  def category_name
    category.present? ? category.name : ''
  end
  
  def product_price
    return self.price if !self.is_deal
    from_conds = !self.deal_from_date.present? || (self.deal_from_date.present? && Time.now >= self.deal_from_date.beginning_of_day)
    to_conds = !self.deal_to_date.present? || (self.deal_to_date.present? && Time.now <= self.deal_to_date.end_of_day)
    if from_conds && to_conds
      return self.deal_price
    else
      self.update_column(:is_deal, false)
      return self.price
    end
  end
  
  def create_alias
    if self.short_name.present?
      name = self.short_name
    else
      name = self.name
    end
    self.update_column(:alias, name.to_ascii.downcase.to_s.gsub(/[^0-9a-z \/\-\.]/i, '').gsub(/[ \/\.]+/i, '-').strip)
  end

  def get_meta_description
    data = []
    if self.brand.present?
       data << self.brand.name
    end
    self.category.property_groups.each do |group|
      group.properties.where(is_meta_description: true).each do |property|
        values = self.products_values_by_property(property).map {|pv| pv.properties_value.value }
        data += values if !values.empty?
      end
    end
    return data.join(' ')
  end
  
  def save_meta_description
    str = self.get_meta_description
    self.update_columns(meta_description: str)
  end
  
  def get_short_description
    data = []
    self.category.property_groups.each do |group|
      group.properties.where(is_short_description: true).each do |property|
        values = self.products_values_by_property(property).map {|pv| pv.properties_value.value }
        data += values if !values.empty?
      end
    end
    return data.join(' - ')
  end
  
  def save_short_description
    str = self.get_short_description
    self.update_columns(short_description: str)
  end
  
  def product_values_array
    groups = []
    self.category.property_groups.each do |group|
      row = {}
      row[:group] = group
      row[:properties] = []
      group.properties.each do |property|
        row2 = {}
        row2[:property] = property
        row2[:values] = self.products_values_by_property(property).map {|pv| pv.properties_value.value }

        row[:properties] << row2 if !row2[:values].empty?
      end
      groups << row if !row[:properties].empty?
    end
    return groups
  end
  
  def product_short_descipriton_values_array
    groups = []
    return [] if self.category.nil?
    self.category.property_groups.each do |group|
      row = {}
      if group.show_name.present?
        row[:name] = group.get_show_name
      else
        row[:name] = group.get_name
      end
      row[:values] = []
      group.properties.where(is_show_detail: true).each do |property|
        values = self.products_values_by_property(property).map {|pv| pv.properties_value.value }
        row[:values] += values if !values.empty?
      end
      groups << row if !row[:values].empty?
    end
    return groups
  end
  
  def ratings_active
    ratings.where(archived: false)
  end
  
  def count_stars
    self.ratings_active.map(&:star)
  end
  
  def average_stars
    (count_stars.empty? ? 0 : count_stars.inject(0, :+).to_f / count_stars.length).round(1)
  end
  
  def percentage_stars(score=0)
    percentage=0
    num = self.ratings_active.where(star: score).count
    if num > 0
      percentage = num*100 / count_stars.length
    end
    return percentage
  end
  #End THCN
end