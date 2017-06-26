class CreateClinicTable < ActiveRecord::Migration[5.1]
  def change
              create_table :clinics do |t|
            t.string :name
            t.string :address
        end
  end
end
