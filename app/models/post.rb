# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  include Votable
  validates :subs, :title, :user_id, presence: true

  has_many :post_subs, dependent: :destroy, inverse_of: :post
  has_many :subs, through: :post_subs
  belongs_to :user
  has_many :comments

  def comments_by_parent_id
    result = Hash.new { |h,k| h[k] = [] }

    self.comments.each do |comment|
      result[comment.comment_id] << comment
    end

    result
  end
end
