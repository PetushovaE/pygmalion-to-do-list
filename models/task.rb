class Task < ActiveRecord::Base
  belongs_to :user
  has_many :lists
  
  validates_presence_of :name, :subject
end
