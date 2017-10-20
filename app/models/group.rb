class Group < ActiveRecord::Base
  validates :name, presence: true, length: { minimum:5 }
  validates :description, presence: true, length: { minimum:10 }
  validates :user, presence: true 
  belongs_to :user
  has_many :members, dependent: :destroy 
end
