class CreateTwitterUsers < ActiveRecord::Migration
  def change
    create_table :twitter_users do |t|
      t.string   :username
      t.datetime :updated_at

      t.timestamps
    end
  end
end
