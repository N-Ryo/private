class AddPictureToDirectMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :direct_messages, :picture, :string
  end
end
