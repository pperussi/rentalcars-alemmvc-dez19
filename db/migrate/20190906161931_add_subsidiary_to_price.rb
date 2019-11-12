class AddSubsidiaryToPrice < ActiveRecord::Migration[5.2]
  def change
    add_reference :prices, :subsidiary, foreign_key: true
  end
end
