class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :review_text
      t.integer :rating
      t.integer :video_id
      t.integer :user_id
      t.timestamps
    end
  end
end
