Erp::Products::Category.class_eval do
  def self.get_stock_categories
    self.where(id: Erp::Products::Product.get_stock_inventory_products.distinct.pluck(:category_id))
  end
end
