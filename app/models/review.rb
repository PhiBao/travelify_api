# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  booking_id :integer
#  hearts     :integer
#  body       :text
#  state      :boolean          default("true")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_reviews_on_booking_id  (booking_id)
#

class Review < ApplicationRecord
  paginates_per Settings.reviews_per
  enum state: { appear: true, hide: false }

  belongs_to :booking
  has_many :actions, as: :target, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :hearts, presence: true
  validates :body, length: { maximum: 2000 }
  
  def likes
    self.actions.like.size
  end

  def user
    self.booking.user
  end
end
