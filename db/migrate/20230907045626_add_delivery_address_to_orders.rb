class AddDeliveryAddressToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :delivery_address, :string,  null: false, comment:'住所'
  end
end
