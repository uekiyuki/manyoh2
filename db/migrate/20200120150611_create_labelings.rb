class CreateLabelings < ActiveRecord::Migration[5.2]
  def change
    create_table :labelings do |t|
      t.bigint :task_id
      t.bigint :label_id
      # add_index :labelings, :task_id
      # add_index :labelings, :label_id

      t.timestamps
    end
  end
end
