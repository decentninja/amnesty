class AddExpiredToPrivilegeAssignments < ActiveRecord::Migration
  def change
    add_column :privilege_assignments, :expires, :date
  end
end
