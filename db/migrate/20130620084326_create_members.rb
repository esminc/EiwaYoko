class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.string :email
      t.boolean :at_home

      t.timestamps
    end
  end
end
