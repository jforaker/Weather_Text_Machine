class CreateCalls < ActiveRecord::Migration
  def change
    create_table :calls do |t|

      t.timestamps
    end
  end
end
