class AddTimezoneToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :timezone_browser, :string
    add_column :users, :timezone_manual, :string
  end
end
