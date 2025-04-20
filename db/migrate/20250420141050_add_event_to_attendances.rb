class AddEventToAttendances < ActiveRecord::Migration[8.0]
  def change
    add_reference :attendances, :event, null: false, foreign_key: true
  end
end
