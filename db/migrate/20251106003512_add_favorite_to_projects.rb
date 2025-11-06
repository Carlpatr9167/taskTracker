class AddFavoriteToProjects < ActiveRecord::Migration[8.0]
  def change
    add_column :projects, :favorite, :boolean
  end
end
