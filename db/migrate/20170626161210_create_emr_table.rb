class CreateEmrTable < ActiveRecord::Migration[5.1]
  def change
        create_table :emrs do |t|
            t.string :diagnosis
            t.string :prognosis
            t.datetime :created_at
        end

  end
end
