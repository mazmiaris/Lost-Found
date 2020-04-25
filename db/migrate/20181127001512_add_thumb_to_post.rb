class AddThumbToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :thumb, :string
  end
end
