Erp::Products::Brand.class_eval do
  has_many :products, class_name: 'Erp::Products::Product'
  after_create :create_alias
  
  def create_alias
    name = self.name
    self.update_column(:alias, name.to_ascii.downcase.to_s.gsub(/[^0-9a-z \/\-\.]/i, '').gsub(/[ \/\.]+/i, '-').strip)
  end
  
  def get_name
    return self.name
  end
  
  def self.get_stock_brands
    self.where(id: Erp::Products::Product.get_stock_inventory_products.distinct.pluck(:brand_id))
  end
end
