class CreateJoinTableOrdersProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :order_projects do |t|
      t.belongs_to :order
      t.belongs_to :project
    end
  end
end
