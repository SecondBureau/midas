class CreateToAccountants < ActiveRecord::Migration
  def change
    create_table :to_accountants do |t|
      t.string :label

      t.timestamps
    end
  end
end
