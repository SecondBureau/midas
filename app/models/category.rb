class Category < ActiveRecord::Base
  attr_accessible :label
  has_many :entries
end
