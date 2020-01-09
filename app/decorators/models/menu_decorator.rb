Erp::Menus::Menu.class_eval do
  def get_products_with_sold_out
    records = Erp::Products::Product
      .where(category_id: self.get_all_related_category_ids)

    return records
  end
  
  #get menu name
  def get_name
    return self.name
  end
end
