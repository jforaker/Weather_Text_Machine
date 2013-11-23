class RemoveSipCodeFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :sip_code
  end
end
