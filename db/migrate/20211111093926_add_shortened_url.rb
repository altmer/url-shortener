class AddShortenedUrl < ActiveRecord::Migration[6.1]
  def change
    create_table :shortened_urls do |t|
      t.string :url, null: false
      t.string :hashed_url, null: false
    end

    add_index :shortened_urls, :hashed_url, unique: true
  end
end
