class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.references :member, null: false # 外部キー
      t.string :title, null: false
      t.text :body, null: false
      t.datetime :posted_at, null: false
      t.string :status, null: false, default: "draft"

      t.timestamps
    end
  end
end
