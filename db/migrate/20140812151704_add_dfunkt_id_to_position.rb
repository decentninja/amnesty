class AddDfunktIdToPosition < ActiveRecord::Migration
  def change
    add_column :positions, :dfunkt_id, :string
  end
end
