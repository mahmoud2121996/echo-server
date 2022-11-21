class AddDeletionDateToEndpoints < ActiveRecord::Migration[7.0]
  def change
    add_column :endpoints, :deletion_date, :datetime
  end
end
