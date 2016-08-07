# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :text             not null
#  user_id    :integer          not null
#  post_id    :integer          not null
#  comment_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
  include Votable
  validates :content, :user_id, :post_id, presence: true

  belongs_to :user
  belongs_to :post
  has_many :comments

  def content_preview
    content.length < 10 ? content : content[0..10] + "..."
  end

end
