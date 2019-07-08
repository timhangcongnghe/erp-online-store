class AddSpecsToErpProductsProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :erp_products_products, :specs, :text
  end
end
