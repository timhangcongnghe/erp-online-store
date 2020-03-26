Erp::Menus::Menu.class_eval do
  def get_products_with_sold_out
    records = Erp::Products::Product
      .where(category_id: self.get_all_related_category_ids)

    return records
  end
  
  def self.get_active
    self.where(archived: false).order("custom_order ASC")
  end
  
  def self.get_menus
    self.get_active.where(parent_id: nil)
  end
  
  def get_children_array
    arr = []
    self.children.get_active.each do |child_1|
      arr << {menu: child_1, class: 'parent'}
      child_1.children.get_active.each do |child_2|
        arr << {menu: child_2, class: 'child'}
      end
    end
    arr
  end
  
  def get_name
    return self.name
  end
end