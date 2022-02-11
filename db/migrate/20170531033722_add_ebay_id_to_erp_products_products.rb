class AddEbayIdToErpProductsProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :erp_products_products, :ebay_id, :string
  end
end