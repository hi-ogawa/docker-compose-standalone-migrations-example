class CreateUserTable < ActiveRecord::Migration
  def up
    # create_table :user, id: false do |t|
    #   t.text :email
    #   t.text :password
    # end

    execute <<-SQL
create table "user"(
  "email" text,
  "password" text
)
SQL
  end

  def down
    # drop_table :user

    execute <<-SQL
drop table "user"
SQL
  end
end
