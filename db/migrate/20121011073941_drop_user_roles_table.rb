class DropUserRolesTable < ActiveRecord::Migration
  def up
    drop_table :user_roles
  end

  def down
  end
end
