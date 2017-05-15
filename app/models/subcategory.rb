class Subcategory < ApplicationRecord
  has_many :articles

  validates :title, presence: true
end
