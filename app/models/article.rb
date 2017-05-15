class Article < ApplicationRecord
  belongs_to :category
  belongs_to :subcategory

  validates :title, presence: true
  validates :description, presence: true

  has_attached_file :image,
                    styles: { medium: '300x300>', thumb: '150x150>'},
                    default_url: '/images/:style/missing.png'
  validates_attachment_content_type :image, 
                    content_type: ['image/jpeg', 'image/gif', 'image/png']
end
