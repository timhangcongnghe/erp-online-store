Erp::Products::Brand.class_eval do
  has_many :products, class_name: 'Erp::Products::Product'
  def self.get_stock_brands
    self.where(id: Erp::Products::Product.get_stock_inventory_products.distinct.pluck(:brand_id))
  end
end
