class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content
      t.string :index
      t.string :create

      t.timestamps null: false
    end
  end
end
