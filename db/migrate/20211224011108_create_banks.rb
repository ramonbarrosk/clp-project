class CreateBanks < ActiveRecord::Migration[6.1]
  def change
    create_table :banks do |t|
      t.string :name
      t.string :address
      t.string :cnpj
      t.string :phone

      t.timestamps
    end
  end
end
