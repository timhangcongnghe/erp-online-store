class AddAmazonIdToErpProductsProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :erp_products_products, :amazon_id, :string
  end
end