class CreateRoleAssignments < ActiveRecord::Migration
  def change
    create_table :role_assignments do |t|
      t.date :expires
      t.integereger :role_id
      t.integereger :student_id

      t.timestamps
    end

    add_index :role_assignments, :role_id
    add_index :role_assignments, :student_id
  end
end
