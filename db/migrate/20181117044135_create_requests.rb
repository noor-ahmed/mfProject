class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.string :description
      t.integer :status
      t.integer :latest_update_by

      t.timestamps
    end
  end
end
