# == Schema Information
#
# Table name: subs
#
#  id          :integer          not null, primary key
#  title       :string           not null
#  description :text             not null
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Sub < ActiveRecord::Base
  validates :title, :description, :user_id, presence: true

  belongs_to :user
  has_many :post_subs, dependent: :destroy
  has_many :posts, through: :post_subs
end
