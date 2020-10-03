class CreateSpinaArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :spina_articles do |t|
      t.boolean :draft, default: true
      t.date :publish_date
      t.integer :image_id
      t.string :author
      t.string :seo_description
      t.string :seo_title
      t.string :slug
      t.string :title
      t.text :body
      t.text :teaser

      t.timestamps
    end
  end
end
