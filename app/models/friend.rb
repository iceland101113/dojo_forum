class Friend < ApplicationRecord
  belongs_to :user
  belongs_to :friendship, class_name: "User"
end
