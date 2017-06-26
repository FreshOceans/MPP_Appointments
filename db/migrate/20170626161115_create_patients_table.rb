class CreatePatientsTable < ActiveRecord::Migration[5.1]
  def change
        create_table :patients do |t|
            t.string :emr_id
            t.string :firstname
            t.string :lastname
            t.datetime :created_at
        end
  end
end
