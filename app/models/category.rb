class Category < ApplicationRecord
  # model association
  # This says that each category has many recipes
  # dependent_destroy says that this field cannot be left blank
  # this also says category and recipes have a one to many relationship
  has_many :recipes, dependent: :destroy

  # validations
  # validates that the specific attributes listed are not blank
  # in this case, we are making sure that both title and created_by are not to be left blank when we make a new category
  validates_presence_of :title, :created_by
end
