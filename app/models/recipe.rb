class Recipe < ApplicationRecord
  # model association
  # saying that this model is dependent or belongs to category
  belongs_to :category

  # validation
  # says that the name field is the only one that doesn't have to be left blank
  validates_presence_of :name
end
