class Room < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true, uniqueness: { scope: :user }
end
