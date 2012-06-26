class CreateAnalytics < ActiveRecord::Migration
  def self.up
    create_table :analytics do |t|
      t.references :theme
      t.integer :total_views
      t.integer :avg_time_on_site
      t.integer :new_visitors
      t.text :deep_dive
      t.text :keywords
      t.text :sources
      t.string :time_travel
      t.timestamps
    end
  end

  def self.down
    drop_table :analytics
  end
end
