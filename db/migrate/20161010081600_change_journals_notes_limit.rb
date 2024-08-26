class ChangeJournalsNotesLimit < ActiveRecord::Migration[4.2]
  def up
    if ZOGO::Database.mysql?
      max_size = 16.megabytes
      change_column :journals, :notes, :text, :limit => max_size
    end
  end

  def down
    # no-op
  end
end
