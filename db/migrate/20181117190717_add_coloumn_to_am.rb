class AddColoumnToAm < ActiveRecord::Migration[5.2]
  def change
    add_column :activity_monitors, :user_id, :integer
    add_column :activity_monitors, :action, :string
  end
end
