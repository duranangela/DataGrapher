class CreateStateNames < ActiveRecord::Migration[5.2]
  def change
    create_table :state_names do |t|
      t.string :name
      t.string :abbr
      t.string :fips

      t.timestamps
    end
  end
end
