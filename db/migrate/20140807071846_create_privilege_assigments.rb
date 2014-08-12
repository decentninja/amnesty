class CreatePrivilegeAssigments < ActiveRecord::Migration
  def change
    create_table :privilege_assignments do |t|
      t.integereger :privilege_id
      t.integereger :privileged_id
      t.string :privileged_type
    end
    add_index :privilege_assignments, :privileged_id
    add_index :privilege_assignments, :privilege_id
  end
end
