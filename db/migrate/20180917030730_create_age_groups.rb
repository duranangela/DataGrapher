class CreateAgeGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :age_groups do |t|
      t.string :group
      t.string :ref_num

      t.timestamps
    end
  end
end
