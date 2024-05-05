class AddReadToChat < ActiveRecord::Migration[6.1]
  def change
    add_column :chats, :read, :boolean, default: 'false', null: 'false'
  end
end
