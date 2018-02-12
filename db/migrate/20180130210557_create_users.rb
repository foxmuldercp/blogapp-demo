class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email,          index: true, null: false, unique: true
      t.string :name,           index: true, default: ''
      t.string :password_digest
      t.boolean :disabled,      default: false
      t.boolean :admin,         default: false

      t.timestamps
    end

  end
end
