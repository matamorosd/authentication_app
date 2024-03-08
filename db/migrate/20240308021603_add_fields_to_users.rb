class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :image_url, :string
    add_column :users, :dob, :date
    add_column :users, :phone, :string
  end
end
