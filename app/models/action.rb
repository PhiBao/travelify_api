# == Schema Information
#
# Table name: actions
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  scope       :integer
#  target_type :string
#  target_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_actions_on_target_type_and_target_id  (target_type,target_id)
#  index_actions_on_user_id                    (user_id)
#

class Action < ApplicationRecord
  enum scope: { upvote: 1, downvote: 2, mark: 3 }

  belongs_to :target, polymorphic: true
  belongs_to :user

  validates :scope, presence: true
  validates :user, uniqueness: { scope: :target }, if: Proc.new { |obj| obj.mark? || (obj.upvote? || obj.downvote?) }
end
