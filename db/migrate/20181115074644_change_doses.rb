class ChangeDoses < ActiveRecord::Migration[5.2]
  def change
    change_table :doses do |t|
      t.string :qty_raw
    end
  end
end
