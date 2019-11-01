class CreateChecks < ActiveRecord::Migration[5.2]
  def change
    create_table :checks do |t|
      t.string :suit
      t.integer :number

      t.timestamps
    end
  end
end
