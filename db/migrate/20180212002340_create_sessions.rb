class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :sessions do |t|
      t.string :token, index: true
      t.references :user, foreign_key: true
      t.string :agent, default: ''
      t.datetime :expire, index: true

      t.timestamps
    end

  end
end
