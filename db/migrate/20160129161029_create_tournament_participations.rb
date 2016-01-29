class CreateTournamentParticipations < ActiveRecord::Migration
  def change
    create_table :tournament_participations do |t|
      t.references :user, index: true, foreign_key: true
      t.references :tournament, index: true, foreign_key: true
      t.string :type

      t.timestamps null: false
    end
  end
end
