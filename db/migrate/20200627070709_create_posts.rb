class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :kind
      t.string :body
      t.time :span
      t.timestamps
    end
  end
end
