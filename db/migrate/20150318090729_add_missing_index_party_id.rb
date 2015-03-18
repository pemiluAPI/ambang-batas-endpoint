class AddMissingIndexPartyId < ActiveRecord::Migration
  def change
    add_index :tresholds, :party_id
  end
end
