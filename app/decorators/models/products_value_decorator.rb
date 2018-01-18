Erp::Products::ProductsValue.class_eval do
  #after_save :hkerp_set_cache_thcn_properties

  #def hkerp_set_cache_thcn_properties
  #  self.product.hkerp_set_cache_thcn_properties if self.product.present?
  #end
end
