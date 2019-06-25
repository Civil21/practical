class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.string :name
      t.string :subject
      t.string :client_id
      t.string :text
      t.string :phone
      t.string :stat
      t.string :token

      t.timestamps
    end
  end
end
