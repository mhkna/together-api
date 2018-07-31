class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :website
      t.string :username
      t.references :round, foreign_key: true

      t.timestamps
    end
  end
end
