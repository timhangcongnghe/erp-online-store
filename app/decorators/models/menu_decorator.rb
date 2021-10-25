Erp::Menus::Menu.class_eval do
  after_save :create_alias
  
  def create_alias
    if !self.not_create_link?
      if self.custom_alias.present?
        name = self.custom_alias
      else
        name = self.name
      end
      self.update_column(:alias, name.to_ascii.downcase.to_s.gsub(/[^0-9a-z \/\-\.]/i, '').gsub(/[ \/\.]+/i, '-').strip)
    end
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
  
  def self.is_hot
    self.where(is_hot: true)
  end
  
  def get_products_with_sold_out
    records = Erp::Products::Product
      .where(category_id: self.get_all_related_category_ids)
    return records
  end
  
  def self_and_parent_menus(options={})
    arr = [self]
    father = self.parent
    while father.present?
      arr << father
      father = father.parent
    end
    return arr.reverse
  end
end