# The current user is the user that is currently logged in
# Will help maintain separate states for all the different users present
class Current < ActiveSupport::CurrentAttributes
  attribute :user
end
