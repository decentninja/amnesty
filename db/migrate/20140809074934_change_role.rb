class ChangeRole < ActiveRecord::Migration
  def change
    remove_column :roles, :detault_term_end
    add_column :roles, :default_term_end, :integer
  end
end
