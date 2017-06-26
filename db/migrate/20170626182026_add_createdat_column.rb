class AddCreatedatColumn < ActiveRecord::Migration[5.1]
  def change
      add_column :clinics, :created_at, :datetime
  end
end
