class CreateAppointmentsTable < ActiveRecord::Migration[5.1]
  def change
        create_table :appointments do |t|
            t.string :doctor_id
            t.string :patient_id
            t.string :start_datetime
            t.integer :end_datetime
            t.datetime :created_at
        end
  end
end
