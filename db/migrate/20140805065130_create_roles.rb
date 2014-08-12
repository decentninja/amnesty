class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.integereger :detault_term_end

      t.timestamps
    end
  end
end
