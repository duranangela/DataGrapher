class CreateVoterData < ActiveRecord::Migration[5.2]
  def change
    create_table :voter_data do |t|
      t.string :state
      t.string :age
      t.string :total
      t.string :registered
      t.string :voted

      t.timestamps
    end
  end
end
