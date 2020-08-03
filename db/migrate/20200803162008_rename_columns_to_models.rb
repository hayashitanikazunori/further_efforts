class RenameColumnsToModels < ActiveRecord::Migration[6.0]
  def change
    rename_column :posts, :kind, :learning_language
    rename_column :posts, :body, :memo
    rename_column :posts, :span, :learned_time

    rename_column :comments, :review, :body
  end
end
