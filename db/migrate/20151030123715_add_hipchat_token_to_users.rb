class AddHipchatTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :hipchat_token, :string
  end
end
