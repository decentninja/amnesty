class CreatePositionsRoles < ActiveRecord::Migration
  def change
    create_table :positions_roles do |t|
      t.integer :position_id
      t.integer :role_id
    end

    add_index :positions_roles, :position_id
    add_index :positions_roles, :role_id
  end
end
