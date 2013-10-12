class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.string :poster_url
      t.string :origin_url
      t.datetime :published_at
      t.string :guid

      t.timestamps
    end
  end
end
