class CreateNews < ActiveRecord::Migration
  def up
    create_table :news do |t|
      t.column :title, :string, :limit=> 300
      t.column :description, :string, :limit=> 3000
      t.column :user_id, :integer, :default=> nil
      t.timestamps
    end

    News.create(:title =>'test1', :description => 'test1')
    News.create(:title =>'test2', :description => 'test2')
    News.create(:title =>'test3', :description => 'test3')
    News.create(:title =>'test4', :description => 'test4')
    News.create(:title =>'test5', :description => 'test5')
  end

  def down
    drop_table :news
  end
end
