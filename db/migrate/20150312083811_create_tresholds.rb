class CreateTresholds < ActiveRecord::Migration
  def change
    create_table :tresholds do |t|
      t.string  :total
      t.string  :precentage
      t.string  :status
      t.string  :party_id
    end
  end
end
