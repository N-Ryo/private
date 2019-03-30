class CreateDirectMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :direct_messages do |t|
      t.text :message
      t.references :from, foreign_key:{to_table: :users}
      t.references :to, foreign_key:{to_table: :users}

      t.timestamps
    end
		add_index :direct_messages, [:from_id, :created_at]
  end
end
