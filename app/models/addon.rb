class Addon < ApplicationRecord
  has_one_attached :photo
  has_many :addon_items
  validates :name, :description, presence: true
  # validates :photo, attached: true, content_type: ['image/png', 'image/jpg',
  #                                                  'image/jpeg']
  def first_available_item
    addon_items.find_by(status: :available)
  end
end
