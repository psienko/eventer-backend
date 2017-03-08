class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :event_type
      t.string :name, null: false
      t.datetime :start_at
      t.datetime :end_at
      t.string :place
      t.string :status, default: 'new', null: false

      t.timestamps
    end
  end
end
