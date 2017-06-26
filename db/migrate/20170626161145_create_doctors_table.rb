class CreateDoctorsTable < ActiveRecord::Migration[5.1]
  def change
        create_table :doctors do |t|
            t.string :clinic_id
            t.string :name
            t.string :speciality
            t.datetime :created_at
        end
  end
end
