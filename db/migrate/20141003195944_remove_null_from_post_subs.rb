class RemoveNullFromPostSubs < ActiveRecord::Migration
  def change
    change_column :post_subs, :post_id, :integer, null: true
  end
end
