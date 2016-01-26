class AddValuesToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :name, :string
    add_column :tournaments, :location, :string
    add_column :tournaments, :start_time, :datetime
  end
end
