class CreateFeedsUsers < ActiveRecord::Migration
  def self.up
    create_table :feeds_users, :id => false do |t|
      t.references :feed
      t.references :user
    end
  end

  def self.down
    drop_table :feeds_users
  end
end
