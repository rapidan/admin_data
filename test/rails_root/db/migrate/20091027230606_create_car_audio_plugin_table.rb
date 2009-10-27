class CreateCarAudioPluginTable < ActiveRecord::Migration
  def self.up

    create_table(:woofers) do |t|
      t.string :name,           :null => false
      t.string :trademark,      :null => false
      t.integer :power,         :null => false
      t.integer :min_frec
      t.integer :max_frec

      t.timestamps
    end


  end

  def self.down
    drop_table :woofer
  end

end
