class CreateLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :labels do |t|
      t.string :name
      # add_index :labels, :name
      t.timestamps
    end
  end
end
