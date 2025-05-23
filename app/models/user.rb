
# we made email:string and password_digest:string for User model
# password:string and password_confirmation:string are virtual attributes, automatically added by has_secure_password (from bcrypt gem)
# we are using bcrypt's has_secure_password to hash the password (if password and password_confirmation match) and then store the hash in the password_digest column

class User < ApplicationRecord
  has_secure_password

  # using rails console or rails c, its possible to add a new user without email when there is no validation check
  # this is implemented -- another way to do it is add null:false for the email in the db migration. then run rails db:rollback to undo the last migration, redo by rails db:migrate

  # without this validation, DB will throw an error, instead we are handling it here.
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\z/i, message: "Invalid" }
end
