class CreateExpensives < ActiveRecord::Migration[5.2]
  def change
    create_table :expensives do |t|
      t.string :description
      t.float :value
      t.date :date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
